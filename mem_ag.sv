class mem_ag extends uvm_agent;

`uvm_component_utils( mem_ag )



function new( string name = "mem_ag", uvm_component parent = null );
  super.new( name, parent );
endfunction



mem_drv                           drv;
mem_mon                           mon;
uvm_sequencer #( mem_req_item )   seqr;



virtual function void build_phase( uvm_phase phase );
  //If this UVM agent is active, then build driver and sequenceer
  if( get_is_active() )
    begin
      drv = mem_drv::type_id::create( "drv", this );
      seqr = new( "sequencer", this );
    end

  // Both active andpassive agents need a monitor
   mon = mem_mon::type_id::create( "mon", this );

endfunction


virtual function void connect_phase( uvm_phase phase );
  if( get_is_active() )
    drv.seq_item_port.connect( seqr.seq_item_export );
endfunction


virtual function void start_of_simulation_phase( uvm_phase phase );
  uvm_resource_pool pool;
  pool = uvm_resource_pool::get();
  pool.dump(1);
endfunction

endclass
