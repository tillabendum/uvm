.PHONY: all, build, run

all:
	$(MAKE) build
	$(MAKE) run

build:
	vlogan -full64 -ntb_opts uvm-1.2 -sverilog -kdb -f files.f
	vcs -full64 -ntb_opts uvm-1.2 -debug_access+all -sverilog -LDFLAGS -Wl,--no-as-needed -kdb top

run:
	./simv +UVM_TESTNAME=my_test

run-gui:
	./simv +UVM_VERBISITY=UVM_DEBUG +UVM_NO_RELNOTES +UVM_VERDI_TRACE=HIER +UVM_TESTNAME=my_test -gui


