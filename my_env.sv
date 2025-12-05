class my_env extends uvm_env;
`uvm_component_utils( my_env )

parameter int unsigned WIDTHS[2] = '{3, 5};

my_comp_abstract my_comps[];

uvm_blocking_put_imp#(.T(int), .IMP(my_env)) imp;


function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


task put(input int t);
endtask


virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  my_comps = new[2];

  my_comps[0] = my_comp#(WIDTHS[0])::type_id::create("my_comps_0", this);
  my_comps[1] = my_comp#(WIDTHS[1])::type_id::create("my_comps_1", this);

  imp = new("name", this);
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  my_comps[0].port.connect(imp);
  my_comps[1].port.connect(imp);

endfunction

endclass : my_env
