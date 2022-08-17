class mem_mon extends uvm_monitor;

`uvm_component_utils( mem_mon )

local virtual mem_bfm  bfm;

function new( string name = "mem_mon", uvm_component parent = null );
  super.new( name, parent );
endfunction


uvm_analysis_port #( mem_req_item ) mon_analysis_port;

//////////////
// B U I L D
//////////////
function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  mon_analysis_port = new( "mon_analysis_port", this );

  if( !uvm_config_db #( virtual interface mem_bfm )::get( this, "", "bfm", bfm ) )
  `uvm_fatal( "resource", "Config Error" )
endfunction

//////////////
// R U N
//////////////
virtual task run_phase( uvm_phase phase );
mailbox mbx;
mbx = new;

fork
  bfm.monitor( mbx );
  forever
    begin
      mem_req_item req;
      mbx.get( req );
      mon_analysis_port.write( req );
    end
join


endtask



endclass
