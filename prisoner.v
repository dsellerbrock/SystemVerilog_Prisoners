localparam IDLE   = 3'b000
localparam LOAD   = 3'b001
localparam SEARCH = 3'b010

module prisoner(
           input clk,
           input rst_n,
           input [31:0] key,
           input [7:0] data_i,
           input state,
	   output [7:0] data_o,
	   output [7:0] boxes_searched,
	   output win,
	   output fail
          )
reg [2:0] state;
always @(posedge clk) begin
    if(rst_n) begin
        data_o         <= 8'h00;
	boxes_searched <= 8'd50;
	win            <= 0;
	fail           <= 0;
	state          <= IDLE;
    end
    else begin
        case(state)
            LOAD: begin
		state <= SEARCH
	        if(key == 32'hDEADBEEF) begin
                    data_o <= data_i;
                end
	    end
	    SEARCH: begin
	        state<=IDLE
	    end
	    IDLE: begin
	       state <= LOAD
	    end

        endcase
    end
end
endmodule
