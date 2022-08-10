class mem_ladder_seq extends uvm_sequence #( mem_req_item );

`uvm_object_utils( mem_ladder_seq );

api_write_seq api_write;

function new( string name = "" );
   super.new( name );
endfunction: new

task body;
  int upper_limit;
  upper_limit = 2 ** AWIDTH;
  api_write = api_write_seq::type_id::create( "api_write" );
  for( int addr = 0; addr < upper_limit; addr++ )
    begin
      bit [DWIDTH - 1 : 0] data;
      std::randomize( data );
      api_write.write( addr, data, m_sequencer, this );
    end
endtask

endclass
