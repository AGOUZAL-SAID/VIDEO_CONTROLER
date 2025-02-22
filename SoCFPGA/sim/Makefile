# Squelette de Makefile pour le projet Video
SHELL=/bin/bash
AVALON_BFMS := /comelec/softs/opt/altera/current/ip/altera/sopc_builder_ip/verification
export PATH:=/comelec/softs/bin:$(PATH)

.PHONY: clean all simu_batch compile simu_gui info

# WORKDIR est le répertoire de simulation
WORKDIR = $(shell pwd)/work
# TOPDIR est le répertoire principal (le dépot git de vos travaux)
TOPDIR = $(realpath $(shell pwd)/../..)

# Le module top a simuler
TB_TOP = tb_Top

VLOG     := vlog
VLOG_OPT ?= +acc -l comp.log -timescale "1ns/1ps"
VLOG_OPT += +define+IMAGE_FILE=\"$(TOPDIR)/SoCFPGA/tb_src/image.hex\"
VLOG_OPT += +define+SIMULATION

VSIM     := vsim
VSIM_OPT := -lib work -L altera_lnsim_ver

# Sources
VPATH := $(AVALON_BFMS)/lib:$(AVALON_BFMS)/altera_avalon_mm_slave_bfm:$(TOPDIR)/ips/interfaces:$(TOPDIR)/SoCFPGA/tb_src:$(TOPDIR)/SoCFPGA/src:$(TOPDIR)/ips/hws:$(TOPDIR)/ips/sys_pll:$(TOPDIR)/ips/sys_pll/sys_pll:$(TOPDIR)/ips/fifos

SRC	      = $(AVALON_BFMS)/lib/verbosity_pkg.sv
SRC	     += $(AVALON_BFMS)/lib/avalon_mm_pkg.sv
SRC      += $(AVALON_BFMS)/lib/avalon_utilities_pkg.sv
SRC      += $(AVALON_BFMS)/altera_avalon_mm_slave_bfm/altera_avalon_mm_slave_bfm.sv
SRC      += $(wildcard $(TOPDIR)/ips/interfaces/*.sv)
SRC      += $(wildcard $(TOPDIR)/ips/sys_pll/*.v)
SRC      += $(wildcard $(TOPDIR)/ips/sys_pll/*/*.v)
SRC      += $(wildcard $(TOPDIR)/ips/fifos/*.sv)
SRC      += $(TOPDIR)/ips/hws/avlst2mm.sv
SRC      += $(TOPDIR)/ips/hws/hw_support.sv
SRC      += $(wildcard $(TOPDIR)/SoCFPGA/src/*.sv)
SRC      += $(wildcard $(TOPDIR)/SoCFPGA/tb_src/*.sv)

DEP       = $(patsubst %.sv,$(WORKDIR)/.%.compiled,$(notdir ${SRC}))
DEP      += $(patsubst %.v,$(WORKDIR)/.%.compiled,$(notdir ${SRC}))

info:
	@echo "Les commandes possibles sont:"
	@echo "make compile    : compilation des codes (module à tester et testbenchs)"
	@echo "make simu_batch : simulation en mode terminal, avec simple affichage des résultats des tests"
	@echo "make simu_gui   : simulation en mode graphique pour faire un debug de votre code."
	@echo "make all        : équivalent à simu_gui"
	@echo "make info       : ce message"
	@echo "make clean      : nettoyage des fichiers inutiles"

all: simu_batch

simu_batch: compile
	cd $(WORKDIR) ; $(VSIM) $(VSIM_OPT)  -batch $(TB_TOP) -do "run -all ; quit"

simu_gui: compile
	cd $(WORKDIR); $(VSIM) $(VSIM_OPT)  $(TB_TOP)

compile: $(DEP)

$(WORKDIR)/.%.compiled: %.sv | $(WORKDIR)
	cd $(WORKDIR) ; $(VLOG)  $(VLOG_OPT) $<
	touch $@

$(WORKDIR)/.%.compiled: %.v | $(WORKDIR)
	cd $(WORKDIR) ; $(VLOG) $(VLOG_OPT) $<
	touch $@

$(WORKDIR):
	mkdir -p $(WORKDIR)

clean:
	rm -rf $(WORKDIR)
	rm -f comp.log

