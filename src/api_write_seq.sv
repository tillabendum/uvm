class api_write_seq extends uvm_sequence #( mem_req_item );

`uvm_object_utils( api_write_seq )


bit [AWIDTH - 1 : 0]  addr;
bit [DWIDTH - 1 : 0]  data;

function new( string name = "" );
  super.new( name );
endfunction

task body();
  req = mem_req_item::type_id::create( "mem_write_request" );
  start_item( req );
  if( !( req.randomize() with {
    req.addr == local::addr;
    req.data == local::data;
    req.op   == WR;
    } ) )
    `uvm_error( "randomization", "Randomize Failed!" )
  finish_item( req );
endtask : body



task write( bit [7:0] addr, bit [15:0] data, uvm_sequencer_base seqr, uvm_sequence_base parent = null );
  this.addr = addr;
  this.data = data;
  this.start( seqr, parent );
endtask : write


endclass
