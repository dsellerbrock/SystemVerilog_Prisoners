`include "boxes.sv"
`include "prisoners.sv"
module top(output reg win,
           input wire clk,
		   input wire [2:0] select,
           input wire [2:0] state_reg [2:0],
           input wire [7:0] data,
           input wire [31:0] guard_key);

for(genvar i=0; i<2; i++ )begin
    prisoners_module prisoners(.clk(clk), .guard_key(guard_key), .input_data(data), .state_reg(state_reg[i]));
end

initial begin
    state_reg[0] = 3'b000;
    state_reg[1] = 3'b000;
    state_reg[2] = 3'b000;
end

always_ff @(posedge clk) begin

    if (select) begin
        boxes_load[select] = 1;
	end 

    if (load_prisoners && !load_boxes) begin
        prisoners_load[select] = 1;
	end

    if(load_prisoners&& load_boxes)begin
        boxes_load[select] = 0;
        prisoners_load[select] = 0;
    end

end
endmodule
