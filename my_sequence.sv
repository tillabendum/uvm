class my_sequence extends uvm_sequence #( my_seq_item );
`uvm_object_utils( my_sequence );


function new( string name = "" );
   super.new( name );
endfunction: new


task body;
      my_seq_item req;

      req = my_seq_item::type_id::create("req");
      start_item( req );
      finish_item( req );
endtask

endclass
