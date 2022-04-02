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
    .DWIDTH( 8 ),
    .AWIDTH( 6 )
  ) mem_if ();


mem #(
    .DWIDTH( 8 ),
    .AWIDTH( 6 )
  ) DUT (
    .mem_if( mem_if ),
    .clk_i( clk )
  );

initial
  begin
    run_test();
  end

endmodule
