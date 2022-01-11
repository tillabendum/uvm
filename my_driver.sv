class my_driver extends uvm_agent;

`uvm_component_utils( my_driver )

uvm_get_port #( my_data ) dst;



virtual interface my_if vif;

function new ( string name = "my_driver", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  dst = new ( "dst", this );

  if( !uvm_config_db #( virtual interface my_if )::get( this, "", "vif", vif ) )
    `uvm_fatal( get_name(), "Config Error" )

endfunction : build_phase

task run_phase( uvm_phase phase );
  my_data data;
  phase.raise_objection( this );
  super.run();
  //
  repeat( 10 )
    @( posedge vif.clk_i )
      begin
        dst.get( data );
        vif.cnt <= vif.cnt + 1;
        //uvm_report_info( "run", $psprintf( "got %0d-%08h", vif.cnt, data.a ) );
      end
  //
  phase.drop_objection( this );
endtask

endclass: my_driver
