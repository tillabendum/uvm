class comp_c extends uvm_component;
`uvm_component_utils(comp_c)

uvm_blocking_put_export #(.T(my_obj)) bpe;
uvm_blocking_master_export #(.REQ(my_obj), .RSP(my_obj)) bme;
uvm_blocking_peek_imp  #(.T(my_obj), .IMP(comp_c)) bpei;

function new (string name = "comp_c", uvm_component parent = null);
  super.new(name, parent);
endfunction: new


task peek(output my_obj obj);
  obj = my_obj::type_id::create("obj", this);
  obj.randomize();
  `uvm_info("peek_imp", "Create object, randomize and send", UVM_NONE)
  obj.print();
  `uvm_info("peek_imp", "Hold 10ns", UVM_NONE)
  #(10ns);
  `uvm_info("peek_imp", "Task released", UVM_NONE)
endtask


virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  bpe=new(
    .name("bpe"),
    .parent(this),
    .min_size(1),
    .max_size(UVM_UNBOUNDED_CONNECTIONS)
  );

  bme=new(
    .name("bme"),
    .parent(this),
    .min_size(1),
    .max_size(UVM_UNBOUNDED_CONNECTIONS)
  );

  bpei=new(
    .name("bpei"),
    .imp(this)
  );

endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_c
