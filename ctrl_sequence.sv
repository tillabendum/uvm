class ctrl_sequence extends uvm_sequence #( ctrl_seq_item );
`uvm_object_utils( ctrl_sequence );

function new( string name = "" );
   super.new( name );
endfunction: new

ctrl_seq_item req;

task body;
   for( int i = 0; i < 4; i++ )
      begin
         req = new();
         req.data = i;
         start_item( req );
         `uvm_info( "ctrl_sequence", { "Sending transaction ", req.convert2string() }, UVM_MEDIUM );
         finish_item( req );
      end
endtask: body
endclass : ctrl_sequence
