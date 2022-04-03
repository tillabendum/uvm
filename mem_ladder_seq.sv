class mem_ladder_seq #(
  parameter AWIDTH = 8,
  parameter DWIDTH = 8
) extends uvm_sequence #( mem_req_item );
`uvm_object_utils( mem_ladder_seq );



function new( string name = "" );
   super.new( name );
endfunction: new


task body;
  int upper_limit;
  upper_limit = 2 ** AWIDTH;
  for( int addr = 0; addr < upper_limit; addr++ )
    begin
      mem_req_item req;
      req = new;
      req.addr = addr;
      std::randomize( req.data );
      `uvm_info( "Item created", "", UVM_MEDIUM )
      start_item( req );
      `uvm_info( "Item taken", "", UVM_MEDIUM )
      finish_item( req );
    end
endtask

endclass
