#-------------------------------#
#--- Project Global Settings ---#
#-------------------------------#

# no longer supported =>
# set_global_assignment -name SMART_RECOMPILE ON
# set_global_assignment -name INCREMENTAL_COMPILATION FULL_INCREMENTAL_COMPILATION

# default value
set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_RETIMING OFF

# Trade-off between compilation and performance/area
# Not recommended : The produced netlist is slightly harder for the fitter
# => making the overall fitting process slower
# set_global_assignment -name SYNTHESIS_EFFORT FAST

# Reduce compile time but degrade design performance 
#set_global_assignment -name PHYSICAL_SYNTHESIS_EFFORT FAST
#set_global_assignment -name FITTER_EFFORT FAST_FIT

#set_global_assignment -name FINAL_PLACEMENT_OPTIMIZATION NEVER
#set_global_assignment -name OPTIMIZE_TIMING OFF
#set_global_assignment -name IO_PLACEMENT_OPTIMIZATION OFF
#set_global_assignment -name ROUTER_LCELL_INSERTION_AND_LOGIC_DUPLICATION OFF

# ignored because of the assignment above
# set_global_assignment -name ROUTER_REGISTER_DUPLICATION OFF

# set_global_assignment -name ADVANCED_PHYSICAL_OPTIMIZATION OFF

# put shifter registers from different hierarchies in the same RAM
set_global_assignment -name ALLOW_SHIFT_REGISTER_MERGING_ACROSS_HIERARCHIES OFF
set_global_assignment -name SYNTH_TIMING_DRIVEN_SYNTHESIS OFF
# registers in diffrent hierarchies could be merged if their inputs are the same
set_global_assignment -name DISABLE_REGISTER_MERGING_ACROSS_HIERARCHIES OFF
# remove registers that are identical to other regiters in the design
#set_global_assignment -name ALLOW_REGISTER_MERGING OFF
#set_global_assignment -name ALLOW_REGISTER_DUPLICATION OFF

set_global_assignment -name FITTER_AGGRESSIVE_ROUTABILITY_OPTIMIZATION NEVER
set_global_assignment -name OPTIMIZE_POWER_DURING_FITTING OFF

set_global_assignment -name NUM_PARALLEL_PROCESSORS 8
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

# Ensure that design partition assignments are not ignored
set_global_assignment -name IGNORE_PARTITIONS OFF

