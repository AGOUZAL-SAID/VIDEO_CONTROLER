`timescale 1ns/1ns

module ram_tb;

bit clk; 
bit reset;
bit we, re;
logic addr;
logic pio;
logic [31:0] wdata, rdata;

custom_pio
custom_pio_inst(
    clk,
    reset,
    addr,
    re, 
    we, 
    rdata,
    wdata,
    pio
);

always #2 clk = ~clk;

initial begin
   reset = 1'b1;
   #100ns
   reset = 1'b0;
   repeat(500) @(posedge clk);
   we = 1;
   @(posedge clk) we = 0;
   repeat(1000) @(posedge clk);
   we = 1;
   @(posedge clk) we = 0;
   #10000 $finish;
end

endmodule

