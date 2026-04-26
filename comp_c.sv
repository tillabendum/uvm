class comp_c extends comp_base;
`uvm_component_utils( comp_c )


function new ( string name = "comp_c", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

task run_phase( uvm_phase phase );
  forever begin
 #200ns;
  end
endtask



endclass
