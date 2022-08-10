class api_read_seq extends uvm_sequence #( mem_req_item );

`uvm_object_utils( api_read_seq )


bit [AWIDTH - 1 : 0]  addr;
bit [DWIDTH - 1 : 0]  data;


task body();
  req = mem_req_item::type_id::create( "mem_write_request" );
  start_item( req );
  if( !( req.randomize() with {
    req.addr == local::addr;
    req.op   == mem_req_item::RD;
    }
  ) )
    `uvm_error( "randomization", "Randomize Failed!" )
  finish_item( req );
endtask : body



task read( bit [7:0] addr, uvm_sequencer_base seqr, uvm_sequence_base parent = null );
  this.addr = addr;
  this.start( seqr, parent );
endtask : read


endclass
