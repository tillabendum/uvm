class ctrl_subsequence extends uvm_sequence #( ctrl_seq_item );
`uvm_object_utils( ctrl_subsequence );

function new( string name = "" );
   super.new( name );
endfunction: new

ctrl_seq_item req;


task pre_start();
  `uvm_info( get_name, "Doing pre_start", UVM_MEDIUM );
endtask

task post_start();
  `uvm_info( get_name, "Doing post_start", UVM_MEDIUM );
endtask


task pre_body();
  `uvm_info( get_name, "Doing pre_body", UVM_MEDIUM );
endtask

task post_body();
  `uvm_info( get_name, "Doing post_body", UVM_MEDIUM );
endtask


task pre_do( bit is_item );
  `uvm_info( get_name, $psprintf( "Doing pre_do, is_item=%1b", is_item ), UVM_MEDIUM );
endtask


function void mid_do( uvm_sequence_item this_item );
  `uvm_info( get_name, $psprintf( "Doing mid_do in %s", this_item == null ? "null": this_item.get_name ), UVM_MEDIUM );
endfunction

function void post_do( uvm_sequence_item this_item );
  `uvm_info( get_name, $psprintf( "Doing post_do in %s", this_item == null ? "null": this_item.get_name ), UVM_MEDIUM );
endfunction





task body;
   for( int i = 0; i < 2; i++ )
      begin
         req = new();
         req.data = 100 + i;
         start_item( req );
         `uvm_info( get_name, { "Sending subtransaction ", req.convert2string() }, UVM_MEDIUM );
         finish_item( req );
      end
endtask: body
endclass : ctrl_subsequence
