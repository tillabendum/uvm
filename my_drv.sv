class my_drv extends uvm_driver #( my_seq_item );
  `uvm_component_utils( my_drv )

  function new ( string name = "my_drv", uvm_component parent = null );
    super.new( name, parent );
  endfunction: new


  task run_phase( uvm_phase phase );
    forever
      begin
        my_seq_item tr;
        
        seq_item_port.get_next_item( tr );
        `uvm_info("driving",{"Transaction processed: ", tr.convert2string(),"."}, UVM_NONE)
        seq_item_port.item_done();
      end
  endtask

endclass
