class my_generator extends uvm_agent;

`uvm_component_utils( my_generator )

uvm_put_port #( my_data ) src;

function new ( string name = "my_generator", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  src = new( "src", this );
endfunction : build_phase

task run_phase( uvm_phase phase );
  my_data   data = new;
  phase.raise_objection( this );
  super.run();
  //
  repeat( 10 )
    #( 6ns )
      begin
        data.randomize();
        put_data( data );
      end
  `uvm_info( "gen", "generation finished", UVM_INFO );
  //
  phase.drop_objection( this );
endtask

task put_data( my_data data );
  my_data data_cpy;
  $cast( data_cpy, data.clone );
  src.put( data_cpy );
endtask



endclass: my_generator
