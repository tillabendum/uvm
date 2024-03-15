class my_drv extends uvm_driver #(my_seq_item);
`uvm_component_utils(my_drv)

function new (string name = "my_drv", uvm_component parent = null);
  super.new(name, parent);
endfunction: new


task run_phase(uvm_phase phase);
  forever
    begin
      my_seq_item req;
      seq_item_port.get_next_item(req);
      `uvm_info("Driver got item", "", UVM_MEDIUM)
      if (req != null)
        begin
          int processing_time;
          randomize(processing_time) with {processing_time inside {[0:4]};};
          repeat(processing_time)
            #1ns;
          `uvm_info("Driver did delay", $psprintf("%0d", processing_time), UVM_MEDIUM)
          seq_item_port.item_done();
        end
    end
endtask

endclass
