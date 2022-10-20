class my_subcomp extends uvm_component;
`uvm_component_utils( my_subcomp )

function new ( string name = "my_subcomp", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  `uvm_info( "phasing", "build_phase", UVM_MEDIUM )
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
  `uvm_info( "phasing", "connect_phase", UVM_MEDIUM )
endfunction

endclass:my_subcomp
