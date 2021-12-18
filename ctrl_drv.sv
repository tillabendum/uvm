class ctrl_drv extends uvm_driver #( ctrl_seq_item );
`uvm_component_utils( ctrl_drv )

function new ( string name = "ctrl_drv", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

ctrl_seq_item req;

task run_phase( uvm_phase phase );
  forever
    begin
      `uvm_info( get_name, { "Before getting item" }, UVM_MEDIUM );
      seq_item_port.get_next_item( req ); // nonblocking
      if( req != null )
        begin
          // Consume time
          `uvm_info( get_name, $psprintf( "After getting item perform transaction with %0d and details=%0h", req.data, req.details ), UVM_MEDIUM );
          #( 10ns );
          seq_item_port.item_done();
        end
      `uvm_info( get_name, { "After item done" }, UVM_MEDIUM );
    end
endtask : run_phase

endclass : ctrl_drv
