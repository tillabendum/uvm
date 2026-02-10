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

    num_proxies = harness_if_proxy#(MY_T, "cnt")::proxies.size();
    `uvm_info("harness", $sformatf("num_proxies=%0d",num_proxies), UVM_NONE)

    for(int unsigned cnt_clk = 0; cnt_clk<5; cnt_clk++) begin
      harness_if_proxy#(MY_T, "cnt")::proxies[0].wait_posedge();
      foreach(harness_if_proxy#(MY_T, "cnt")::proxies[i]) begin
        MY_T    val;
        string  str;
          
        val = harness_if_proxy#(MY_T, "cnt")::proxies[i].get_preponed_val();
        if(!harness_if_proxy#(MY_T, "cnt")::proxies[i].name(str)) begin
          `uvm_fatal("harness", "Failed to parse path:")
        end

        `uvm_info("harness", $sformatf("str=%s, val=%0d", str, val), UVM_NONE)
      end
    end

    `uvm_info("log", "ok", UVM_NONE)    
    phase.drop_objection( this );
  endtask

endclass
