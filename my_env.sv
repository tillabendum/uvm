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

endclass:my_env
