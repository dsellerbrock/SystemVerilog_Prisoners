module generic_demux #(
    parameter WIDTH   = 1,
    parameter NUMBER  = 2,
    parameter DEFAULT = 1
) (
    input  wire [$clog2(NUMBER)-1:0] sel,
    input  wire [         WIDTH-1:0] mux_in,
    output reg  [  NUMBER*WIDTH-1:0] out      // Packed, not unpacked
);

  integer i;

  always @(*) begin
    for (i = 0; i < NUMBER; i = i + 1) out[i*WIDTH+:WIDTH] = DEFAULT[WIDTH-1:0];
    out[sel*WIDTH+:WIDTH] = mux_in;
  end

endmodule


module generic_mux #(
    parameter NUM_INPUTS = 8,  // Number of inputs
    parameter DATA_WIDTH = 32  // Width of each input
) (
    input wire [$clog2(NUM_INPUTS)-1:0] sel,
    input wire [NUM_INPUTS*DATA_WIDTH-1:0] data_in,  // Packed input array
    output wire [DATA_WIDTH-1:0] data_out
);
  // Extract the selected slice
  assign data_out = data_in[sel*DATA_WIDTH+:DATA_WIDTH];
endmodule


module tb_prisoner_top;
  reg          mux_sel;
  logic        clk;
  reg          rst_n;
  wire         p1_rst_n;
  wire         p2_rst_n;
  reg          start;
  reg   [31:0] key;
  reg   [ 7:0] data_i;
  wire  [ 7:0] data_o;
  wire  [ 7:0] boxes_searched;
  wire         win;
  wire         fail;


  parameter time CLK_PERIOD = 10ns;

  initial begin
    clk    = 0;
    start  = 0;
    key    = 32'h0;
    data_i = 8'h0;
  end

  always #(CLK_PERIOD / 2) clk = ~clk;

  prisoner prisoner1 (
      .clk(clk),
      .rst_n(p1_rst_n),
      .start(start),
      .key(key),
      .data_i(data_i),
      .data_o(data_o),
      .boxes_searched(boxes_searched),
      .win(win),
      .fail(fail)
  );

  prisoner prisoner2 (
      .clk(clk),
      .rst_n(p2_rst_n),
      .start(start),
      .key(key),
      .data_i(data_i),
      .data_o(data_o),
      .boxes_searched(boxes_searched),
      .win(win),
      .fail(fail)
  );

  generic_mux #(
      .DATA_WIDTH(1),
      .NUM_INPUTS(2)
  ) rst_n_mux (
      .sel(mux_sel),
      data_in({p1_rst_n, p2_rst_n}),
      .data_out(rst_n)
  );



  task apply_reset();
    rst_n = 0;
    repeat (2) @(posedge clk);
    rst_n = 1;
  endtask

  task load_key();
    //Transistion from IDLE to LOAD
    @(negedge clk);
    start = 1'b1;

    @(negedge clk);
    data_i = 8'h55;
    key    = 32'hDEADBEEF;

    //transition LOAD to search
    @(negedge clk);
    data_i = 8'h33;
    start  = 1'b0;
  endtask

  initial begin
    apply_reset();
    load_key();
    repeat (100) @(posedge clk);
    $finish;
  end


endmodule
