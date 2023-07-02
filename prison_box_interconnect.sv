`include "boxes.sv"
`include "prisoners.sv"
module top(output reg win,
           input wire clk,
           input wire load_prisoners,
           input wire load_boxes,
           input wire run,
           input wire rst,
           input wire [7:0] select,
           input wire [7:0] data,
           input wire [31:0] guard_key);
reg prisoners_load[99:0];
reg boxes_load[99:0];
for(genvar i=0; i<100; i++ )begin
    prisoners_module prisoners(.clk(clk), .rst(rst), .guard_key(guard_key), .input_data(data), .load(prisoners_load[i]));
    prisoner_box boxes(.clk(clk), .rst(rst), .guard_key(guard_key), .input_data(data), .load(boxes_load[i]));
end

always_comb begin

    if (load_boxes && !load_prisoners) begin
        boxes_load[select] = 1;
    end else if (load_prisoners && !load_boxes) begin
        prisoners_load[select] = 1;
    end else if(load_prisoners&& load_boxes)begin
        boxes_load[select] = 0;
        prisoners_load[select] = 0;
    end
end
endmodule
