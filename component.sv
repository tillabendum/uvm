class component extends uvm_component;
`uvm_component_utils( component )

function new ( string name = "component", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

  int val;
function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  if( !uvm_config_db #( int )::get( this, "", "val", val ) )
    begin
      `uvm_fatal( get_name(), "Config Error" )
    end
  `uvm_info( get_name(), $psprintf( "Received val = %0d", val ), 100 )



endfunction : build_phase




function void end_of_elaboration_phase( uvm_phase phase );
  super.end_of_elaboration_phase( phase );
  `uvm_info( get_name(), get_full_name, 100 );


endfunction



task run_phase( uvm_phase phase );
  phase.raise_objection( this );
  super.run();
  //


  //
  phase.drop_objection( this );
endtask
endclass
