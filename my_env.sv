class my_env extends uvm_env;
`uvm_component_utils( my_env )

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


comp_a a;
comp_b b;


virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  a = comp_a::type_id::create( "a", this );
  b = comp_b::type_id::create( "b", this );
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
endfunction


virtual function void end_of_elaboration_phase( uvm_phase phase );
  uvm_top.print_topology();
endfunction


endclass:my_env
