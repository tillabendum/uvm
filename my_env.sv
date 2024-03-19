class my_env extends uvm_env;
`uvm_component_utils( my_env )


mem_ag                            ag;
my_reg_block                      ral;
reg2bus_adapter                   adapter;
uvm_reg_predictor#(mem_req_item)  predictor;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  ag = mem_ag::type_id::create( "ag", this );


  if (!(uvm_resource_db#(my_reg_block)::read_by_type(get_full_name, ral, this))) begin
    `uvm_fatal("config", "Failed to receive ral from test")
  end

  predictor = uvm_reg_predictor#(mem_req_item)::type_id::create("predictor", this);
  adapter = reg2bus_adapter::type_id::create("adapter", this);
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );

  // Connecting sequencer and adapter to map
  ral.default_map.set_sequencer(ag.seqr, adapter);

  // Connecting predictor
  predictor.map     = ral.default_map;
  predictor.adapter = adapter;
  ag.mon.mon_analysis_port.connect(predictor.bus_in);

endfunction





endclass:my_env
