class my_reset_mon extends uvm_monitor;
  `uvm_component_utils(my_reset_mon)
  
  my_reset_cfg   cfg;
  uvm_analysis_port#(my_reset_tr) ap;

  function new (string name="mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(my_reset_cfg)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal("configuration", "Failed to get configuration for reset monitor")
    end

    ap = new("ap", this);
  endfunction


  task run_phase(uvm_phase phase);
    forever begin
      my_reset_tr tr;

      do begin
        @(posedge cfg.vif.clk);
      end while(cfg.vif.reset !== 1'b1);
      // it is created with num_clocks equal to 1
      tr = my_reset_tr::type_id::create("tr");
      forever begin
        @(posedge cfg.vif.clk);
        if (cfg.vif.reset) begin
          tr.num_clocks++;
        end else begin
          break;
        end
      end
      ap.write(tr);
    end

  endtask

endclass