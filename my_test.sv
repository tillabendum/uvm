class my_test extends uvm_test;
   `uvm_component_utils( my_test )
   my_env env;

   rand my_reg_block ral;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      env = my_env::type_id::create( "env", this );
      ral = my_reg_block::type_id::create("ral");
      ral.build();
      uvm_resource_db#(my_reg_block)::set("*", "ral", ral, this);
   endfunction : build_phase



  task main_phase( uvm_phase phase );
    my_seq seq;
    phase.raise_objection( this );
    seq = my_seq::type_id::create("seq");
    seq.start( env.ag.seqr );
    phase.drop_objection( this );
  endtask : main_phase

endclass
