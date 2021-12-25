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
    uvm_resource_db #( virtual interface my_if )::set( "*", "vif", my_if, null );
    run_test();
  end


endmodule
