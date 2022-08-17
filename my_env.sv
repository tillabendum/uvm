class my_env extends uvm_env;
`uvm_component_utils( my_env )


mem_ladder_seq  ladder;
mem_ag          ag;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  ladder = mem_ladder_seq::type_id::create( "ladder", this );
  ag = mem_ag::type_id::create( "ag", this );
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
endfunction


task run_phase( uvm_phase phase );
  phase.raise_objection( this );
  ladder.start( ag.sequencer );
  phase.drop_objection( this );

endtask : run_phase


endclass:my_env
