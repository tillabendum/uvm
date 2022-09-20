class mem_drv extends uvm_driver #( mem_req_item );
`uvm_component_utils( mem_drv )

function new ( string name = "mem_drv", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


local virtual mem_bfm  bfm;


function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  if( !uvm_resource_db #( virtual interface mem_bfm )::read_by_name( "shared", "bfm", bfm, this ) )
    begin
      `uvm_fatal( "resource", "Config Error" )
    end
endfunction : build_phase






task run_phase( uvm_phase phase );
  forever
    begin
      mem_req_item req;

      // Blocks until a request item is available from the sequencer.
      this.seq_item_port.get_next_item( req );
      `uvm_info( "Driver got item", "", UVM_MEDIUM )

      assert( req != null ) else
      `uvm_fatal( "null_object", "Driver received null request transaction" )

      bfm.drive( req );

      //Non-blocking method which completes the driver-sequencer handshake.
      this.seq_item_port.item_done();
      `uvm_info( "Driver released item", "", UVM_MEDIUM )


    end
endtask



endclass
