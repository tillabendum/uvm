.PHONY: all, build, clean, run, run-gui, xrun_build, xrun_run, xrun_gui 

PWD=$(shell pwd)
VCS_BUILD_DIR=vcs_build
XRUN_BUILD_DIR=xrun_build

all:
	$(MAKE) clean
	$(MAKE) build
	$(MAKE) run

clean:
	rm -rf $(VCS_BUILD_DIR)
	rm -rf $(XRUN_BUILD_DIR)

build:
	mkdir -p $(VCS_BUILD_DIR)
	cd $(VCS_BUILD_DIR) && vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps
	cd $(VCS_BUILD_DIR) && ROOT_DIR=${PWD} vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps -f $(PWD)/files.f
	cd $(VCS_BUILD_DIR) && vcs -sverilog -ntb_opts uvm-1.2 -full64 -debug_access+all -LDFLAGS -Wl,--no-as-needed -kdb top

run:
	$(VCS_BUILD_DIR)/simv +UVM_TESTNAME=my_test

run-gui:
	$(VCS_BUILD_DIR)/simv +UVM_VERBISITY=UVM_DEBUG +UVM_NO_RELNOTES +UVM_VERDI_TRACE=HIER +UVM_TESTNAME=my_test -gui

xrun_build:
	mkdir -p $(XRUN_BUILD_DIR)
	cd $(XRUN_BUILD_DIR) && ROOT_DIR=${PWD} xrun \
    -64bit \
    -elaborate \
    -mccodegen \
    -sv \
    -snapshot area \
    -timescale 1ns/1ps \
    -enable_strict_timescale \
    -nospecify \
    -notimingcheck \
    -uvm \
    -uvmhome CDNS-1.2 \
    -nowarn CUVIHR \
    -nowarn FUNTSK \
    -nowarn NOSYST \
    -nowarn RTSVQO \
    -nowarn NONPRT \
	-access +rwc \
    -l sim_build.xlog \
	-f $(PWD)/files.f

xrun_run:
	cd $(XRUN_BUILD_DIR) && xrun \
    -64bit \
    -sv \
    -r area \
    -nospecify \
    -notimingcheck \
    +tracelog=1 \
	+UVM_TESTNAME=my_test

xrun_gui:
	cd $(XRUN_BUILD_DIR) && xrun \
    -64bit \
    -sv \
    -r area \
    -nospecify \
    -notimingcheck \
    +tracelog=1 \
    -gui \
	+UVM_VERBISITY=UVM_DEBUG +UVM_NO_RELNOTES +UVM_VERDI_TRACE=HIER +UVM_TESTNAME=my_test
