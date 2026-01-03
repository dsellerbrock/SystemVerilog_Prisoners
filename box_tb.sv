module tb_box_top;
    logic      clk;
    reg        rst_n;
    reg [31:0] key;
    reg [7:0]  data_i;
    reg [7:0]  data_o;
    
    parameter time CLK_PERIOD = 10ns;
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    box        box1(.clk(clk) , 
                    .rst_n(rst_n) ,
                    .key(key),
                    .data_i(data_i),
                    .data_o(data_o)
                    );
    
    task apply_reset ();
        rst_n <=0 ;
        repeat(2) @(posedge clk);
        rst_n <= 1 ;
    endtask

    task load_key();
        @(negedge clk);
        data_i <= 8'h55;
        
        @(negedge clk);
        key    <= 32'hBEEFDEAD;
        
        @(negedge clk);
        key    <= 32'hDEADBEEF;
    endtask

    initial begin
        apply_reset();
        load_key();
        repeat (5) @(posedge clk);
        $finish;
    end

    
endmodule