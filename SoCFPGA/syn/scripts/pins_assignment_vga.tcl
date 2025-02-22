#============================================================
# VGA
#============================================================

# Standard électrique
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL"  -to video_ifm.*
set_instance_assignment -name CURRENT_STRENGTH_NEW "8MA" -to video_ifm.*
set_instance_assignment -name SLEW_RATE 1 -to  video_ifm.*

set_location_assignment PIN_AG5  -to video_ifm.CLK
set_location_assignment PIN_AD19 -to video_ifm.BLANK
set_location_assignment PIN_AD12 -to video_ifm.RGB[0]
set_location_assignment PIN_AE12 -to video_ifm.RGB[1]
set_location_assignment PIN_W8   -to video_ifm.RGB[2]
set_location_assignment PIN_Y8   -to video_ifm.RGB[3]
set_location_assignment PIN_AD11 -to video_ifm.RGB[4]
set_location_assignment PIN_AD10 -to video_ifm.RGB[5]
set_location_assignment PIN_AE11 -to video_ifm.RGB[6]
set_location_assignment PIN_Y5   -to video_ifm.RGB[7]
set_location_assignment PIN_AF10 -to video_ifm.RGB[8]
set_location_assignment PIN_Y4   -to video_ifm.RGB[9]
set_location_assignment PIN_AE9  -to video_ifm.RGB[10]
set_location_assignment PIN_AB4  -to video_ifm.RGB[11]
set_location_assignment PIN_AE7  -to video_ifm.RGB[12]
set_location_assignment PIN_AF6  -to video_ifm.RGB[13]
set_location_assignment PIN_AF8  -to video_ifm.RGB[14]
set_location_assignment PIN_AF5  -to video_ifm.RGB[15]
set_location_assignment PIN_AE4  -to video_ifm.RGB[16]
set_location_assignment PIN_AH2  -to video_ifm.RGB[17]
set_location_assignment PIN_AH4  -to video_ifm.RGB[18]
set_location_assignment PIN_AH5  -to video_ifm.RGB[19]
set_location_assignment PIN_AH6  -to video_ifm.RGB[20]
set_location_assignment PIN_AG6  -to video_ifm.RGB[21]
set_location_assignment PIN_AF9  -to video_ifm.RGB[22]
set_location_assignment PIN_AE8  -to video_ifm.RGB[23]
set_location_assignment PIN_T8   -to video_ifm.HS
set_location_assignment PIN_V13  -to video_ifm.VS

