class my_env extends uvm_env;
  `uvm_component_utils( my_env )

  my_drv                     drv;
  uvm_sequencer #( my_seq_item )  seqr;

  function new ( string name = "my_env", uvm_component parent = null );
    super.new( name, parent );
  endfunction: new


  virtual function void build_phase( uvm_phase phase );
    super.build_phase( phase );
    seqr = new ( "seqr", this );
    seqr.set_arbitration(UVM_SEQ_ARB_RANDOM);
    drv = my_drv::type_id::create( "drv", this );
  endfunction : build_phase


  virtual function void connect_phase( uvm_phase phase );
    drv.seq_item_port.connect( seqr.seq_item_export );
  endfunction
endclass:my_env
