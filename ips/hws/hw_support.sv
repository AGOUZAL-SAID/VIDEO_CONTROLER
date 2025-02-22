// Module de support matériel servant à cacher
// toute la logique environnant le projet
// Pour éviter d'utiliser des blocs de logique
// trop lourds à simuler, une version "simulation"
// différente de celle de la synthèse est proposée.
`default_nettype none
module hw_support
(
    avalon_if.agent    avalon_ifa,
    avalon_if.host     avalon_ifh,

    hws_if.master      hws_ifm,

    output logic       sys_rst,
    input  wire        SW_0,
	input  wire  [1:0] KEY
);

`ifdef SIMULATION
sim_hw_support sim_hw_support0(.*) ;
`else // IFDEF SIMULATION


wire        hps_fpga_reset_n;
wire [1:0]  fpga_debounced_buttons;
wire [7:0]  fpga_led_internal;
wire        fpga_pio_internal;

wire sys_clk = avalon_ifa.clk;
wire custom_resetn = ~fpga_pio_internal && fpga_debounced_buttons[0];

// Interface pour le flux vidéo avalon stream
avalon_stream_if  avlst_src() ;


// Calcul de l'adresse en mémoire
localparam IMAGE_ADDR_0 = 32'h3800_0000;
localparam IMAGE_ADDR_1 = 32'h3817_7000; // adr_0 + (800*480*4);
wire  [31:0] img_addr = SW_0 ? IMAGE_ADDR_1 : IMAGE_ADDR_0;
wire  [29:0] dram_address = 30'((img_addr + avalon_ifa.address)>>2) ;

soc_system
soc_system_inst (
		//Clock&Reset
	  .clk_clk                               (sys_clk ),
	  .reset_reset_n                         (hps_fpga_reset_n ),
	  .clk_video_clk                         (sys_clk),     // video_clk

	  .memory_mem_a                          (hws_ifm.HPS_DDR3_ADDR),
	  .memory_mem_ba                         (hws_ifm.HPS_DDR3_BA),
	  .memory_mem_ck                         (hws_ifm.HPS_DDR3_CK_P),
	  .memory_mem_ck_n                       (hws_ifm.HPS_DDR3_CK_N),
	  .memory_mem_cke                        (hws_ifm.HPS_DDR3_CKE),
	  .memory_mem_cs_n                       (hws_ifm.HPS_DDR3_CS_N),
	  .memory_mem_ras_n                      (hws_ifm.HPS_DDR3_RAS_N),
	  .memory_mem_cas_n                      (hws_ifm.HPS_DDR3_CAS_N),
	  .memory_mem_we_n                       (hws_ifm.HPS_DDR3_WE_N),
	  .memory_mem_reset_n                    (hws_ifm.HPS_DDR3_RESET_N),
	  .memory_mem_dq                         (hws_ifm.HPS_DDR3_DQ),
	  .memory_mem_dqs                        (hws_ifm.HPS_DDR3_DQS_P),
	  .memory_mem_dqs_n                      (hws_ifm.HPS_DDR3_DQS_N),
	  .memory_mem_odt                        (hws_ifm.HPS_DDR3_ODT),
	  .memory_mem_dm                         (hws_ifm.HPS_DDR3_DM),
	  .memory_oct_rzqin                      (hws_ifm.HPS_DDR3_RZQ),
	  .hps_0_hps_io_hps_io_emac1_inst_TX_CLK (hws_ifm.HPS_ENET_GTX_CLK),
	  .hps_0_hps_io_hps_io_emac1_inst_TXD0   (hws_ifm.HPS_ENET_TX_DATA[0] ),
	  .hps_0_hps_io_hps_io_emac1_inst_TXD1   (hws_ifm.HPS_ENET_TX_DATA[1] ),
	  .hps_0_hps_io_hps_io_emac1_inst_TXD2   (hws_ifm.HPS_ENET_TX_DATA[2] ),
	  .hps_0_hps_io_hps_io_emac1_inst_TXD3   (hws_ifm.HPS_ENET_TX_DATA[3] ),
	  .hps_0_hps_io_hps_io_emac1_inst_RXD0   (hws_ifm.HPS_ENET_RX_DATA[0] ),
	  .hps_0_hps_io_hps_io_emac1_inst_MDIO   (hws_ifm.HPS_ENET_MDIO ),
	  .hps_0_hps_io_hps_io_emac1_inst_MDC    (hws_ifm.HPS_ENET_MDC  ),
	  .hps_0_hps_io_hps_io_emac1_inst_RX_CTL (hws_ifm.HPS_ENET_RX_DV),
	  .hps_0_hps_io_hps_io_emac1_inst_TX_CTL (hws_ifm.HPS_ENET_TX_EN),
	  .hps_0_hps_io_hps_io_emac1_inst_RX_CLK (hws_ifm.HPS_ENET_RX_CLK),
	  .hps_0_hps_io_hps_io_emac1_inst_RXD1   (hws_ifm.HPS_ENET_RX_DATA[1] ),
	  .hps_0_hps_io_hps_io_emac1_inst_RXD2   (hws_ifm.HPS_ENET_RX_DATA[2] ),
	  .hps_0_hps_io_hps_io_emac1_inst_RXD3   (hws_ifm.HPS_ENET_RX_DATA[3] ),
	  .hps_0_hps_io_hps_io_sdio_inst_CMD     (hws_ifm.HPS_SD_CMD    ),
	  .hps_0_hps_io_hps_io_sdio_inst_D0      (hws_ifm.HPS_SD_DATA[0]     ),
	  .hps_0_hps_io_hps_io_sdio_inst_D1      (hws_ifm.HPS_SD_DATA[1]     ),
	  .hps_0_hps_io_hps_io_sdio_inst_CLK     (hws_ifm.HPS_SD_CLK   ),
	  .hps_0_hps_io_hps_io_sdio_inst_D2      (hws_ifm.HPS_SD_DATA[2]     ),
	  .hps_0_hps_io_hps_io_sdio_inst_D3      (hws_ifm.HPS_SD_DATA[3]     ),
	  .hps_0_hps_io_hps_io_usb1_inst_D0      (hws_ifm.HPS_USB_DATA[0]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D1      (hws_ifm.HPS_USB_DATA[1]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D2      (hws_ifm.HPS_USB_DATA[2]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D3      (hws_ifm.HPS_USB_DATA[3]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D4      (hws_ifm.HPS_USB_DATA[4]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D5      (hws_ifm.HPS_USB_DATA[5]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D6      (hws_ifm.HPS_USB_DATA[6]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_D7      (hws_ifm.HPS_USB_DATA[7]    ),
	  .hps_0_hps_io_hps_io_usb1_inst_CLK     (hws_ifm.HPS_USB_CLKOUT    ),
	  .hps_0_hps_io_hps_io_usb1_inst_STP     (hws_ifm.HPS_USB_STP    ),
	  .hps_0_hps_io_hps_io_usb1_inst_DIR     (hws_ifm.HPS_USB_DIR    ),
	  .hps_0_hps_io_hps_io_usb1_inst_NXT     (hws_ifm.HPS_USB_NXT    ),
	  .hps_0_hps_io_hps_io_spim1_inst_CLK    (hws_ifm.HPS_SPIM_CLK  ),
	  .hps_0_hps_io_hps_io_spim1_inst_MOSI   (hws_ifm.HPS_SPIM_MOSI ),
	  .hps_0_hps_io_hps_io_spim1_inst_MISO   (hws_ifm.HPS_SPIM_MISO ),
	  .hps_0_hps_io_hps_io_spim1_inst_SS0    (hws_ifm.HPS_SPIM_SS   ),
	  .hps_0_hps_io_hps_io_uart0_inst_RX     (hws_ifm.HPS_UART_RX   ),
	  .hps_0_hps_io_hps_io_uart0_inst_TX     (hws_ifm.HPS_UART_TX   ),
	  .hps_0_hps_io_hps_io_i2c0_inst_SDA     (hws_ifm.HPS_I2C0_SDAT  ),
	  .hps_0_hps_io_hps_io_i2c0_inst_SCL     (hws_ifm.HPS_I2C0_SCLK  ),
	  .hps_0_hps_io_hps_io_i2c1_inst_SDA     (hws_ifm.HPS_I2C1_SDAT  ),
	  .hps_0_hps_io_hps_io_i2c1_inst_SCL     (hws_ifm.HPS_I2C1_SCLK  ),
	  .hps_0_hps_io_hps_io_gpio_inst_GPIO09  (hws_ifm.HPS_CONV_USB_N ),
	  .hps_0_hps_io_hps_io_gpio_inst_GPIO35  (hws_ifm.HPS_ENET_INT_N ),
	  .hps_0_hps_io_hps_io_gpio_inst_GPIO40  (hws_ifm.HPS_LTC_GPIO   ),
	  .hps_0_hps_io_hps_io_gpio_inst_GPIO53  (hws_ifm.HPS_LED   ),
	  .hps_0_hps_io_hps_io_gpio_inst_GPIO54  (hws_ifm.HPS_KEY   ),
	  .hps_0_hps_io_hps_io_gpio_inst_GPIO61  (hws_ifm.HPS_GSENSOR_INT ),

	  .hps_0_f2h_sdram0_data_address         (dram_address),
	  .hps_0_f2h_sdram0_data_burstcount      (avalon_ifa.burstcount),
	  .hps_0_f2h_sdram0_data_waitrequest     (avalon_ifa.waitrequest),
	  .hps_0_f2h_sdram0_data_readdata        (avalon_ifa.readdata),
	  .hps_0_f2h_sdram0_data_readdatavalid   (avalon_ifa.readdatavalid),
	  .hps_0_f2h_sdram0_data_read            (avalon_ifa.read),
	  .hps_0_f2h_sdram0_data_writedata       (avalon_ifa.writedata),
	  .hps_0_f2h_sdram0_data_byteenable      (avalon_ifa.byteenable),
	  .hps_0_f2h_sdram0_data_write           (avalon_ifa.write),

      .alt_vip_vfr_hdmi_avalon_streaming_source_data          (avlst_src.data),
      .alt_vip_vfr_hdmi_avalon_streaming_source_valid         (avlst_src.valid),
      .alt_vip_vfr_hdmi_avalon_streaming_source_ready         (avlst_src.ready),
      .alt_vip_vfr_hdmi_avalon_streaming_source_startofpacket (avlst_src.startofpacket),
      .alt_vip_vfr_hdmi_avalon_streaming_source_endofpacket   (avlst_src.endofpacket),

		//FPGA Partion
	  .led_pio_external_connection_export      ( fpga_led_internal 	),
	  .dipsw_pio_external_connection_export    ( '0	),
	  .button_pio_external_connection_export   ( fpga_debounced_buttons	),
      .custom_pio_0_pio_new_signal             (fpga_pio_internal),
      .hps_0_h2f_reset_reset_n                 ( hps_fpga_reset_n )
 );

// On recoit la vidéo en mode "video avalon_stream"
// On la convertit en avalon_mm avec bursts
avlst2mm vtrans(
    .avalon_stream_ifa(avlst_src.agent),
    .avalon_ifh(avalon_ifh.host)
);


// ### update clk_freq in hdmi_config
I2C_HDMI_Config u_I2C_HDMI_Config (
	.iCLK       (sys_clk),
	.iRST_N     ( 1'b1),
	.I2C_SCLK   (hws_ifm.HDMI_I2C_SCL),
	.I2C_SDAT   (hws_ifm.HDMI_I2C_SDA),
	.HDMI_TX_INT(hws_ifm.HDMI_TX_INT)
	);

rrst #( .ACTIVE_HIGH(1'b1)) u_rrst
(
    .clk(sys_clk),
    .rst_in(custom_resetn),
    .rst_out(sys_rst)
);

debounce #(
  .WIDTH(2),
  .POLARITY("LOW"),
  .TIMEOUT(50000),      // at 50Mhz this is a debounce time of 1ms
  .TIMEOUT_WIDTH(16)    // ceil(log2(TIMEOUT))
)
debounce_inst (
  .clk                                  (sys_clk),
  .reset_n                              (hps_fpga_reset_n),
  .data_in                              (KEY),
  .data_out                             (fpga_debounced_buttons)
);

`endif
endmodule
`default_nettype wire
