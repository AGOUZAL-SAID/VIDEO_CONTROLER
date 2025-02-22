# Les contraintes sur les entrés sorties sont plusieur type.
#  - choix des pattes associées à chaque signal entrant ou sortant du FPGA
#  - programmation des caractéristiques électriques de ces signaux
#  - programmation des caractéristiques des pattes non utilisées.
#  ATTENTION : il est important de maîtriser le comportement de TOUTES les pattes du FPGA
#  même si elles ne sont pas utilisées dans le design courant (évitons les courts circuits fâcheux...)

# NEUTRALISATON DE TOUTES LES ENTREES SORTIES NON UTILISEES
set_global_assignment -name RESERVE_ALL_UNUSED_PINS_NO_OUTPUT_GND "AS INPUT TRI-STATED"
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"

# RECUPERATION OU INVALIDATION EVENTUELLE DES ENTREES SORTIES DE PROGRAMMATION DU FPGA POUR  L'APPLICATION 
# (entrées/sorties à double usage...)
set_global_assignment -name RESERVE_ASDO_AFTER_CONFIGURATION "AS OUTPUT DRIVING AN UNSPECIFIED SIGNAL"

# Pour définir le standard d'une IO en particulier on peut utiliser la syntaxe suivante
#     set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to mon_signal

# On peut définir le courant maximum débité par une sortie: le limiter pour limiter la consommation, ou
# l'augmenter pour tenir compte de la charge, la syntaxe est la suivante
#     set_instance_assignment -name CURRENT_STRENGTH_NEW "4MA" -to mon_signal

# On peut programmer les "temps de montée", l'insertion de résistances de "pull-up" ou de "pull-down", l'insertion de maintien de bus....
#   set_instance_assignment -name SLEW_RATE 1 -to mon_signal


# CHOIX DE POSITION DES ENTREES SORTIES
# Cela doit évidemment être en fait en cohérence avec ce que l'on sait du FPGA et des circuits
# qui lui sont reliés. La ligne ci-dessous est un exemple d'assignation.
#     set_location_assignment PIN_M20 -to address[10] -comment "Address pin to Second FPGA"
#

source ./scripts/pins_assignment_vga.tcl

###################################################
### PLACEZ ICI VOS DEFINITIONS
##################################################
#
set_location_assignment PIN_V11 -to FPGA_CLK1_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_CLK1_50


set_location_assignment PIN_Y24 -to SW[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]

set_location_assignment PIN_W24 -to SW[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]

set_location_assignment PIN_W21 -to SW[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]

set_location_assignment PIN_W20 -to SW[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]


set_location_assignment PIN_AH17 -to KEY[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[0]

set_location_assignment PIN_AH16 -to KEY[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[1]


set_location_assignment PIN_W15 -to LED[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[0]

set_location_assignment PIN_AA24 -to LED[1] 
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[1]

set_location_assignment PIN_V16  -to LED[2] 
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[2]

set_location_assignment PIN_V15  -to LED[3] 
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[3]

set_location_assignment PIN_AF26 -to LED[4] 
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[4]

set_location_assignment PIN_AE26 -to LED[5] 
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[5]