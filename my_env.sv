class my_env extends uvm_env;
`uvm_component_utils( my_env )

parameter int unsigned WIDTHS[2]   = '{3, 5};
parameter int unsigned WIDTHS_SIZE = 2;

my_comp_abstract my_comps[];

uvm_blocking_put_imp#(.T(int), .IMP(my_env)) imp;


function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


task put(input int t);
endtask


virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  my_comps = new[WIDTHS_SIZE];

  if(0 < WIDTHS_SIZE) my_comps[0] = my_comp#(WIDTHS[0])::type_id::create("my_comps_0", this);
  if(1 < WIDTHS_SIZE) my_comps[1] = my_comp#(WIDTHS[1])::type_id::create("my_comps_1", this);
  if(2 < WIDTHS_SIZE) my_comps[2] = my_comp#(WIDTHS[2])::type_id::create("my_comps_2", this);
  if(3 < WIDTHS_SIZE) my_comps[3] = my_comp#(WIDTHS[3])::type_id::create("my_comps_3", this);
  if(4 < WIDTHS_SIZE) my_comps[4] = my_comp#(WIDTHS[4])::type_id::create("my_comps_4", this);
  if(5 < WIDTHS_SIZE) my_comps[5] = my_comp#(WIDTHS[5])::type_id::create("my_comps_5", this);
  if(6 < WIDTHS_SIZE) my_comps[6] = my_comp#(WIDTHS[6])::type_id::create("my_comps_6", this);
  if(7 < WIDTHS_SIZE) my_comps[7] = my_comp#(WIDTHS[7])::type_id::create("my_comps_7", this);

  imp = new("name", this);
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  foreach (my_comps[i]) begin
    my_comps[i].port.connect(imp);
  end
endfunction

endclass : my_env
