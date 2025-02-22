// Avalon memory mapped 
interface hws_if;
	wire        		HPS_CONV_USB_N;
	wire  [14:0]		HPS_DDR3_ADDR;
	wire   [2:0]		HPS_DDR3_BA;
	wire        		HPS_DDR3_CAS_N;
	wire        		HPS_DDR3_CK_N;
	wire        		HPS_DDR3_CK_P;
	wire        		HPS_DDR3_CKE;
	wire        		HPS_DDR3_CS_N;
	wire   [3:0]		HPS_DDR3_DM;
	wire  [31:0]		HPS_DDR3_DQ;
	wire   [3:0]		HPS_DDR3_DQS_N;
	wire   [3:0]		HPS_DDR3_DQS_P;
	wire        		HPS_DDR3_ODT;
	wire        		HPS_DDR3_RAS_N;
	wire        		HPS_DDR3_RESET_N;
	wire        		HPS_DDR3_RZQ;
	wire        		HPS_DDR3_WE_N;
	wire        		HPS_ENET_GTX_CLK;
	wire        		HPS_ENET_INT_N;
	wire        		HPS_ENET_MDC;
	wire        		HPS_ENET_MDIO;
	wire        		HPS_ENET_RX_CLK;
	wire   [3:0]		HPS_ENET_RX_DATA;
	wire        		HPS_ENET_RX_DV;
	wire   [3:0]		HPS_ENET_TX_DATA;
	wire        		HPS_ENET_TX_EN;
	wire        		HPS_GSENSOR_INT;
	wire        		HPS_I2C0_SCLK;
	wire        		HPS_I2C0_SDAT;
	wire        		HPS_I2C1_SCLK;
	wire        		HPS_I2C1_SDAT;
	wire        		HPS_KEY;
	wire        		HPS_LED;
	wire        		HPS_LTC_GPIO;
	wire        		HPS_SD_CLK;
	wire        		HPS_SD_CMD;
	wire   [3:0]		HPS_SD_DATA;
	wire        		HPS_SPIM_CLK;
	wire        		HPS_SPIM_MISO;
	wire        		HPS_SPIM_MOSI;
	wire        		HPS_SPIM_SS;
	wire        		HPS_UART_RX;
	wire        		HPS_UART_TX;
	wire        		HPS_USB_CLKOUT;
	wire   [7:0]		HPS_USB_DATA;
	wire        		HPS_USB_DIR;
	wire        		HPS_USB_NXT;
	wire        		HPS_USB_STP;

	wire         		HDMI_I2C_SCL;
	wire         		HDMI_I2C_SDA;
	wire         		HDMI_TX_INT;

  modport master
  (
   	inout 	HPS_CONV_USB_N,
	output	HPS_DDR3_ADDR,
	output	HPS_DDR3_BA,
	output	HPS_DDR3_CAS_N,
	output	HPS_DDR3_CK_N,
	output	HPS_DDR3_CK_P,
	output	HPS_DDR3_CKE,
	output	HPS_DDR3_CS_N,
	output	HPS_DDR3_DM,
	inout 	HPS_DDR3_DQ,
	inout 	HPS_DDR3_DQS_N,
	inout 	HPS_DDR3_DQS_P,
	output	HPS_DDR3_ODT,
	output	HPS_DDR3_RAS_N,
	output	HPS_DDR3_RESET_N,
	input 	HPS_DDR3_RZQ,
	output	HPS_DDR3_WE_N,
	output	HPS_ENET_GTX_CLK,
	inout 	HPS_ENET_INT_N,
	output	HPS_ENET_MDC,
	inout 	HPS_ENET_MDIO,
	input 	HPS_ENET_RX_CLK,
	input 	HPS_ENET_RX_DATA,
	input 	HPS_ENET_RX_DV,
	output	HPS_ENET_TX_DATA,
	output	HPS_ENET_TX_EN,
	inout 	HPS_GSENSOR_INT,
	inout 	HPS_I2C0_SCLK,
	inout 	HPS_I2C0_SDAT,
	inout 	HPS_I2C1_SCLK,
	inout 	HPS_I2C1_SDAT,
	inout 	HPS_KEY,
	inout 	HPS_LED,
	inout 	HPS_LTC_GPIO,
	output	HPS_SD_CLK,
	inout 	HPS_SD_CMD,
	inout 	HPS_SD_DATA,
	output	HPS_SPIM_CLK,
	input 	HPS_SPIM_MISO,
	output	HPS_SPIM_MOSI,
	inout 	HPS_SPIM_SS,
	input 	HPS_UART_RX,
	output	HPS_UART_TX,
	input 	HPS_USB_CLKOUT,
	inout 	HPS_USB_DATA,
	input 	HPS_USB_DIR,
	input 	HPS_USB_NXT,
	output	HPS_USB_STP,

	output  HDMI_I2C_SCL,
	inout   HDMI_I2C_SDA,
	input   HDMI_TX_INT
  ) ;


endinterface

