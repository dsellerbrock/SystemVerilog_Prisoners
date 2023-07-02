module prisoners_module (
    output reg fail,
    input wire [7:0] input_data,
    input wire [31:0] guard_key,
    input wire load,
    input wire clk,
    input wire rst,
    input wire compare
);
reg [7:0] data = 8'h00;
reg found_data = 1'b0;
always_ff @(posedge clk) begin
    if (!rst && compare) begin
        if(input_data == data)begin
            found_data <= 1'b1;
        end
    end else if (load && guard_key == 32'hCAFEFACE) begin
        data <= input_data;
    end else if (rst && guard_key == 32'hCAFEFACE) begin
        found_data <= 1'b0;
        data <= 8'h00;
        fail <= 0;
    end else if (!found_data && compare) begin
        fail <=1;
    end
end
endmodule