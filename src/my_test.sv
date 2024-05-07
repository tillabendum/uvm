class my_test extends uvm_test;
   `uvm_component_utils( my_test )
   my_env env;

   my_haos_reg_block    ral;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
      my_reset_cfg    reset_cfg;
      my_haos_cfg     haos_cfg;
      my_env_cfg      env_cfg;
  

      super.build_phase( phase );

      reset_cfg = my_reset_cfg::type_id::create("reset_cfg");
      if(!uvm_config_db#(virtual interface my_reset_if)::get(this,"","reset_vif", reset_cfg.vif)) begin
        `uvm_fatal("configuration", "Failed to get configuration")
      end

      haos_cfg = my_haos_cfg::type_id::create("haos_cfg");
      if(!uvm_config_db#(virtual interface my_haos_if)::get(this,"","haos_vif", haos_cfg.vif)) begin
        `uvm_fatal("configuration", "Failed to get configuration")
      end

      ral = my_haos_reg_block::type_id::create("ral");
      ral.configure(.parent(null), .hdl_path("top_tb.dut"));
      ral.build();
  
      env_cfg = my_env_cfg::type_id::create("env_cfg");
      env_cfg.reset_cfg = reset_cfg;
      env_cfg.haos_cfg = haos_cfg;
      env_cfg.ral = ral;

      uvm_config_db#(my_env_cfg)::set(this, "env", "cfg", env_cfg);

      env = my_env::type_id::create( "env", this );
   endfunction : build_phase


  task reset_phase( uvm_phase phase);
    my_reset_seq seq;

    phase.raise_objection( this );
    seq = my_reset_seq::type_id::create("seq");
    seq.start(env.reset.seqr);
    phase.drop_objection( this );
  endtask


  task main_phase( uvm_phase phase );
    my_haos_seq haos_seq;
    my_muos_seq muos_seq;
    my_muos_mem_seq muos_mem_seq;

    phase.raise_objection( this );
 
    haos_seq = my_haos_seq::type_id::create("haos_seq");
    haos_seq.ral = ral;
    haos_seq.start(null);

    muos_seq = my_muos_seq::type_id::create("muos_seq");
    muos_seq.ral = ral;
    muos_seq.start(null);
   
    muos_mem_seq = my_muos_mem_seq::type_id::create("muos_mem_seq");
    muos_mem_seq.ral = ral;
    muos_mem_seq.start(null);
   
    phase.drop_objection( this );
  endtask : main_phase

endclass
