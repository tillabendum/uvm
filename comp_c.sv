class comp_c extends uvm_component;
`uvm_component_utils( comp_c )


function new ( string name = "comp_c", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

task run_phase( uvm_phase phase );
 #150ns;
endtask

endclass
