class ctrl_drv extends uvm_driver #( ctrl_seq_item );
`uvm_component_utils( ctrl_drv )

function new ( string name = "ctrl_drv", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

ctrl_seq_item req;

task run_phase( uvm_phase phase );
  forever
    begin
      seq_item_port.get_next_item( req ); // nonblocking
      if( req != null )
        begin
          seq_item_port.item_done();
        end
    end
endtask : run_phase

endclass : ctrl_drv
