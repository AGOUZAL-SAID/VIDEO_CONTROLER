SHELL:=/bin/bash
export PATH:=/comelec/softs/bin:$(PATH)
#------------------------------#
# Synthesis flow using Quartus #
#------------------------------#
export PROJECT_DIR = $(realpath ../..)
export PROJECT     = Top

QSYS_PROJECT       = $(PROJECT_DIR)/ips/Qsys/soc_system

QUARTUS       = quartus_sh
QUARTUSFLAGS ?=

# Pour colorier les logs en fonction de la nature des Infos
colorize = sed  -e "s/Error/\x1b[31mError/" -e "s/Info/\x1b[32mInfo/" -e "s/Warning/\x1b[34mWarning/"

.PHONY: program test_syn syn log clean ultraclean


all:
	@echo "make all       : ce message..."
	@echo "make test_syn  : verification rapide des sources avant une compilation"
	@echo "make syn       : lancement d'une compilation"
	@echo "make log       : affichage du fichier de log de la synthèse"
	@echo "make program   : programmation du fpga, n'oubliez pas de brancher et d'allumer la carte..."
	@echo "make clean     : nettoyage du répertoire"

test_syn: .create_project
	@echo "+------------------------------------------+"
	@echo "+ Project analysis and elaboration         +"
	@echo "+------------------------------------------+"
	@stdbuf -o0 $(QUARTUS) $(QUARTUSFLAGS) -t "./scripts/test_compile.tcl" | stdbuf -o0 tee syn.log | stdbuf -o0 $(colorize)
	@echo "###---> End Compiling Step $(STEP) <---###"


syn : .create_project 
	@echo "+------------------------------------------+"
	@echo "+ Full Compilation of the Quartus project +"
	@echo "+------------------------------------------+"
	@stdbuf -o0 $(QUARTUS) $(QUARTUSFLAGS) -t "./scripts/full_compile.tcl" | stdbuf -o0 tee syn.log | stdbuf -o0 $(colorize)


.create_project: $(QSYS_PROJECT).sopcinfo scripts/project_list.tcl scripts/pins_assignment.tcl scripts/timing_constraints.sdc
	@echo "+-----------------------------------+"
	@echo "+ (Re) Creating the Quartus project +"
	@echo "+-----------------------------------+"
	@rm -f Top.qsf
	$(QUARTUS) $(QUARTUSFLAGS) -t "./scripts/create_project.tcl"
	@cp ./scripts/Top.srf .
	@touch $@

$(QSYS_PROJECT).sopcinfo:
	@echo "+----------------------------------------+"
	@echo "+ Generating $(QSYS_PROJECT) qsys files  +"
	@echo "+----------------------------------------+"
	make -C $(PROJECT_DIR)/ips/Qsys qsys_compile

program: output_files/$(PROJECT).sof
	quartus_pgm -m jtag -c 1 -o "p;./output_files/$(PROJECT).sof@2"

log: syn.log
	@cat $< | ${colorize} | less -R

clean:
	@rm -rf db output_files hps_isw_handoff incremental_db c5_*.txt hps_sdram*.csv syn.log *rtl*

ultraclean: clean
	@rm -rf .create_project *.qsf *.qpf *.qws *.sof *.srf

