class mem_drv extends uvm_driver #( mem_req_item );
`uvm_component_utils( mem_drv )

function new ( string name = "mem_drv", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


local virtual mem_bfm  bfm;


function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  if( !uvm_config_db #( virtual interface mem_bfm )::get( this, "", "bfm", bfm ) )
  `uvm_fatal( "resource", "Config Error" )
endfunction : build_phase






task run_phase( uvm_phase phase );
  forever
    begin
      mem_req_item req;
      seq_item_port.get_next_item( req );
      `uvm_info( "Driver got item", "", UVM_MEDIUM )

      assert( req != null ) else
      `uvm_fatal( "null_object", "Driver received null request transaction" )

      bfm.drive( req );

      seq_item_port.item_done();
      `uvm_info( "Driver released item", "", UVM_MEDIUM )


    end
endtask



endclass
