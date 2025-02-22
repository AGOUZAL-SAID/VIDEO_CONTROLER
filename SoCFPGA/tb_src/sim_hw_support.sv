// Version testbench du module de support
// matériel. Cette version minimaliste
// contient:
// - la génération du reset système a partir de KEY[0]
// - la génération du flux vidéo sur avalon_ifh
// - un modèle d'accès dram sur avalon_ifa
// L'interface HPS est complètement ignorée

module sim_hw_support
(
    avalon_if.agent    avalon_ifa,
    avalon_if.host     avalon_ifh,

    hws_if.master      hws_ifm,

    output logic       sys_rst,
    input  wire        SW_0,
	input  wire  [1:0] KEY
);

// gestion du reset
logic tmp_rst;
always @(posedge avalon_ifa.clk or negedge KEY[0])
    if(!KEY[0])
        {tmp_rst,sys_rst}  <= 2'b11 ;
    else
        {tmp_rst,sys_rst}  <= {1'b0,tmp_rst} ;

// Génération du flux vidéo
// On recoit la vidéo en mode "avalon_stream"
avalon_stream_if avs_if();
video_stream_generator vgen (
    .clk(avalon_ifa.clk), .reset(avalon_ifa.reset),
    .avalon_stream_ifh(avs_if.host)
);

// On la convertit en avalon_mm avec bursts
avlst2mm vtrans(
    .avalon_stream_ifa(avs_if.agent),
    .avalon_ifh(avalon_ifh.host)
);


// Modèle du controleur de RAM
avalon_ram_ctl #( .DEPTH(1024*1024), .WIDTH(32), .INIT_FILE(`IMAGE_FILE)) avalon_ram_ctl_inst ( .avalon_ifa(avalon_ifa));


endmodule


