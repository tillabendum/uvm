interface mem_bfm(
    interface itf
  );

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_params_pkg::AWIDTH;
import my_params_pkg::DWIDTH;

import my_pkg::mem_req_item;


default clocking cb @( posedge itf.clk_i );
  output  wr    = itf.wr,
          rd    = itf.rd,
          data  = itf.data,
          addr  = itf.addr;
endclocking





//default disable iff ( itf.srst_i !== 1'b0 );
initial
  begin
    cb.wr <= 0;
    cb.rd <= 0;
  end

task drive( mem_req_item req );

  while( itf.srst_i !== 1'b0 )
    @( negedge itf.clk_i )

  ##0;

  assert( req != null ) else `uvm_fatal( "null_object", "Request to drive null object" );

  if( req.op == my_pkg::mem_req_item::WR )
    begin
      cb.wr   <=  1;
      cb.data <= req.data;
      cb.addr <= req.addr;
      ##1;
      cb.wr   <=  0;
      cb.data <= 'x;
      cb.addr <= 'x;
    end


endtask




endinterface
