class my_env extends uvm_env;
`uvm_component_utils( my_env )

my_reset                          reset;
my_haos                           haos;
my_reg2bus_adapter                adapter;
uvm_reg_predictor#(my_haos_tr)    predictor;
my_env_cfg                        cfg;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );


  if(uvm_config_db#(my_env_cfg)::get(this,"","cfg", cfg)) begin
    uvm_config_db#(my_reset_cfg)::set(this, "reset*", "cfg", cfg.reset_cfg);
    uvm_config_db#(my_haos_cfg)::set(this, "haos*", "cfg", cfg.haos_cfg);
  end else begin
    `uvm_fatal("configuration", "Failed to get configuration item")
  end

  haos = my_haos::type_id::create( "haos", this );
  reset = my_reset::type_id::create( "reset", this);

  predictor = uvm_reg_predictor#(my_haos_tr)::type_id::create("predictor", this);
  adapter = my_reg2bus_adapter::type_id::create("adapter", this);
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );

  // Connecting sequencer and adapter to map
  cfg.ral.default_map.set_sequencer(haos.seqr, adapter);

  // Connecting predictor
  predictor.map     = cfg.ral.default_map;
  predictor.adapter = adapter;
  haos.mon.ap.connect(predictor.bus_in);

endfunction





endclass:my_env
