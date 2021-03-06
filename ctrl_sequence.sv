class ctrl_sequence extends uvm_sequence #( ctrl_seq_item );
`uvm_object_utils( ctrl_sequence );

function new( string name = "" );
   super.new( name );
endfunction: new

ctrl_seq_item     req;
ctrl_subsequence  subreq;

task pre_start();
  `uvm_info( get_name, "Doing pre_start", UVM_MEDIUM );
endtask

task post_start();
  `uvm_info( get_name, "Doing post_start", UVM_MEDIUM );
endtask


task pre_body();
  `uvm_info( get_name, "Doing pre_body", UVM_MEDIUM );
  subreq = ctrl_subsequence::type_id::create( "subreq" );
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
  for( int i = 0; i < 4; i++ )
    if( i != 2 )
      begin
        req = new();
        req.data = i;
        start_item( req );
        `uvm_info( get_name, { "Sending transaction ", req.convert2string() }, UVM_MEDIUM );
        finish_item( req );
      end
    else
      begin
        subreq.start( m_sequencer, this );
      end
endtask: body
endclass : ctrl_sequence
