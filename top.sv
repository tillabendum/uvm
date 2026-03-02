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


haos haos_inst(
    .clk(clk)
  );

initial
  begin
    run_test();
  end

endmodule

bind muos harness_if#(.T(my_pkg::MY_T), .VAR_NAME("cnt")) harness_if_inst(cnt, clk);
bind muos harness_n_if#(.T(logic [9:0]), .N(2), .VAR_NAME("map")) harness_if_map_inst(map, clk);