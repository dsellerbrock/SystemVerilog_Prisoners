// 3 states for boxes
// 001 Load
// 010 output
// 100 Reset

module prisoner_box (
    output reg [7:0] output_data,
    input wire [2:0] state_reg,   
	input wire [7:0] input_data,
    input wire [31:0] guard_key,
    input wire clk
);
reg [7:0] data = 8'h00;


initial begin
	output_data = 8'h00;
end		

always_ff @(posedge clk) begin
    
	if (state_reg == 3'b010) begin
        output_data <= data;
    end 
	
	if (state_reg == 3'b001) begin
        output_data <= 8'h00;
		if (guard_key == 32'hDEADBEEF) begin     
		    data <= input_data;
		end
    end 
	
	if (state_reg ==  3'b100) begin
        data <= 8'h00;
        output_data <= 8'h00;
    end 
	
end
endmodule