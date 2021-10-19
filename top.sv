`timescale 1ns / 1ps
import uvm_pkg::*;
import my_pkg::*;
// `include "uvm_macros.svh"

module top;


bit clk;
initial
  forever
    #( 5ns ) clk = ~clk;


my_if my_if( .clk_i ( clk ) );


initial
  begin
    my_pkg::global_vif = my_if;
    run_test();
  end


endmodule
