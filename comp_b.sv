class comp_b extends uvm_component;
`uvm_component_utils(comp_b)

uvm_blocking_put_port #(.T(my_obj)) bpp;

function new (string name = "comp_b", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  bpp=new(
    .name("bpp"),
    .parent(this),
    .min_size(1),
    .max_size(UVM_UNBOUNDED_CONNECTIONS)
  );
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_b
