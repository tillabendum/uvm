class comp_d extends uvm_component;
`uvm_component_utils(comp_d)

uvm_blocking_put_imp  #(.T(my_obj), .IMP(comp_d)) bpi;
uvm_blocking_get_imp  #(.T(my_obj), .IMP(comp_d)) bgi;

uvm_blocking_master_imp #(.REQ(my_obj), .RSP(my_obj), .IMP(comp_d)) bmi;

task put(my_obj obj);
  `uvm_info("put_imp", "Received object", UVM_NONE)
  obj.print();
  `uvm_info("put_imp", "Hold 10ns", UVM_NONE)
  #(10ns);
endtask


task get(output my_obj obj);
  obj = my_obj::type_id::create("obj", this);
  obj.randomize();
  `uvm_info("get_imp", "Create object, randomize and send", UVM_NONE)
  obj.print();
  `uvm_info("get_imp", "Hold 10ns", UVM_NONE)
  #(10ns);
  `uvm_info("get_imp", "Task released", UVM_NONE)
endtask


task peek(output my_obj obj);
  obj = my_obj::type_id::create("obj", this);
  obj.randomize();
  `uvm_info("peek_imp", "Create object, randomize and peek", UVM_NONE)
  obj.print();
  `uvm_info("peek_imp", "Hold 5ns", UVM_NONE)
  #(5ns);
  `uvm_info("peek_imp", "Task released", UVM_NONE)
endtask


function new (string name = "comp_d", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  bpi=new(
    .name("bpi"),
    .imp(this)
  );
  bgi=new(
    .name("bgi"),
    .imp(this)
  );

  bmi=new(
    .name("bmi"),
    .imp(this)
  );
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_d
