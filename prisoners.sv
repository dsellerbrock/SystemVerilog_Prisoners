// 3 states for a prisoner 
// 001 Load
// 010 Compare
// 100 Reset
module prisoners_module (
    output reg fail,
	output reg attempted,
    input wire [7:0] input_data,
    input wire [31:0] guard_key,
    input wire [2:0] state_reg,
    input wire clk
);

reg [7:0] data = 8'h00;
reg found_data = 1'b0;

initial begin
	fail = 0;
	attempted = 0;
end

always_ff @(posedge clk) begin
    if (state_reg == 3'b100) begin
        found_data <= 1'b0;
        data <= 8'h00;
        fail <= 0; 
    end
    
    if (state_reg == 3'b001) begin
        if (guard_key == 32'hCAFEFACE) begin
            data <= input_data;  
        end
    end
    if (state_reg == 3'b010) begin
        if(input_data == data)begin
            found_data <= 1'b1;
            attempted <= 1;
        end
        else  begin
            fail <=1;
            attempted <= 1;
        end
    end
end

endmodule