localparam IDLE = 3'b000;
localparam LOAD = 3'b001;
localparam SEARCH = 3'b010;

module prisoner (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        start,
    input  wire [31:0] key,
    input  wire [ 7:0] data_i,
    output reg  [ 7:0] data_o,
    output reg  [ 7:0] boxes_searched,
    output reg         win,
    output reg         fail
);

  reg [2:0] state;
  reg [7:0] prisoner_num;

  always @(posedge clk) begin
    if (!rst_n) begin
      data_o         <= 8'h00;
      boxes_searched <= 8'd50;
      win            <= 0;
      fail           <= 0;
      state          <= IDLE;
    end else begin
      case (state)
        LOAD: begin
          if (start) begin
            state <= SEARCH;
          end else begin
            state <= LOAD;
          end
          if (key == 32'hDEADBEEF) begin
            prisoner_num <= data_i;
          end
        end

        SEARCH: begin
          if (boxes_searched != 8'd0) begin
            if (data_i == prisoner_num) begin
              win   <= 1;
              state <= IDLE;
            end else begin
              data_o <= data_i;
              state  <= SEARCH;
            end
            boxes_searched <= boxes_searched - 1;
          end else begin
            fail  <= 1;
            state <= IDLE;
          end
        end

        IDLE: begin
          if (start) begin
            state <= LOAD;
          end else begin
            state <= IDLE;
          end
        end

      endcase
    end
  end
endmodule
