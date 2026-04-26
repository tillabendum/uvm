class comp_a extends comp_base;
`uvm_component_utils( comp_a )


function new ( string name = "comp_a", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


task main_phase( uvm_phase phase );
  forever begin
 #100ns;
  end
endtask



endclass
