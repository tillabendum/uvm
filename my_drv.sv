class my_drv extends uvm_driver #( my_seq_item );
`uvm_component_utils( my_drv )

function new ( string name = "my_drv", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


task run_phase( uvm_phase phase );
  forever
    begin
      my_seq_item req;
      seq_item_port.get_next_item( req );
      `uvm_info( "Driver got item", "", UVM_MEDIUM )
      if( req != null )
        seq_item_port.item_done();
    end
endtask



endclass
