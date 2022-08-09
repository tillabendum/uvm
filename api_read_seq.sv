class api_read_seq #(
  parameter DWIDTH = 8,
  parameter AWIDTH = 8
) extends uvm_sequence #( api_read_seq );

`uvm_object_utils( api_read_seq )


bit [AWIDTH - 1 : 0]  addr;
bit [DWIDTH - 1 : 0]  data;


task body();
  req = mem_req_item #( .DWIDTH( DWIDTH ), .AWIDTH( AWIDTH ) )::type_id::create( "mem_write_request" );
  start_item( req );
  if( !( req.randomize() with {
    req.addr == local::addr;
    req.op   == RD;
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
