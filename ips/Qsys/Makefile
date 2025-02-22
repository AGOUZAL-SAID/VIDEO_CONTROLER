SHELL=/bin/bash
export PATH:=/comelec/softs/bin:${PATH}

QSYS_PROJECT  = soc_system

.PHONY: clean
all: 
	@echo "### Targets :                                    " 
	@echo "+++ qsys_compile =>                              "
	@echo "    Compiles $(QSYS_PROJECT).qsys                " 
	@echo "    and generates $(QSYS_PROJECT) files)         "
	@echo "                                                 "
	@echo "+++ qsys_edit =>                                 "
	@echo "    Launches Qsys GUI using $(QSYS_PROJECT).qsys "
	@echo "                                                 "
	@echo "+++ clean =>                                     "
	@echo "    Removes the Qsys generated files             "
	@echo "                                                 "


.PHONY: qsys_compile
qsys_compile : $(QSYS_PROJECT).sopcinfo

$(QSYS_PROJECT).sopcinfo: $(QSYS_PROJECT).qsys 
	@echo "+---------------------------------------+"
	@echo "+ Generating qsys $(QSYS_PROJECT) files +"
	@echo "+---------------------------------------+"
	qsys-generate $< -syn -od=$(QSYS_PROJECT)
	@sed -i '1s/^/`default_nettype wire/' $(QSYS_PROJECT)/synthesis/$(QSYS_PROJECT).v

.PHONY: qsys_edit
qsys_edit:
	@echo "+---------------------------------------+"
	@echo "+ Launching Qsys editor                 +"
	@echo "+---------------------------------------+"
	qsys-edit $(QSYS_PROJECT).qsys &
	@sed -i '1s/^/`default_nettype wire/' $(QSYS_PROJECT)/synthesis/$(QSYS_PROJECT).v


clean:
	@rm -rf $(QSYS_PROJECT) $(QSYS_PROJECT).sopcinfo


