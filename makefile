ibuild: 
	iverilog -g2012 -o prison_box_interconnect_tb.vvp prison_box_interconnect_tb.sv
irun:
	vvp prison_box_interconnect_tb.vvp   
iclean:
	rm prison_box_interconnect_tb.vvp
	rm prison_box_interconnect_tb.vcd
vbuild:
	verilator --cc --exe --build -j 12 sim.cpp prison_box_interconnect_tb.sv
vrun:
	./obj_dir/Vprison_box_interconnect_tb
vclean:
	rm -rf obj_dir
plot:
	gtkwave prison_box_interconnect_tb.vcd