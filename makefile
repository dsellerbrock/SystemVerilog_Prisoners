build: 
	iverilog -g2012 -o prison_boxes_interconnect_tb.vvp prison_boxes_interconnect_tb.sv
run:
	vvp prison_boxes_interconnect_tb.vvp   
clean:
	rm prison_boxes_interconnect_tb.vvp
	rm prisoner_boxes_interconnect.vcd