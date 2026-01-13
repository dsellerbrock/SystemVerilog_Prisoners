module tb_prisoner_top;
  logic        clk;
  reg          rst_n;
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
      .rst_n(rst_n),
      .start(start),
      .key(key),
      .data_i(data_i),
      .data_o(data_o),
      .boxes_searched(boxes_searched),
      .win(win),
      .fail(fail)
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
    //data_i = 8'h33;
    start  = 1'b0;
  endtask

  initial begin
    apply_reset();
    load_key();
    repeat (100) @(posedge clk);
    $finish;
  end


endmodule
