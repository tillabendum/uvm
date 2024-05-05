class my_haos extends uvm_agent;
  `uvm_component_utils(my_haos)
  
  my_haos_cfg                 cfg;
  uvm_sequencer#(my_haos_tr)  seqr;
  my_haos_drv                 drv;
  my_haos_mon                 mon;

  function new(string name="haos", uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(my_haos_cfg)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal("configuration", "Failed to get configuration for haos agent")
    end

    seqr = uvm_sequencer#(my_haos_tr)::type_id::create("seqr", this);
    drv  = my_haos_drv::type_id::create("drv", this);
    mon  = my_haos_mon::type_id::create("mon", this); 
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass