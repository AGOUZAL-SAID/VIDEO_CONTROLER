module avalon_intercon(
    input logic clk,
    input logic rst,
      
    // interfaces instantiations
    avalon_if.agent avalon_ifa_vga,
    avalon_if.agent avalon_ifa_stream,
    avalon_if.host  avalon_ifh_sdram
    );

logic sel_vga;

// signals to stop writing in sdram
assign avalon_ifa_stream.waitrequest = sel_vga ? 1 : avalon_ifh_sdram.waitrequest;
assign avalon_ifa_stream.readdata = 'b0;

// connecting the output of the avalon host of the vga to the agent input of sdram
assign  avalon_ifh_sdram.write       = sel_vga ? avalon_ifa_vga.write      : avalon_ifa_stream.write       ;
assign  avalon_ifh_sdram.byteenable  = sel_vga ? avalon_ifa_vga.byteenable : avalon_ifa_stream.byteenable  ;
assign  avalon_ifh_sdram.burstcount  = sel_vga ? avalon_ifa_vga.burstcount : avalon_ifa_stream.burstcount   ;
assign  avalon_ifh_sdram.read        = sel_vga ? avalon_ifa_vga.read       : avalon_ifa_stream.read         ;
assign  avalon_ifh_sdram.address     = sel_vga ? avalon_ifa_vga.address    : avalon_ifa_stream.address      ;
assign  avalon_ifh_sdram.writedata   = sel_vga ? avalon_ifa_vga.writedata  : avalon_ifa_stream.writedata    ;

// connecting the input of the avalon host of the vga to the agent output of sdram
assign  avalon_ifa_vga.readdata      = avalon_ifh_sdram.readdata       ;
assign  avalon_ifa_vga.readdatavalid = avalon_ifh_sdram.readdatavalid  ;  
assign  avalon_ifa_vga.waitrequest   = sel_vga ? avalon_ifh_sdram.waitrequest : 1;

// flag to indicate that the VGA is working on sdram
int reading_counter;
logic vga_busy, not_finish_reading;
int toggled_read_burstcount;

assign vga_busy = (avalon_ifa_vga.read) || not_finish_reading ;

// vga_busy signal control
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        reading_counter <= 5'b0; 
        not_finish_reading <= 1'b0;
    end
    else begin
        if (avalon_ifa_vga.read) reading_counter <= 5'b0;
        else if (avalon_ifh_sdram.readdatavalid) reading_counter <= reading_counter + 5'b1;

        if (avalon_ifa_vga.read) not_finish_reading <= 1'b1;
        else if (reading_counter == toggled_read_burstcount && not_finish_reading) not_finish_reading <= 1'b0;

        if (avalon_ifa_vga.read) toggled_read_burstcount <= avalon_ifa_vga.burstcount;
    end
end

// flag to indicate that the processor is working on sdram

int writing_counter;
logic stream_busy, not_finish_writing;
int toggled_write_burstcount;

assign stream_busy = ((avalon_ifa_stream.write) || not_finish_writing) && !(writing_counter == toggled_write_burstcount);

// vga_busy signal control
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        writing_counter <= 5'b0;
        not_finish_writing <= 1'b0;
    end
    else begin
        if (writing_counter == toggled_write_burstcount) writing_counter <= 5'b0;
        else if (avalon_ifa_stream.write && !avalon_ifa_stream.waitrequest) writing_counter <= writing_counter + 5'b1;

        if (avalon_ifa_stream.write) not_finish_writing <= 1'b1;
        else if (writing_counter == toggled_write_burstcount && not_finish_writing) not_finish_writing <= 1'b0;

        if (avalon_ifa_stream.write && writing_counter == 0) toggled_write_burstcount <= avalon_ifa_stream.burstcount;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if(rst)begin
        sel_vga <= 1;
    end
    else begin
        if(!vga_busy && sel_vga)begin
            sel_vga <= 0;
        end
        else if (vga_busy && !stream_busy && !sel_vga) begin
            sel_vga <= 1;
        end
    end
end

endmodule