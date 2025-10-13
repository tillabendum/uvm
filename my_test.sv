class my_test extends uvm_test;
   `uvm_component_utils( my_test )
   my_env env;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
    super.build_phase( phase );

    env = my_env::type_id::create( "env", this );
   endfunction : build_phase

  task main_phase( uvm_phase phase );
    int res;
    int num_proxies;
 
    phase.raise_objection( this );

    num_proxies = harness_if_proxy#(MY_T)::proxies.size();
    `uvm_info("harness", $sformatf("num_proxies=%0d",num_proxies), UVM_NONE)
    harness_if_proxy#(MY_T)::proxies[0].wait_posedge();
    foreach(harness_if_proxy#(MY_T)::proxies[i]) begin
       MY_T val;
       val = harness_if_proxy#(MY_T)::proxies[i].get_val;
       `uvm_info("harness", $sformatf("val=%0d",val), UVM_NONE)
    end
 
    begin
       MY_T val;
 
       harness_if_proxy#(MY_T)::proxies[1].force_val(1);
       val = harness_if_proxy#(MY_T)::proxies[1].get_val;
       `uvm_info("harness", $sformatf("new val=%0d",val), UVM_NONE)
    end
 
    //VPI access
    res = uvm_hdl_check_path("top_tb");
    `uvm_info("log", $sformatf("res=%0d", res), UVM_NONE)





    `uvm_info("log", "Hello world", UVM_NONE)    
    phase.drop_objection( this );
  endtask

endclass
