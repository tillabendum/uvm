class test extends uvm_test;
   `uvm_component_utils(test)
   my_env env;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = my_env::type_id::create("env", this);
   endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);


    phase.drop_objection(this);
  endtask

endclass
