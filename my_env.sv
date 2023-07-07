class my_env extends uvm_env;
`uvm_component_utils(my_env)

comp_a  a;
comp_b  b;
comp_c  c;
comp_d  d;


function new (string name = "my_env", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  a = comp_a::type_id::create("a", this);
  b = comp_b::type_id::create("b", this);
  c = comp_c::type_id::create("c", this);
  d = comp_d::type_id::create("d", this);
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
  /// Forward
  a.bpp.connect(b.bpp);
  b.bpp.connect(c.bpe);
  c.bpe.connect(d.bpi);

  /// Backward
	a.bgp.connect(d.bgi);
endfunction


virtual function void start_of_simulation();
  a.bpp.debug_connected_to();
endfunction


endclass:my_env
