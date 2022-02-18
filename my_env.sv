class my_env extends uvm_env;
`uvm_component_utils( my_env )

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
endfunction

virtual task run_phase( uvm_phase phase );
  my_item first;
  my_item second;
  bit res;

  super.run_phase( phase );
  phase.raise_objection( this );

  first = new;
  first = my_item::type_id::create( "first", null );
  second = my_item::type_id::create( "second", null );

  first.a = 12;
  second.copy( first );
  second.print();
  res = first.compare( second );
  `uvm_info( "comparision", $psprintf( "Expected equal (i.e. 1):%1b", res ), UVM_MEDIUM )
  second.a = 13;
  second.flag = 1;
  res = first.compare( second );
  `uvm_info( "comparision", $psprintf( "Expected non-equal (i.e. 0):%1b", res ), UVM_MEDIUM )


  phase.drop_objection( this );
endtask



endclass:my_env
