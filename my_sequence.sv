class my_sequence extends uvm_sequence #( my_seq_item );
`uvm_object_utils( my_sequence );


rand int pauses[];

constraint num_items_ct{
  pauses.size inside { [1:10] };
}

constraint pause_range_ct{
  foreach( pauses[i] )
    pauses[i] inside { [1:5] };
}

function new( string name = "" );
   super.new( name );
endfunction: new

task pre_start;
  randomize();
  `uvm_info( "Sequence created", $psprintf( "%0d items to send", pauses.size ), UVM_MEDIUM )
endtask

task body;
  foreach( pauses[i] )
    begin
      my_seq_item req;
      repeat( pauses[i] )
        #1ns;
      req = new;
      `uvm_info( "Item created", "", UVM_MEDIUM )
      start_item( req );
      `uvm_info( "Item taken", "", UVM_MEDIUM )
      finish_item( req );
    end
endtask

endclass
