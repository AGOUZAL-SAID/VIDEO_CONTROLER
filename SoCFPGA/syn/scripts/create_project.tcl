# Script de Synthèse en langage Tcl.

# Chargement des  paquets Quartus II
load_package project
load_package incremental_compilation

# Le nom du module top sera celui du projet
set PROJECT_NAME  $env(PROJECT)

set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "$PROJECT_NAME"]} {
		puts "Project $PROJECT_NAME is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists $PROJECT_NAME]} {
		project_open -revision $PROJECT_NAME $PROJECT_NAME
	} else {
		project_new -revision $PROJECT_NAME $PROJECT_NAME
	}

	set need_to_close_project 1
}

# Compile un peu plus lentement mais optimise bien le design 
# set fast_compile 0

### On récupère les contraintes et définitions
# Contraintes sur le FPGA choisi
source ./scripts/device_assignment.tcl
# Contraintes spécifiques au projet (comment synthétiser,..)
source ./scripts/project_assignment.tcl
# Contraintes sur les entrées sorties
source ./scripts/pins_assignment.tcl
# Contraintes sur les timings
set_global_assignment -name SDC_FILE ./scripts/timing_constraints.sdc
# Liste des fichiers à compiler
source ./scripts/project_list.tcl
# hw_support assignments
source ./scripts/hw_support.tcl
# Commit assignments
#export_assignments

# Close project
project_close
