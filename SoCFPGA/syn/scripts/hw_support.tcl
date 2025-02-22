
### Source files
set PROJECT_DIR  $env(PROJECT_DIR)

set_global_assignment -name QIP_FILE $PROJECT_DIR/ips/Qsys/soc_system/synthesis/soc_system.qip


set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/interfaces/hws_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/interfaces/avalon_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/interfaces/avalon_stream_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/fifos/sync_fifo.sv
set_global_assignment -name VERILOG_FILE       $PROJECT_DIR/ips/debounce/debounce.v
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/I2C_HDMI_Config.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/I2C_Controller.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/I2C_WRITE_WDATA.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/sr_ff.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/rrst.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/avlst2mm.sv
set_global_assignment -name SYSTEMVERILOG_FILE $PROJECT_DIR/ips/hws/hw_support.sv


### Partition Settings
set_global_assignment -name PARTITION_IGNORE_SOURCE_FILE_CHANGES ON -section_id hw_support_par

set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
set_global_assignment -name PARTITION_NETLIST_TYPE POST_FIT -section_id hw_support_par
set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id hw_support_par
set_global_assignment -name PARTITION_COLOR 39423 -section_id hw_support_par
set_global_assignment -name LL_ENABLED ON -section_id hw_support_par
set_global_assignment -name LL_RESERVED ON -section_id hw_support_par
set_global_assignment -name LL_CORE_ONLY OFF -section_id hw_support_par
set_global_assignment -name LL_SECURITY_ROUTING_INTERFACE OFF -section_id hw_support_par
set_global_assignment -name LL_IGNORE_IO_BANK_SECURITY_CONSTRAINT OFF -section_id hw_support_par
set_global_assignment -name LL_PR_REGION OFF -section_id hw_support_par
set_global_assignment -name LL_ROUTING_REGION_EXPANSION_SIZE 2147483647 -section_id hw_support_par
set_instance_assignment -name LL_MEMBER_OF hw_support_par -to "hw_support:hw_support_inst" -section_id hw_support_par
set_global_assignment -name LL_HEIGHT 27 -section_id hw_support_par
set_global_assignment -name LL_WIDTH 30 -section_id hw_support_par
set_global_assignment -name LL_ORIGIN X21_Y37 -section_id hw_support_par
set_global_assignment -name LL_STATE LOCKED -section_id hw_support_par
set_global_assignment -name LL_AUTO_SIZE OFF -section_id hw_support_par
set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top
set_instance_assignment -name PARTITION_HIERARCHY hwsup_ee4c1 -to "hw_support:hw_support_inst" -section_id hw_support_par
set_partition -partition "hw_support_par" -netlist_type POST_FIT
set_partition -partition "Top" -netlist_type POST_FIT
### Assignments 

#============================================================
# HDMI
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_I2C_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_I2C_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_TX_INT
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_LRCLK
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_MCLK
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_SCLK
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HDMI_I2S

set_location_assignment PIN_U10 -to   hws_ifm.HDMI_I2C_SCL
set_location_assignment PIN_AA4 -to   hws_ifm.HDMI_I2C_SDA
set_location_assignment PIN_AF11 -to  hws_ifm.HDMI_TX_INT
#set_location_assignment PIN_T11 -to   hws_ifm.HDMI_LRCLK
#set_location_assignment PIN_U11 -to   hws_ifm.HDMI_MCLK
#set_location_assignment PIN_T12 -to   hws_ifm.HDMI_SCLK
#set_location_assignment PIN_T13 -to   hws_ifm.HDMI_I2S

