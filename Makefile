.PHONY: all, build, clean, run, run-gui

PWD=$(shell pwd)
BUILD_DIR = build

all:
	$(MAKE) build
	$(MAKE) run

clean:
	rm -rf $(BUILD_DIR)

build:
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR)  && vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps
	cd $(BUILD_DIR)  && ROOT_DIR=${PWD} vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps -f ../files.f
	cd $(BUILD_DIR)  && vcs -sverilog -ntb_opts uvm-1.2 -full64 -debug_access+all -LDFLAGS -Wl,--no-as-needed -kdb top

run:
	build/simv +UVM_TESTNAME=my_test

run-gui:
	./simv +UVM_VERBISITY=UVM_DEBUG +UVM_NO_RELNOTES +UVM_VERDI_TRACE=HIER +UVM_TESTNAME=my_test -gui


