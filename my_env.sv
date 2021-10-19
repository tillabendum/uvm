class my_env extends uvm_env;
`uvm_component_utils( my_env )

my_generator  gen;
my_driver     drv;
uvm_tlm_fifo #( my_data ) fifo;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  fifo = new( "fifo", this );
  gen = my_generator::type_id::create( "gen", this );
  drv = my_driver::type_id::create( "drv", this );
endfunction : build_phase


virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
  gen.src.connect( fifo.put_export );
  drv.dst.connect( fifo.get_export );
endfunction





endclass:my_env
