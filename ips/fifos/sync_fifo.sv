// Fifo synchrone
// Attention :Le signal half_full indique
// si la fifo est "AU MOINS" remplie à moitié

module sync_fifo #(
    parameter WIDTH        = 8,
    parameter DEPTH        = 8,
    parameter FULL  = DEPTH,
    parameter ALMOST_FULL  = DEPTH-1,
    parameter HALF_FULL    = DEPTH>>1
)
(
  input         clk,
  input         reset,
  input  [WIDTH-1:0]  wdata,
  input         write,
  input         read,
  output [WIDTH-1:0]  rdata,
  output        empty,
  output        full,
  output        almost_full,
  output        half_full
  );

  localparam AWIDTH = $clog2(DEPTH);

  //reg                full_in = 1'b0;
  reg               empty_in = 1'b1;
  reg   [AWIDTH-1:0]  rd_ptr = '0;
  reg   [AWIDTH-1:0]  wr_ptr = '0;
  reg   [AWIDTH:0]    usedw_in ='0;
  reg   [WIDTH-1:0]  mem[DEPTH-1:0];

  // memory write pointer increment
  always @(posedge clk)
  if(reset)
  begin
      wr_ptr      <= '0;
      mem[wr_ptr] <= '0;
  end
  else if(write && ~full)
  begin
      wr_ptr      <= wr_ptr + 1'b1;
      mem[wr_ptr] <= wdata;
  end

  // memory read pointer increment
  always @(posedge clk or posedge reset)
  if(reset)
      rd_ptr <= '0;
  else if(read && ~empty_in)
      rd_ptr <= rd_ptr + 1'b1;

  // generate full signal
  //always @(posedge clk or posedge reset)
  //if(reset)
  //    full_in <= 1'b0;
  //else if((~read&&write) && ((wr_ptr==rd_ptr-1'b1) || (rd_ptr=='0 && wr_ptr=='1)))
  //    full_in <= 1'b1;
  //else if(full_in && read)
  //  full_in <= 1'b0;

  //generate empty signal
  always @(posedge clk or posedge reset)
  if(reset)
      empty_in <= 1'b1;
  else if((read&&~write) && ((rd_ptr==wr_ptr-1'b1) || (rd_ptr=='1 && wr_ptr=='0)))
      empty_in <= 1'b1;
  else if(empty_in && write)
      empty_in <= 1'b0;

  // generate usedw_in signal
  always @(posedge clk or posedge reset)
  if(reset)
      usedw_in <= '0;
  else if(write && ~read)
      usedw_in <= usedw_in + 1'b1;
  else if(~write && read)
      usedw_in <= usedw_in - 1'b1;

  //assign full  = full_in;
  assign empty = empty_in;
  assign rdata = mem[rd_ptr];

  assign almost_full  = (usedw_in == ALMOST_FULL);
  assign half_full    = (usedw_in >= HALF_FULL);
  assign full    = (usedw_in == FULL);

endmodule

