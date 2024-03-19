.PHONY: all, build, run

all:
	$(MAKE) build
	$(MAKE) run

build:
	vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps
	vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -timescale=1ns/1ps -f files.f
	vcs -sverilog -ntb_opts uvm-1.2 -full64 -debug_access+all -LDFLAGS -Wl,--no-as-needed -kdb top

run:
	./simv +UVM_TESTNAME=my_test

run-gui:
	./simv +UVM_VERBISITY=UVM_DEBUG +UVM_NO_RELNOTES +UVM_VERDI_TRACE=HIER +UVM_TESTNAME=my_test -gui


