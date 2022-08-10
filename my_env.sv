class my_env extends uvm_env;
`uvm_component_utils( my_env )


uvm_sequencer #( mem_req_item )   sequencer;
mem_ladder_seq ladder;
mem_drv  drv;


function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  sequencer = new( "sequencer", this );
  ladder = mem_ladder_seq::type_id::create( "ladder", this );
  drv = mem_drv::type_id::create( "drv", this );
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
  drv.seq_item_port.connect( sequencer.seq_item_export );
endfunction


task run_phase( uvm_phase phase );
  phase.raise_objection( this );
  ladder.start( sequencer );
  phase.drop_objection( this );

endtask : run_phase


endclass:my_env
