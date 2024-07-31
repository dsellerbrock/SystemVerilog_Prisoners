`timescale 1ns/1ns
`include "boxes.sv"

module boxes_tb;

//inputs
reg clk;
reg [2:0] state_reg;
reg [7:0] input_data;
reg [31:0] guard_key;
//outputs
wire [7:0] output_data;


prisoner_box uut(output_data, state_reg, input_data, guard_key, clk);

initial begin
    clk=0;
    state_reg = 3'b000;
end

always #5 clk=~clk;

initial #60  $finish; 

initial begin
    $dumpfile("boxes_tb.vcd");
    $dumpvars(0,boxes_tb);
    
	#10   
    state_reg = 3'b001;
    guard_key = 32'hDEADBEEF;
    input_data = 8'hAB;
    
	#10
    state_reg = 3'b100;
    
	#10
    state_reg = 3'b010;
    
	#10
	state_reg = 3'b001; 
    guard_key = 32'hDEADBEEF;
	input_data = 8'hFE;

	#10
	state_reg = 3'b010;

	#10
	state_reg = 3'b100;
    
	#10 
    $display("Hey it Worked");
end
endmodule