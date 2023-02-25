class my_test extends uvm_test;
   `uvm_component_utils( my_test )
   my_env env;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      env = my_env::type_id::create( "env", this );

      // Targeting to environments infos in a recursive way
      set_report_severity_action_hier( UVM_INFO, UVM_DISPLAY |  UVM_LOG );
   endfunction : build_phase

  task run_phase( uvm_phase phase );
    phase.raise_objection( this );
    super.run();
    phase.drop_objection( this );
  endtask

endclass
