class mem_drv extends uvm_driver #( mem_req_item );
`uvm_component_utils( mem_drv )

function new ( string name = "mem_drv", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


task run_phase( uvm_phase phase );
  forever
    begin
      mem_req_item req;
      seq_item_port.get_next_item( req );
      `uvm_info( "Driver got item", "", UVM_MEDIUM )
      if( req != null )
        begin
          seq_item_port.item_done();
        end
    end
endtask



endclass
