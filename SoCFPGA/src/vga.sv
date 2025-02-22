module vga #(parameter  HDISP  = 800, VDISP  = 480 ) (
      input logic pixel_clk,
      input logic pixel_rst,
      
      // video  interface for a master
      video_if.master video_ifm,
      avalon_if.host avalon_ifh
      );
//  nombre of pixels of each signal
localparam HFP = 40;
localparam HPULSE = 48;
localparam HBP = 40 ;

// nombre of lines of each signal
localparam VFP = 13 ;
localparam VPULSE = 3;
localparam VBP = 29 ;   

// Nb of bits of horizontal counter
localparam Nbits_counter_H = $clog2(HFP + HPULSE + HBP + HDISP);

//Nb of bits of vertical counter
localparam Nbits_counter_V = $clog2(VFP + VPULSE + VBP + VDISP);

// vertical and horizontal counters 
logic [Nbits_counter_H-1:0] horizontal_counter,x;
logic [Nbits_counter_V-1:0] vertical_counter,y  ;
logic read;
logic vertical_blank, horizontal_blank;

// Clock atttachement 
assign video_ifm.CLK = pixel_clk ;


always_ff@(posedge pixel_clk or posedge pixel_rst)begin
    if (pixel_rst) begin
        video_ifm.VS    <= 1 ;
        video_ifm.HS    <= 1 ;
        vertical_blank <= 0;
        horizontal_blank <= 0 ;
        horizontal_counter <= 0 ;
        vertical_counter   <= 0 ;
    end
    else begin
        // control of HS signal
        if(horizontal_counter >=(HFP -1) && horizontal_counter < (HFP + HPULSE -1) )begin
            video_ifm.HS    <= 0 ;    
        end
        else begin
            video_ifm.HS <= 1 ;
        end

        // control of VS signal 
        if(vertical_counter >=(VFP -1) && vertical_counter < (VFP + VPULSE -1) )begin
            video_ifm.VS    <= 0 ;    
        end
        else begin
            video_ifm.VS <= 1 ;
        end

        // control of BLANK SIGNAL
        if (horizontal_counter < (HFP + HPULSE + HBP - 1)) begin
            horizontal_blank  <= 0 ;  
        end
        else if (horizontal_counter == (HFP + HPULSE + HBP + HDISP -1)) begin
            horizontal_blank  <= 0 ; 
        end
        else begin
            horizontal_blank <= 1 ;
        end

        // control of vertical BLANK SIGNAL

        if (vertical_counter < (VFP + VPULSE + VBP - 1)) begin
            vertical_blank  <= 0 ;  
        end
        else if (vertical_counter == (VFP + VPULSE + VBP + VDISP -1) ) begin
            vertical_blank  <= 0 ; 
        end
        else begin
            vertical_blank <= 1 ;
        end

         //control of horizontal counter
        if (horizontal_counter == (HFP + HPULSE + HBP + HDISP -1)) begin
            horizontal_counter <= 0 ; 
        end
        else begin
            horizontal_counter <= horizontal_counter + 1'b1 ;
        end
        
        //control of vertical counter
        if (vertical_counter == (VFP + VPULSE + VBP + VDISP -1)) begin
            vertical_counter <= 0 ; 
        end
        else if (horizontal_counter == (HFP + HPULSE + HBP + HDISP -1)) begin
            vertical_counter <= vertical_counter + 1'b1 ;
        end

    end
end

assign video_ifm.BLANK = vertical_blank && horizontal_blank;

//SDRAM access controler

localparam BURSTSIZE = 32;
logic walmost_full;

assign avalon_ifh.write = 1'b0; // Read only
assign avalon_ifh.byteenable = 4'hf; // Read only
assign avalon_ifh.burstcount = BURSTSIZE; // We use a constant burstcount
assign avalon_ifh.writedata = 32'b0;

// data red verification
int verification_counter;
localparam MAX_ADDRESS = 4 * HDISP * VDISP;

// read signal and address counter
always_ff@(posedge avalon_ifh.clk or posedge avalon_ifh.reset)
begin
    if (avalon_ifh.reset) begin
        avalon_ifh.read <= 1'b0;
        avalon_ifh.address <= 32'd0;
        verification_counter <= BURSTSIZE + 1;
    end
    else
    begin
        if (avalon_ifh.read) verification_counter <= 0;
        else if (avalon_ifh.readdatavalid) verification_counter <= verification_counter + 1;

        if (verification_counter == BURSTSIZE + 1 && !walmost_full && !avalon_ifh.read) avalon_ifh.read <= 1'b1;
        else if (verification_counter == BURSTSIZE && !walmost_full && !avalon_ifh.read) begin
            avalon_ifh.read <= 1'b1;
            if (avalon_ifh.address < MAX_ADDRESS - 4 * BURSTSIZE) avalon_ifh.address <= avalon_ifh.address + BURSTSIZE * 4;
            else avalon_ifh.address <= 0;
        end

        if (avalon_ifh.read && !avalon_ifh.waitrequest) begin
            avalon_ifh.read <= 1'b0;
        end
    end
end

// asynchronous FIFO
localparam DATA_WIDTH = 32;
localparam DEPTH_WIDTH = 8;
localparam ALMOST_FULL_THRESHOLD = (1 << DEPTH_WIDTH) - BURSTSIZE - 1;

logic enable_read;
logic [31:0] data_out;

always_ff@(posedge pixel_clk or posedge pixel_rst) begin
    if (pixel_rst) begin
        enable_read <= 0;
    end
    else if (walmost_full && vertical_blank) enable_read <= 1;
end

async_fifo #(.DATA_WIDTH(DATA_WIDTH),.DEPTH_WIDTH(DEPTH_WIDTH),.ALMOST_FULL_THRESHOLD(ALMOST_FULL_THRESHOLD)) async_fifo_inst (
        .rst(avalon_ifh.reset),
        .rclk(pixel_clk),
        .read(read),
        .rdata(data_out),
        .rempty(),
        .wclk(avalon_ifh.clk),
        .wdata(avalon_ifh.readdata),
        .write(avalon_ifh.readdatavalid),
        .wfull(),
        .walmost_full(walmost_full)
);

assign video_ifm.RGB = data_out[23:0];
assign read = video_ifm.BLANK && enable_read;

endmodule