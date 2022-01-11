class my_env extends uvm_env;
`uvm_component_utils( my_env )

my_generator  gen;
my_driver     drv;
uvm_tlm_fifo #( my_data ) fifo;

// Sequences
uvm_sequencer #( ctrl_seq_item ) sequencer;
ctrl_sequence                    seq;
ctrl_drv                         cdrv;
component                        cmp;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new


virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  fifo = new( "fifo", this );
  gen = my_generator::type_id::create( "gen", this );
  drv = my_driver::type_id::create( "drv", this );
  cdrv = ctrl_drv::type_id::create( "cdrv", this );
  sequencer = new ( "sequencer", this );
  seq = ctrl_sequence::type_id::create( "seq", this );

  uvm_config_db #( int )::set( this, ".", "haos", 6 );
  if( uvm_config_db #( int )::exists( this, ".", "haos" ))
    begin
      `uvm_info( get_name, $psprintf( "Config found\nwell preserved %d", 5 ), 100);
    end
  else
    begin
      `uvm_info( get_name, "Config NOT found ", 100);
    end
  cmp = component::type_id::create( "cmp", this );
  uvm_resource_db #( int )::set( "uvm_test_top.env.cmp", "val", 12, this );
endfunction : build_phase


virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
  gen.src.connect( fifo.put_export );
  drv.dst.connect( fifo.get_export );
  cdrv.seq_item_port.connect( sequencer.seq_item_export );
endfunction


task run_phase( uvm_phase phase );
  phase.raise_objection( this );
  seq.start( sequencer );
  phase.drop_objection( this );
endtask : run_phase


endclass:my_env
