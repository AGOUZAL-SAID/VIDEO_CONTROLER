# Selection du  FPGA spécifique utilisé dans la carte DE2.
# Dans l'idéal, ce doit être le bon circuit, mais aussi avec les bonnes informations 
# de timing. Le suffixe C6 dans le type de cicuit indique la gamme de performance du
# circuit, une erreur sur cette gamme se traduit par une évaluation fausse des performances
# en timing.
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEBA6U23I7

# Un problème spécifique au circuit Cyclone II d'ALTERA concernant les mémoires.
# L'outils Quartus propose à l'utilisateur plusieurs façons de traiter ce problème.
#set_parameter -name CYCLONEII_SAFE_WRITE RESTRUCTURE
#
# cyclone II dual port ram issues
# Possible options are:
# NO_CHANGE     No memory blocks will be modified. The Quartus II 
#               software issues an error for memory blocks in un-safe 
#               modes.
# PORT_SWAP     Only changes memory blocks that will have no design 
# (default)     impact (port swap remapping methods). The Quartus II 
#               software issues an error for memory blocks that require 
#               read enable emulation, bit multiplexing, or true dual port 
#               remapping methods.
# RESTRUCTURE   Remap all memory blocks (port swap, read enable 
#               emulation, bit multiplexing, and true dual port remapping 
#               methods).
# VERIFIED_SAFE User has verified memory block to be safe. The Quartus II 
#               software will issue a warning for memory blocks in unsafe 
#               modes.
#
# For extra information:
# Cyclone II FPGA Family : Errata Sheet
# http://www.altera.com/literature/ds/es_cycii.pdf

# Vérification permanente de la programmation du FPGA par CRC 
#  Inutile à mon avis
# set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
