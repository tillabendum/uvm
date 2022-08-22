class component extends uvm_component;
`uvm_component_utils( component )

subcomponent                        subcmp;

function new ( string name = "component", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

function void build_phase( uvm_phase phase );
  int val;
  super.build_phase( phase );

  if( !uvm_config_db #( int )::get( this, "", "val", val ) )
    begin
      `uvm_fatal( get_name(), "Config Error" )
    end
  `uvm_info( "config", $psprintf( "Received for propagation val = %0d", val ), 100 )

// Creating subhierarchy
subcmp = subcomponent::type_id::create( "subcmp", this );

// Propagating value to subhierarchy
uvm_config_db #( int )::set( this, "subcmp", "val", val );

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
