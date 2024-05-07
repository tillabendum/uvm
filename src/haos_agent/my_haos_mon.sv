class my_haos_mon extends uvm_monitor;
  `uvm_component_utils(my_haos_mon)
  
  my_haos_cfg                     cfg;
  uvm_analysis_port #(my_haos_tr) ap;
  semaphore                       sem;

  function new(string name="mon", uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(my_haos_cfg)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal("configuration", "Failed to get configuration for haos monitor")
    end

    sem = new(1);
    ap = new("ap", this);
  endfunction


  task run_phase(uvm_phase phase);
    forever begin
      @(posedge cfg.vif.clk);
      case({cfg.vif.rd, cfg.vif.wr})
        2'b01: sample_write();
        2'b10: sample_read();
        2'b11: begin
          `uvm_fatal("monitoring", "unexpected command")
        end
      endcase
    end  
  endtask  


  function void phase_ready_to_end(uvm_phase phase);
  // Use your own phase name which you want to stall,
  // should_i_wait_or_not is a variable or function that
  // you should see when do you want to delay the phase or not.
  if(phase.get_name == "run" && (!sem.try_get())) begin
      phase.raise_objection(this);
      fork
        begin
          sem.get();
          phase.drop_objection(this);
        end
      join_none
    end
  endfunction


  task sample_write();
    my_haos_tr tr;
    
    sem.get();
    tr = my_haos_tr::type_id::create("tr");
    tr.op = WR;
    tr.addr = cfg.vif.addr;
    tr.data = cfg.vif.wdata;
    tr.wstrb = cfg.vif.wstrb;

    @(posedge cfg.vif.clk);

    // waiting response
    tr.delay = 0;
    while (!cfg.vif.wstatus_valid) begin
      tr.delay++;
      @(posedge cfg.vif.clk);
    end
    tr.status = cfg.vif.wstatus;
    
    ap.write(tr);
    sem.put();
  endtask


  task sample_read();
    my_haos_tr tr;

    sem.get();
    tr = my_haos_tr::type_id::create("tr");
    tr.op = RD;
    tr.addr = cfg.vif.addr;
    
    @(posedge cfg.vif.clk);

    // waiting response
    tr.delay = 0;
    while (!cfg.vif.rdata_valid) begin
      tr.delay++;
      @(posedge cfg.vif.clk);
    end
    tr.data = cfg.vif.rdata;
    tr.status = cfg.vif.rstatus;
    
    ap.write(tr);
    sem.put();
  endtask

endclass