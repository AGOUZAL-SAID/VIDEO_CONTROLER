//
// avlst2mm.sv
// @brief :
//     An avalon video stream to avalon-mm bridge
//
`default_nettype none

module avlst2mm
#(
    parameter ADDR_WIDTH   = 32,
    parameter DATA_WIDTH   = 32,
    parameter BURSTCOUNT = 8
)
(
    avalon_stream_if.agent avalon_stream_ifa,
    avalon_if.host avalon_ifh
);


typedef enum {
               WAIT_ID_CTL_DATA,
               RD_CTL_DATA,
               WAIT_START_VIDEO_DATA,
               RD_VIDEO_DATA,
               WAIT_FIFO_HALF_FULL
             } avl_fsm;

avl_fsm r_state;

logic fifo_full;
logic fifo_almost_full;
logic fifo_half_full;


always_ff @(posedge avalon_ifh.clk)
if(avalon_ifh.reset)
begin
    r_state <= WAIT_ID_CTL_DATA;
end
else
    case (r_state)
        WAIT_ID_CTL_DATA:
            // wait for control data packet identifier
            if(avalon_stream_ifa.valid && avalon_stream_ifa.startofpacket && avalon_stream_ifa.data[3:0] == 4'hf)
            begin
                r_state   <= RD_CTL_DATA;
            end

        RD_CTL_DATA:
            // read reamin control data
            if(avalon_stream_ifa.valid && avalon_stream_ifa.endofpacket)
                r_state <= WAIT_START_VIDEO_DATA;

        WAIT_START_VIDEO_DATA:
            // wait for start video datat
            if(avalon_stream_ifa.valid && avalon_stream_ifa.startofpacket && avalon_stream_ifa.data[3:0] == 4'h0)
                r_state <= RD_VIDEO_DATA;

        // Transfer with backpressure
        RD_VIDEO_DATA:
            if (avalon_stream_ifa.valid) begin
                if(fifo_almost_full && !avalon_stream_ifa.endofpacket)
                    r_state <= WAIT_FIFO_HALF_FULL;
                else if(avalon_stream_ifa.endofpacket)
                    r_state <= WAIT_ID_CTL_DATA;
            end

        WAIT_FIFO_HALF_FULL:
            if(!fifo_half_full)
                r_state <= RD_VIDEO_DATA;

        default:
            r_state <= WAIT_ID_CTL_DATA;
    endcase

logic [ADDR_WIDTH-1:0] r_pix_addr;
logic [DATA_WIDTH:0] rdata_eop;

// Envois de paquets de BURSCOUNT pixels présents dans la fifo
logic [5:0] burstcount ;
logic in_burst;
logic first_burst ;

always_ff @(posedge avalon_ifh.clk)
if(avalon_ifh.reset) begin
    burstcount <= 6'(BURSTCOUNT) ;
    in_burst <= 1'b0 ;
    r_pix_addr <=  0  ;
    first_burst <= 1'b1 ;
end
else begin
    if (!in_burst && fifo_half_full) begin
        in_burst <= 1'b1 ;
        if(!first_burst)
            r_pix_addr <= r_pix_addr+BURSTCOUNT*4 ;
        else
            first_burst <= 1'b0 ;
        burstcount <= 6'(BURSTCOUNT) ;
    end
    if (in_burst && !avalon_ifh.waitrequest) begin
        if(burstcount !=1) burstcount <= burstcount-1'b1 ;
        else begin
          in_burst <=0 ;
          if (rdata_eop[32]) begin
              r_pix_addr <= '0 ;
              first_burst <= 1'b1 ;
          end
        end
    end
end


assign avalon_stream_ifa.ready    = r_state == WAIT_ID_CTL_DATA ||
                          r_state == RD_CTL_DATA ||
                          r_state == WAIT_START_VIDEO_DATA ||
                          r_state == RD_VIDEO_DATA && !fifo_almost_full ;

assign avalon_ifh.address    = burstcount==BURSTCOUNT ? r_pix_addr : '0;
assign avalon_ifh.burstcount = burstcount==BURSTCOUNT ? 6'(burstcount) : '0 ;
assign avalon_ifh.writedata  = rdata_eop[DATA_WIDTH-1:0];
assign avalon_ifh.byteenable = 4'hf;
assign avalon_ifh.write      = in_burst ;
assign avalon_ifh.read       = 1'b0;

/// Gestion de la FIFO

wire  fifo_write = (r_state == RD_VIDEO_DATA) && avalon_stream_ifa.valid;
wire  fifo_read  = in_burst && !avalon_ifh.waitrequest ;

// La donnée écrite est le pixel lu + l'info de endofpacket...
logic [DATA_WIDTH:0] wdata_eop;
assign wdata_eop = {avalon_stream_ifa.endofpacket, avalon_stream_ifa.data};

// On veut être sur de disposer d'un burst quand
// on démarre une transaction
sync_fifo
#(
    .WIDTH(DATA_WIDTH+1),
    .DEPTH(2*BURSTCOUNT),
    .HALF_FULL(BURSTCOUNT+1),
    .ALMOST_FULL(2*BURSTCOUNT-2)
)

sync_fifo_i
(
    .clk(avalon_ifh.clk),
    .reset(avalon_ifh.reset),
    .write(fifo_write),
    .wdata(wdata_eop),
    .read(fifo_read),
    .rdata(rdata_eop),
    .full (fifo_full),
    .almost_full (fifo_almost_full),
    .half_full(fifo_half_full),
    .empty()
);

endmodule


