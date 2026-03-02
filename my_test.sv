class my_test extends uvm_test;
   `uvm_component_utils( my_test )

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction : new

   function void build_phase( uvm_phase phase );
    super.build_phase( phase );
   endfunction : build_phase

  task main_phase( uvm_phase phase );
    
 
    phase.raise_objection( this );

    begin
      int num_proxies;
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
    end

    begin
      typedef logic [9:0] map_t[2];
      typedef harness_if_proxy#(map_t, "map") proxy_t;
      int num_proxies;

      num_proxies = proxy_t::proxies.size();
      `uvm_info("harness-map", $sformatf("num_proxies=%0d",num_proxies), UVM_NONE)

      for(int unsigned cnt_clk = 0; cnt_clk<5; cnt_clk++) begin
        proxy_t::proxies[0].wait_posedge();
        foreach(proxy_t::proxies[i]) begin
          map_t    val;
          string   str;
            
          val = proxy_t::proxies[i].get_preponed_val();
          if(!proxy_t::proxies[i].name(str)) begin
            `uvm_fatal("harness-map", "Failed to parse path:")
          end

          `uvm_info("harness-map", $sformatf("str=%s, val0=%0d, val1=%0d", str, val[0], val[1]), UVM_NONE)
        end
      end
    end

    `uvm_info("log", "ok", UVM_NONE)    
    phase.drop_objection( this );
  endtask

endclass
