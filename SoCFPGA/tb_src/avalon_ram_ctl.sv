
// January 2025
// @brief : avalon ram controller using latency and burst mode for read operations
`default_nettype none
 module avalon_ram_ctl
 #(
    parameter DEPTH   = 1024,
    parameter WIDTH   = 32,
    parameter INIT_FILE = "none"
 )
 (
    avalon_if.agent avalon_ifa
 );

altera_avalon_mm_slave_bfm slave(
                                   .clk(avalon_ifa.clk),
                                    .reset(avalon_ifa.reset),
                                    .avs_clken(),
                                    .avs_waitrequest(avalon_ifa.waitrequest),
                                    .avs_write(avalon_ifa.write),
                                    .avs_read(avalon_ifa.read),
                                    .avs_address(avalon_ifa.address),
                                    .avs_byteenable(avalon_ifa.byteenable),
                                    .avs_burstcount(avalon_ifa.burstcount),
                                    .avs_beginbursttransfer(),
                                    .avs_begintransfer(),
                                    .avs_writedata(avalon_ifa.writedata),
                                    .avs_readdata(avalon_ifa.readdata),
                                    .avs_readdatavalid(avalon_ifa.readdatavalid),
                                    .avs_arbiterlock(),
                                    .avs_lock(),
                                    .avs_debugaccess(),
                                    .avs_transactionid(),
                                    .avs_readresponse(),
                                    .avs_readid(),
                                    .avs_writeresponserequest(1'b0),
                                    .avs_writeresponsevalid(),
                                    .avs_writeresponse(),
                                    .avs_writeid(),
                                    .avs_response()
                                  );
   defparam slave.AV_ADDRESS_W = 32 ;
   defparam slave.AV_BURSTCOUNT_W = 6;
   defparam slave.AV_FIX_READ_LATENCY = 0;
   defparam slave.AV_MAX_PENDING_READS = 1;
   defparam slave.AV_MAX_PENDING_WRITES = 0;

   defparam slave.USE_BEGIN_TRANSFER = 0;
   defparam slave.USE_BEGIN_BURST_TRANSFER = 0;
   defparam slave.PRINT_HELLO = 0;


localparam ADDR_WIDTH = $clog2(DEPTH);
localparam DATA_WIDTH = WIDTH;
localparam ADDR_OFFSET = $clog2(DATA_WIDTH/8);

localparam ADDR_HIGH  = ADDR_WIDTH + ADDR_OFFSET;
localparam ADDR_LOW   = ADDR_OFFSET;


// La mémoire
logic [avalon_ifa.DATA_BYTES-1:0][7:0] mem[0:DEPTH-1];
generate
  if(!(INIT_FILE=="none"))
  begin
      initial
          $readmemh(INIT_FILE, mem, 0, DEPTH - 1);
  end
endgenerate

// L'accès à la mémoire
initial begin
    #5 @(negedge avalon_ifa.reset)
    // Pour debugger...
    //verbosity_pkg::set_verbosity(verbosity_pkg::VERBOSITY_DEBUG);
    slave.init();
    slave.set_interface_wait_time(2,0) ; // 2 cycles de wait states
end

initial begin
    forever begin
    @(slave.signal_command_received);
    slave.pop_command();
    if(slave.get_command_request==avalon_mm_pkg::REQ_READ) begin
        slave.set_response_burst_size(slave.get_command_burst_count) ;
        for(int i=0;i<slave.get_command_burst_count;i++) begin:l0
            automatic int add = slave.get_command_address() >> $clog2(avalon_ifa.DATA_BYTES) ;
            slave.set_response_data(mem[add+i],i) ;
            slave.set_response_latency(0,i) ; // Delay entre 2 données reçues
        end
        slave.set_response_latency($urandom_range(0,5),0) ; // Delai pour la première donnée proche de ce que donnerai la DDR
        slave.push_response();
    end
    if(slave.get_command_request==avalon_mm_pkg::REQ_WRITE) begin:l1
        for(int i=0;i<slave.get_command_burst_count;i++) begin:l0
            automatic int add = slave.get_command_address() >> $clog2(avalon_ifa.DATA_BYTES) ;
            automatic logic [avalon_ifa.DATA_BYTES-1:0] be = slave.get_command_byte_enable(i) ;
            automatic logic [avalon_ifa.DATA_BYTES-1:0][7:0] data  = slave.get_command_data(i) ;
            for(int j=0;j<avalon_ifa.DATA_BYTES;j++)
                if (be[j]) mem[add+i][j] = data[j] ;
        end
    end
end
end

endmodule
