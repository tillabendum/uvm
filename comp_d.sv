class comp_d extends uvm_component;
`uvm_component_utils(comp_d)

uvm_blocking_put_imp #(.T(my_obj), .IMP(comp_d)) bpi;

task put(my_obj obj);
  `uvm_info("imp", "Received object", UVM_NONE)
  obj.print();
  `uvm_info("imp", "Hold 10ns", UVM_NONE)
  #(10ns);
endtask

function new (string name = "comp_d", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  bpi=new(
    .name("bpe"),
    .imp(this)
  );
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_d
