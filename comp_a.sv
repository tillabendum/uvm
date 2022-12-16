class comp_a extends uvm_component;
`uvm_component_utils( comp_a )


function new ( string name = "comp_a", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

endclass
