class comp_b extends uvm_component;
`uvm_component_utils( comp_b )


function new ( string name = "comp_b", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

endclass
