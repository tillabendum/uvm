class comp_b extends uvm_component;
`uvm_component_utils(comp_b)

uvm_blocking_put_port  #(.T(my_obj)) bpp;
uvm_blocking_peek_port #(.T(my_obj)) bpep;

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

  bpep=new(
    .name("bpep"),
    .parent(this),
    .min_size(1),
    .max_size(UVM_UNBOUNDED_CONNECTIONS)
  );
endfunction : build_phase

virtual task run_phase(uvm_phase phase);
  my_obj  obj;
  phase.raise_objection(this);

	/// Cooperative put with comp_a
	obj = my_obj::type_id::create("obj", this);
  obj.randomize();
  `uvm_info("put_port", "Create object, randomize and send", UVM_NONE)
  obj.print();
  bpp.put(obj);
  `uvm_info("put_port", "Task released", UVM_NONE)

	/// Peeking from master
  `uvm_info("peek_port", "Peeking from d", UVM_NONE)
	bpep.peek(obj);
  `uvm_info_begin("peek_port", "Peeked from d", UVM_NONE)
		`uvm_message_add_object(obj, "obj")
	`uvm_info_end

  phase.drop_objection(this);
endtask

virtual function void connect_phase(uvm_phase phase);
endfunction

endclass:comp_b