#============================================================
# HPS
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_CONV_USB_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[4] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[5] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[6] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[7] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[8] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[9] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[10] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[11] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[12] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[13] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ADDR[14] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_BA[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_BA[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_BA[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_CAS_N -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_CKE -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_CK_N -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_CK_P -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_CS_N -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DM[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DM[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DM[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DM[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[4] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[5] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[6] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[7] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[8] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[9] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[10] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[11] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[12] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[13] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[14] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[15] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[16] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[17] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[18] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[19] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[20] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[21] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[22] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[23] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[24] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[25] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[26] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[27] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[28] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[29] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[30] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_DQ[31] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to hws_ifm.HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_ODT -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_RAS_N -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_RESET_N -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_RZQ -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to hws_ifm.HPS_DDR3_WE_N -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_GTX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_INT_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_MDC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_MDIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_RX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_RX_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_RX_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_RX_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_RX_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_RX_DV
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_TX_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_TX_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_TX_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_TX_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_ENET_TX_EN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_GSENSOR_INT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_I2C0_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_I2C0_SDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_I2C1_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_I2C1_SDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_KEY
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_LED
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_LTC_GPIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SD_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SD_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SD_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SD_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SD_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SD_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SPIM_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SPIM_MISO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SPIM_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_SPIM_SS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_UART_RX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_UART_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_CLKOUT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_DIR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_NXT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hws_ifm.HPS_USB_STP


set_instance_assignment -name D5_DELAY 2 -to hws_ifm.HPS_DDR3_CK_P -tag __hps_sdram_p0
set_instance_assignment -name D5_DELAY 2 -to hws_ifm.HPS_DDR3_CK_N -tag __hps_sdram_p0
set_global_assignment -name USE_DLL_FREQUENCY_FOR_DQS_DELAY_CHAIN ON

set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[0] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[1] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[2] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[3] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[4] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[4] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[5] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[5] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[6] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[6] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[7] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[7] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[8] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[8] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[9] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[9] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[10] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[10] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[11] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[11] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[12] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[12] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[13] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[13] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[14] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[14] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[15] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[15] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[16] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[16] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[17] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[17] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[18] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[18] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[19] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[19] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[20] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[20] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[21] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[21] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[22] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[22] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[23] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[23] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[24] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[24] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[25] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[25] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[26] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[26] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[27] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[27] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[28] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[28] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[29] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[29] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[30] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[30] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[31] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQ[31] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to hws_ifm.HPS_DDR3_CK_P -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to hws_ifm.HPS_DDR3_CK_N -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[0] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[10] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[11] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[12] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[13] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[14] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[1] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[2] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[3] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[4] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[5] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[6] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[7] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[8] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ADDR[9] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_BA[0] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_BA[1] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_BA[2] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_CAS_N -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_CKE -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_CS_N -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_ODT -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_RAS_N -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_WE_N -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to hws_ifm.HPS_DDR3_RESET_N -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DM[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DM[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DM[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to hws_ifm.HPS_DDR3_DM[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[4] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[5] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[6] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[7] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[8] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[9] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[10] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[11] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[12] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[13] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[14] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[15] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[16] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[17] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[18] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[19] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[20] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[21] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[22] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[23] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[24] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[25] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[26] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[27] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[28] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[29] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[30] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQ[31] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DM[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DM[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DM[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DM[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[10] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[11] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[12] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[13] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[14] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[4] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[5] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[6] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[7] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[8] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ADDR[9] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_BA[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_BA[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_BA[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_CAS_N -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_CKE -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_CS_N -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_ODT -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_RAS_N -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_WE_N -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_RESET_N -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_CK_P -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to hws_ifm.HPS_DDR3_CK_N -tag __hps_sdram_p0

set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|ureset|phy_reset_mem_stable_n -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|ureset|phy_reset_n -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[0].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[0] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[0] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[1].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[1] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[1] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[2].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[2] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[2] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[3].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[3] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[3] -tag __hps_sdram_p0
set_instance_assignment -name ENABLE_BENEFICIAL_SKEW_OPTIMIZATION_FOR_NON_GLOBAL_CLOCKS ON -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst -tag __hps_sdram_p0
set_instance_assignment -name PLL_COMPENSATION_MODE DIRECT -to hw_support_inst|soc_system_inst|hps_0|hps_io|border|hps_sdram_inst|pll0|fbout -tag __hps_sdram_p0

