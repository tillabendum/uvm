class my_reset extends uvm_agent;
`uvm_component_utils(my_reset)

my_reset_cfg                  cfg;
my_reset_drv                  drv;
my_reset_mon                  mon;
uvm_sequencer#(my_reset_tr)   seqr;

function new (string name="reset", uvm_component parent=null);
  super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(my_reset_cfg)::get(this, "", "cfg", cfg)) begin
    `uvm_fatal("configuration", "Failed to get configuration for reset agent")
  end
 
  drv = my_reset_drv::type_id::create("drv", this);
  mon = my_reset_mon::type_id::create("mon", this);
  seqr = uvm_sequencer#(my_reset_tr)::type_id::create("seqr", this);
endfunction


function void connect_phase(uvm_phase phase);
  drv.seq_item_port.connect(seqr.seq_item_export);
endfunction


endclass