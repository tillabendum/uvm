`timescale 1ns / 1ps
import uvm_pkg::*;
import my_pkg::*;
// `include "uvm_macros.svh"
module top;

bit   clk;
logic reset;

initial
  forever
    #( 5ns ) clk = ~clk;

initial
  begin
    @( posedge clk ) reset <= 1;
    @( posedge clk ) reset <= 0;
  end



mem_if #(
    .DWIDTH( my_pkg::DWIDTH ),
    .AWIDTH( my_pkg::AWIDTH )
  ) mem_if (
    .clk_i ( clk   ),
    .srst_i( reset )
  );

mem_bfm #(
    .DWIDTH( my_pkg::DWIDTH ),
    .AWIDTH( my_pkg::AWIDTH )
  ) mem_bfm (
    .itf( mem_if )
  );


mem #(
    .DWIDTH( my_pkg::DWIDTH ),
    .AWIDTH( my_pkg::AWIDTH )
  ) DUT (
    .mem_if( mem_if ),
    .clk_i( clk )
  );

initial
  begin
    uvm_resource_db #( virtual interface mem_bfm )::set( "*", "bfm", mem_bfm, null );
    run_test();
  end

endmodule
