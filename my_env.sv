class my_env extends uvm_env;
`uvm_component_utils( my_env )


mem_ladder_seq  ladder;
mem_ag          ag;
my_reg_block    address_model;
reg2bus_adapter adapter;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  int ret;
  super.build_phase( phase );
  ladder = mem_ladder_seq::type_id::create( "ladder", this );
  ag = mem_ag::type_id::create( "ag", this );
  uvm_config_db #( int ) :: set( this, "", "popularity", 100 );
  uvm_config_db #( int ) :: get( this, "", "popularity", ret );

  if (!(uvm_config_db#(my_reg_block)::get(this, "", "address_model", address_model))) begin
    `uvm_fatal("config", "Failed to receive address_model from test")
  end

endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
  address_model.default_map.set_sequencer(ag.sequencer, adapter);

endfunction


task run_phase( uvm_phase phase );
  phase.raise_objection( this );
  ladder.start( ag.sequencer );
  phase.drop_objection( this );

endtask : run_phase


endclass:my_env
