`timescale 1ns/1ns
`include "prisoners.sv"

module prisoners_tb;

//inputs
reg clk;
reg [2:	0] state_reg;
reg [7:0] input_data;
reg [31:0] guard_key;
//outputs
wire [7:0] data;
wire attempted;

prisoners_module uut(fail, attempted, input_data, guard_key, state_reg, clk);

initial begin
    clk=0;
    state_reg=3'b000;
end

always #5 clk=~clk;
initial #80  $finish; 
initial begin
    $dumpfile("prisoners_tb.vcd");
    $dumpvars(0,prisoners_tb);
    
	#10   
        state_reg = 3'b001;
        guard_key = 32'hCAFEFACE;
        input_data = 8'hEF;
    
	#10   
	    state_reg = 3'b100;
    
	#10
        state_reg = 3'b010;
	    input_data = 8'hEF;

   	#10   
	    state_reg = 3'b100;

	#10 
        state_reg = 3'b001;
        guard_key = 32'hCAFEFACE;
        input_data = 8'hDD; 
 	
	#10
        state_reg = 3'b010;
	    input_data = 8'hDD;


    $display("Hey it Worked");
end
endmodule