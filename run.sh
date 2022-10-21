#!/usr/bin/sh
vlogan -full64 -ntb_opts uvm-1.2 -sverilog
vlogan -full64 -ntb_opts uvm-1.2 -sverilog my_params_pkg.sv
vlogan -full64 -ntb_opts uvm-1.2 -sverilog my_pkg.sv

vlogan -full64 -ntb_opts uvm-1.2 -sverilog mem.sv
vlogan -full64 -ntb_opts uvm-1.2 -sverilog mem_if.sv
vlogan -full64 -ntb_opts uvm-1.2 -sverilog mem_bfm.sv
vlogan -full64 -ntb_opts uvm-1.2 -sverilog top.sv

vcs -full64 -ntb_opts uvm-1.2 -sverilog -LDFLAGS -Wl,--no-as-needed top
./simv +UVM_TESTNAME=my_test
