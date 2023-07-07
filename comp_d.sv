class comp_d extends uvm_component;
`uvm_component_utils(comp_d)

function new (string name = "comp_d", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_d
