module prisoner_box (
    output reg [7:0] output_data,
    input wire [7:0] input_data,
    input wire [31:0] guard_key,
    input wire load,
    input wire clk,
    input wire rst,
    input wire rd_enable
);
reg [7:0] data = 8'h00;

always_ff @(posedge clk) begin
    if (!rst && rd_enable) begin
        output_data <= data;
    end else if (load && guard_key == 32'hDEADBEEF) begin
        data <= input_data;
    end else if (rst && guard_key == 32'hDEADBEEF) begin
        data <= 8'h00;
        output_data <= 8'h00;
    end else if (!rd_enable) begin
        output_data <= 8'h00;
    end
end
endmodule