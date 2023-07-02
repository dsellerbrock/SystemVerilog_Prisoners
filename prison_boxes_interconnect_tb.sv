`timescale 1ns/1ns
`include "prison_box_interconnect.sv"

module prisoner_box_interconnect_tb;

//inputs
reg clk;
reg load_prisoners;
reg load_boxes;
reg run;
reg rst;
reg [7:0] select;
reg [7:0] data;
reg [31:0] guard_key;
reg [99:0] random_val_box_used;
reg [99:0] random_val_prisoner_used;
//outputs
wire win;
bit [31:0] variable;

top uut(win,clk, load_prisoners, load_boxes, run, rst, select, data, guard_key);

initial begin
    clk=0;
    rst=0;
    run=0;
    load_prisoners=0;
    load_boxes=0;
end

always #5 clk=~clk;
initial #50000  $finish; 

initial begin
int random_val;
int i;
$dumpfile("prisoner_boxes_interconnect.vcd");
$dumpvars(0,prisoner_box_interconnect_tb);
for(int i = 0; i<100; i = i+1) begin
int j = 47;
$urandom(j);
random_val = $urandom_range(100,1);
$display("i_val=%0d",i);
if(random_val_box_used[random_val] == 1)begin
    i = i-1;
end
else begin
    random_val_box_used[random_val] = 1;
    $display("random_val=%0d",random_val);
    load_prisoners = 0;
    load_boxes = 1;
    guard_key = 32'hDEADBEEF;
    select = i;
    data = random_val;
    #10;
end
load_boxes = 0;
load_prisoners = 0;
data = 8'h00; 
guard_key = 32'h00000000;
select = 0;
#10;
end

for(int i = 0; i<100; i = i+1)begin
int k = 98;
$urandom(k);
random_val = $urandom_range(100,1);
$display("i_val=%0d",i);
if(random_val_prisoner_used[random_val] == 1)begin
    i = i-1;
end
else begin
    random_val_prisoner_used[random_val] = 1;
    $display("random_val=%0d",random_val);
    load_prisoners = 1;
    load_boxes = 0;
    guard_key = 32'hCAFEFACE;
    select = i;
    data = random_val;
    #10;
end
load_boxes = 0;
load_prisoners = 0;
data = 8'h00; 
guard_key = 32'h00000000;
select = 0;
#10;
end
$display("WE DID IT!");
end


endmodule