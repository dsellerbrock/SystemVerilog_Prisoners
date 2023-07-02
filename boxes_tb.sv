`timescale 1ns/1ns
`include "boxes.sv"

module prisoner_box_tb;

//inputs
reg clk;
reg rd_enable;
reg rst;
reg load;
reg [7:0] input_data;
reg [31:0] guard_key;
//outputs
wire [7:0] output_data;


prisoner_box uut(output_data, input_data, guard_key, load, clk, rst, rd_enable);

initial begin
    clk=0;
    rst=0;
    rd_enable=0;
    load=0;
end

always #5 clk=~clk;
initial #60  $finish; 
initial begin
    $dumpfile("prisoner_boxes.vcd");
    $dumpvars(0,prisoner_box_tb);
    #10
    
    rd_enable = 0;
    load = 1;
    guard_key = 32'hDEADBEEF;
    input_data = 8'hAB;
    #10

    guard_key = 32'h00000000;
    input_data = 8'h00;
    load = 0;
    rd_enable = 1;
    #10

    rd_enable=0;
    rst=1;
    guard_key = 32'hDEADBEEF;
    #10 

    rst = 0;
    guard_key = 32'h00000000;
    rd_enable = 1;
    #10 
    $display("Hey it Worked");
end
endmodule