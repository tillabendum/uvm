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

virtual task run_phase(uvm_phase phase);
  my_obj  obj;
  phase.raise_objection(this);
  obj = my_obj::type_id::create("obj", this);
  obj.randomize();
  `uvm_info("put_port", "Create object, randomize and send", UVM_NONE)
  obj.print();
  bpp.put(obj);
  `uvm_info("put_port", "Task released", UVM_NONE)
  phase.drop_objection(this);
endtask

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_b
