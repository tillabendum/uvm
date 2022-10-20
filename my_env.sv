class my_env extends uvm_env;
`uvm_component_utils( my_env )

my_comp _my_comp;


function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  $stop();
  super.build_phase( phase );
  _my_comp = my_comp::type_id::create( "_my_comp", this );
  `uvm_info( "phasing", "build_phase", UVM_MEDIUM )
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  `uvm_info( "phasing", "connect_phase", UVM_MEDIUM )
endfunction

task run_phase( uvm_phase phase );
  `uvm_info( "phasing", "run_phase", UVM_MEDIUM )
endtask

task pre_reset_phase( uvm_phase phase );
  `uvm_info( "phasing", "pre_reset_phase", UVM_MEDIUM )
endtask

task main_phase( uvm_phase phase );
  `uvm_info( "phasing", "main_phase", UVM_MEDIUM )
endtask



endclass:my_env
