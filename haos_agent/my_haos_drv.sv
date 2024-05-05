class my_haos_drv extends uvm_driver#(my_haos_tr);
  `uvm_component_utils(my_haos_drv)
  
  my_haos_cfg cfg;

  function new(string name="drv", uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(my_haos_cfg)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal("configuration", "Failed to get configuration for haos driver")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      my_haos_tr tr;
      seq_item_port.get_next_item(tr);

      if (tr.op == WR) begin
        write(tr); 
      end else if (tr.op == RD) begin
        read(tr);
      end else begin
        `uvm_fatal("driving", $sformatf("Unexpected op type %s", tr.op.name))
      end

      seq_item_port.item_done();
      seq_item_port.put(tr);
    end  
  endtask  

  task write(ref my_haos_tr tr);
    // Driving request
    cfg.vif.wr    <= 1;
    cfg.vif.addr  <= tr.addr;
    cfg.vif.wdata  <= tr.data;
    cfg.vif.wstrb <= tr.wstrb;
 
    @(posedge cfg.vif.clk);
    
    cfg.vif.wr    <= 0;
    cfg.vif.addr  <= 'x;
    cfg.vif.wdata  <= 'x;
    cfg.vif.wstrb <= 'x;
    
    // waiting response
    tr.delay = 0;
    while (!cfg.vif.wstatus_valid) begin
      tr.delay++;
      @(posedge cfg.vif.clk);
    end
    tr.status = cfg.vif.wstatus;

  endtask


  task read(ref my_haos_tr tr);
    // Driving request
    cfg.vif.rd    <= 1;
    cfg.vif.addr  <= tr.addr;
 
    @(posedge cfg.vif.clk);
    
    cfg.vif.rd    <= 0;
    cfg.vif.addr  <= 'x;
    
    // waiting response
    tr.delay = 0;
    while (!cfg.vif.rdata_valid) begin
      tr.delay++;
      @(posedge cfg.vif.clk);
    end
    tr.data = cfg.vif.rdata;
    tr.status = cfg.vif.rstatus;
  endtask


  task idle();
    cfg.vif.wr    <= 0;
    cfg.vif.rd    <= 0;
    cfg.vif.addr  <= 'x;
    cfg.vif.wdata <= 'x;
    cfg.vif.wstrb <= 'x;
  endtask

endclass