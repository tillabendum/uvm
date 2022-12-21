class comp_b extends uvm_component;
`uvm_component_utils( comp_b )


function new ( string name = "comp_b", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

task main_phase( uvm_phase phase );
 phase.raise_objection(this, "B in run");
 #120ns;
 phase.drop_objection(this,"C stopped");
endtask

endclass
