`timescale 1ns / 1ps
import uvm_pkg::*;
import my_pkg::*;
// `include "uvm_macros.svh"
module top;

bit clk;
initial
  forever
    #( 5ns ) clk = ~clk;

sub_top sub(
    .clk(clk)
  );

backdoor_if bkdr_if(
    .clk(clk)
  );


haos haos_inst(
    .clk(clk)
  );


initial
  begin
    uvm_pkg::uvm_config_db#(backdoor_if_proxy)::set(null, "uvm_test_top.env.bkdr_cnt", "iproxy", bkdr_if.get_proxy());
    run_test();
  end

endmodule

bind muos harness_if#(.T(my_pkg::MY_T)) harness_if_inst(cnt, clk);