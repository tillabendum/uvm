class my_env extends uvm_env;
`uvm_component_utils( my_env )

localparam MY_PARAMS_SIZE = 2;
localparam params_t MY_PARAMS[MY_PARAMS_SIZE] = '{
  0:'{WIDTH:12, DEPTH:13},
  1:'{WIDTH:100, DEPTH:200}
};

my_comp_abstract my_comps[];

uvm_blocking_put_imp#(.T(int), .IMP(my_env)) many_to_one_imp;


function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


task put(input int t);
endtask


virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  my_comps = new[MY_PARAMS_SIZE];

  if(0 < MY_PARAMS_SIZE) my_comps[0] = my_comp#(MY_PARAMS[0])::type_id::create("my_comps_0", this);
  if(1 < MY_PARAMS_SIZE) my_comps[1] = my_comp#(MY_PARAMS[1])::type_id::create("my_comps_1", this);
  if(2 < MY_PARAMS_SIZE) my_comps[2] = my_comp#(MY_PARAMS[2])::type_id::create("my_comps_2", this);
  if(3 < MY_PARAMS_SIZE) my_comps[3] = my_comp#(MY_PARAMS[3])::type_id::create("my_comps_3", this);
  if(4 < MY_PARAMS_SIZE) my_comps[4] = my_comp#(MY_PARAMS[4])::type_id::create("my_comps_4", this);
  if(5 < MY_PARAMS_SIZE) my_comps[5] = my_comp#(MY_PARAMS[5])::type_id::create("my_comps_5", this);
  if(6 < MY_PARAMS_SIZE) my_comps[6] = my_comp#(MY_PARAMS[6])::type_id::create("my_comps_6", this);
  if(7 < MY_PARAMS_SIZE) my_comps[7] = my_comp#(MY_PARAMS[7])::type_id::create("my_comps_7", this);

  many_to_one_imp = new("many_to_one_imp", this);
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  foreach (my_comps[i]) begin
    my_comps[i].port.connect(many_to_one_imp);
  end
endfunction


virtual function void end_of_elaboration_phase(uvm_phase phase);
  uvm_component children[$];
  super.end_of_elaboration_phase(phase);

  get_children(children);

  `uvm_info("children", $sformatf("Found %0d children", children.size()), UVM_NONE);
  foreach(children[i]) begin
    `uvm_info("children", $sformatf("  %s, %s",children[i].get_name(), children[i].convert2string()), UVM_NONE)
  end



endfunction

endclass : my_env
