`timescale 1ns / 1ps
import uvm_pkg::*;
import my_pkg::*;
// `include "uvm_macros.svh"
module top;

bit clk;
initial
  forever
    #( 5ns ) clk = ~clk;


mem_if #(
    .DWIDTH( my_pkg::DWIDTH ),
    .AWIDTH( my_pkg::INTERFACE_AWIDTH )
  ) mem_if ();


mem #(
    .DWIDTH( my_pkg::DWIDTH ),
    .AWIDTH( my_pkg::INTERFACE_AWIDTH )
  ) DUT (
    .mem_if( mem_if ),
    .clk_i( clk )
  );

initial
  begin
    run_test();
  end

endmodule
