`timescale 1ns / 1ps
import uvm_pkg::*;
import my_pkg::*;
// `include "uvm_macros.svh"
module top_indirect;

bit clk;
initial
  forever
    #( 5ns ) clk = ~clk;

logic reset;

initial
  begin
    @( posedge clk ) reset <= 1;
    @( posedge clk ) reset <= 0;
  end


mem_if #(
    .DWIDTH( 8 ),
    .AWIDTH( 6 )
  ) mem_if ();


mem_indirect #(
    .DWIDTH( 8 ),
    .AWIDTH( 6 )
  ) DUT (
    .mem_if( mem_if ),
    .srst_i( reset ),
    .clk_i( clk )
  );

initial
  begin
    run_test();
  end

endmodule
