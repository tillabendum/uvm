.PHONY: all, build, run

ROOT_DIR=$(shell pwd)

all:
	$(MAKE) build
	$(MAKE) run

build:
	$(MAKE) build-uvm
	$(MAKE) build-rtl
	$(MAKE) build-tb

build-uvm:
	rm -rf build
	mkdir build
	(cd build; vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps)

build-rtl:
	(cd build; ROOT_DIR=$(ROOT_DIR) vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps -f $(ROOT_DIR)/src/dut/my_haos.f)

build-tb:
	(cd build; ROOT_DIR=$(ROOT_DIR) vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps -f $(ROOT_DIR)/src/files.f)
	(cd build; vcs -sverilog -ntb_opts uvm-1.2 -full64 -debug_access+all -LDFLAGS -Wl,--no-as-needed -kdb top_tb)

run:
	(cd build; ./simv +UVM_TESTNAME=my_test)

run-gui:
	(cd build; ./simv +UVM_VERBISITY=UVM_DEBUG +UVM_NO_RELNOTES +UVM_VERDI_TRACE=HIER +UVM_TESTNAME=my_test -gui)


