class my_test extends uvm_test;
   `uvm_component_utils( my_test )

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
    super.build_phase( phase );
   endfunction : build_phase

  task main_phase( uvm_phase phase );
    int res;
    int num_proxies;
 
    phase.raise_objection( this );

    num_proxies = harness_if_proxy#(MY_T)::proxies.size();
    `uvm_info("harness", $sformatf("num_proxies=%0d",num_proxies), UVM_NONE)
    harness_if_proxy#(MY_T)::proxies[0].wait_posedge();
    foreach(harness_if_proxy#(MY_T)::proxies[i]) begin
       MY_T    val;
       string  str;
        
       val = harness_if_proxy#(MY_T)::proxies[i].get_current_val();
       if(!harness_if_proxy#(MY_T)::proxies[i].name(str)) begin
         `uvm_fatal("harness", "Failed to parse path:")
       end

       `uvm_info("harness", $sformatf("str=%s, val=%0d", str, val), UVM_NONE)
    end
 
    begin
       MY_T val;
       harness_if_proxy#(MY_T)::proxies[1].wait_posedge();
       `uvm_info("harness", "Posedge received. State new values", UVM_NONE)
       harness_if_proxy#(MY_T)::proxies[1].force_next_nba(1);
       harness_if_proxy#(MY_T)::proxies[1].force_next_nba(2);
       `uvm_info("harness", "Update implemented", UVM_NONE)

       val = harness_if_proxy#(MY_T)::proxies[1].get_current_val();
       `uvm_info("harness", $sformatf("new val (current at the moment)=%0d",val), UVM_NONE)
       
       val = harness_if_proxy#(MY_T)::proxies[1].get_preponed_val();
       `uvm_info("harness", $sformatf("preponed val=%0d",val), UVM_NONE)
    end
    harness_if_proxy#(MY_T)::proxies[1].wait_posedge();
 

    `uvm_info("log", "ok", UVM_NONE)    
    phase.drop_objection( this );
  endtask

endclass
