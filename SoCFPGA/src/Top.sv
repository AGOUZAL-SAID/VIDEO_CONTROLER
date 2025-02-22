`default_nettype none

module Top #(parameter  HDISP  = 800, VDISP  = 480 )(
    // Les signaux externes de la partie FPGA
	input  wire  FPGA_CLK1_50,
	input  wire  [1:0]	KEY,
	output logic [7:0]	LED,
	input  wire	 [3:0]	SW,
    // Les signaux du support matériel son regroupés dans une interface
    hws_if.master       hws_ifm,
    // signal of video interface 
    video_if.master video_ifm 

);

//====================================
//  Déclarations des signaux internes
//====================================
  wire        sys_rst;   // Le signal de reset du système
  wire        sys_clk;   // L'horloge système a 100Mhz
  wire        pixel_clk; // L'horloge de la video 32 Mhz

//=======================================================
//  La PLL pour la génération des horloges
//=======================================================

sys_pll  sys_pll_inst(
		   .refclk(FPGA_CLK1_50),   // refclk.clk
		   .rst(1'b0),              // pas de reset
		   .outclk_0(pixel_clk),    // horloge pixels a 32 Mhz
		   .outclk_1(sys_clk)       // horloge systeme a 100MHz
);

//=============================
//  Les bus Avalon internes
//=============================
avalon_if #( .DATA_BYTES(4)) avalon_if_sdram  (sys_clk, sys_rst);
avalon_if #( .DATA_BYTES(4)) avalon_if_stream (sys_clk, sys_rst);
avalon_if #( .DATA_BYTES(4)) avalon_if_vga (sys_clk, sys_rst);


//=============================
//  Le support matériel
//=============================
hw_support hw_support_inst (
    .avalon_ifa (avalon_if_sdram),
    .avalon_ifh (avalon_if_stream),
    .hws_ifm  (hws_ifm),
	.sys_rst  (sys_rst), // output
    .SW_0     ( SW[0] ),
    .KEY      ( KEY )
 );

//=============================
// On neutralise l'interface
// du flux video pour l'instant
//TODO A SUPPRIMER PLUS TARD
//=============================
/*
assign avalon_if_stream.waitrequest = 1'b1;
assign avalon_if_stream.readdata = '0 ;
*/

//=============================
// On neutralise l'interface SDRAM
// pour l'instant
//TODO A SUPPRIMER PLUS TARD
//=============================
/*
assign avalon_if_sdram.write  = 1'b0;
assign avalon_if_sdram.read   = 1'b0;
assign avalon_if_sdram.address = '0  ;
assign avalon_if_sdram.writedata = '0 ;
assign avalon_if_sdram.byteenable = '0 ;
*/

//--------------------------
//------- Code Eleves ------
//--------------------------

logic pixel_rst, ff1, ff2;

`ifdef SIMULATION
  localparam periode_LED1 = 100;
  localparam periode_LED2 =  32;
`else
  localparam periode_LED1 = 100000000;
  localparam periode_LED2 =  32000000;
`endif

int counter1, counter2;

assign LED[0] = KEY[0];

// Clignotement de LED[1] à 1Hz
always_ff @(posedge sys_clk or posedge sys_rst) begin
    if (sys_rst) begin
        LED[1] <= 0;
        counter1 <= 0;
    end
    else if(counter1 == (periode_LED1 - 1))begin
        LED[1] <= ~LED[1];
        counter1 <= 0;
    end
    else begin
        counter1 <= counter1 + 1;
    end
end

// Génération de signal de reset pour pixel_clk
always_ff @(posedge pixel_clk or posedge sys_rst) begin
    if (sys_rst) begin
        ff1 <= 1;
        ff2 <= 1;
    end
    else begin
        ff1 <= 0;
        ff2 <= ff1;
    end
end

assign pixel_rst = ff2;

// Clignotement de LED[1] à 1Hz
always_ff @(posedge pixel_clk or posedge pixel_rst) begin
    if (pixel_rst) begin
        LED[2] <= 0;
        counter2 <= 0;
    end
    else if(counter2 == (periode_LED2 - 1))begin
        LED[2] <= ~LED[2];
        counter2 <= 0;
    end
    else begin
        counter2 <= counter2 + 1;
    end
end

// instantiation of VGA module

vga #(.HDISP(HDISP),.VDISP(VDISP)) vga_inst (
        .pixel_clk(pixel_clk),
        .pixel_rst(pixel_rst),
        .video_ifm(video_ifm),
        .avalon_ifh(avalon_if_vga)
);

avalon_intercon avalon_intercon0(
                                .clk(sys_clk),
                                .rst(sys_rst),
                                .avalon_ifa_vga(avalon_if_vga),
                                .avalon_ifa_stream(avalon_if_stream),
                                .avalon_ifh_sdram(avalon_if_sdram));

endmodule
`default_nettype wire