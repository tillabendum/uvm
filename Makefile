all:
	$(MAKE) build
	$(MAKE) run

build:
	vlogan -full64 -ntb_opts uvm-1.2 -sverilog -f files.f
	vcs -full64 -ntb_opts uvm-1.2 -sverilog -LDFLAGS -Wl,--no-as-needed top

run:
	./simv +UVM_TESTNAME=my_test

.PHONY: all, build, run