class my_test extends uvm_test;
   `uvm_component_utils( my_test )
   my_env env;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
      int res;
      super.build_phase( phase );

      res = uvm_hdl_check_path("top_tb");
      `uvm_info("log", $sformatf("res=%0d", res), UVM_NONE)
      env = my_env::type_id::create( "env", this );
   endfunction : build_phase

  task main_phase( uvm_phase phase );
    phase.raise_objection( this );
    `uvm_info("log", "Hello world", UVM_NONE)    
    phase.drop_objection( this );
  endtask

endclass
