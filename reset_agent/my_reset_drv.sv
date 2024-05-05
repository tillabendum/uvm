class my_reset_drv extends uvm_driver#(my_reset_tr);
`uvm_component_utils(my_reset_drv)

my_reset_cfg cfg;

function new (string name="drv", uvm_component parent=null);
  super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(my_reset_cfg)::get(this, "", "cfg", cfg)) begin
    `uvm_fatal("configuration", "Failed to get configuration for reset driver")
  end
endfunction


task run_phase(uvm_phase phase);
  forever begin
    my_reset_tr tr;
    seq_item_port.get_next_item(tr);
    cfg.vif.reset<=1;
    repeat(tr.num_clocks) begin
      @(posedge cfg.vif.clk);
    end
    cfg.vif.reset <= 0;
    seq_item_port.item_done();
  end  
endtask
endclass
