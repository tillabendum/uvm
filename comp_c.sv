class comp_c extends uvm_component;
`uvm_component_utils(comp_c)

uvm_blocking_put_export #(.T(my_obj)) bpe;


function new (string name = "comp_c", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  bpe=new(
    .name("bpe"),
    .parent(this),
    .min_size(1),
    .max_size(UVM_UNBOUNDED_CONNECTIONS)
  );
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_c
