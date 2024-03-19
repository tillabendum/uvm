class my_reg_block extends uvm_reg_block;

`uvm_object_utils( my_reg_block )

// Registers
rand StartSendDataReg  start_send_data;
rand cnt_reg           cnt;

// Memories
rand storage           shadow_mem;


function new( string name = "my_reg_block" );
  super.new( name, UVM_NO_COVERAGE );
endfunction

virtual function void build();
  default_map = create_map( "default_map", 32'h0000_0000, 4, UVM_LITTLE_ENDIAN, 1 );

  // Per register set of actions
  start_send_data = StartSendDataReg::type_id::create( "start_send_data",, get_full_name );
  start_send_data.configure( this, null, "" );
  start_send_data.build();

  // Per register set of actions
  cnt = cnt_reg::type_id::create( "cnt",, get_full_name );
  cnt.configure( this, null, "" );
  cnt.build();

  // Per map set of actions
  shadow_mem = storage::type_id::create("shadow_mem", ,get_full_name);
  shadow_mem.configure( this, "" );

  // Mapping everything
  default_map.add_reg( start_send_data, 12 );
  default_map.add_reg( cnt, 36 );
  default_map.add_mem( 
    .mem(shadow_mem), 
    .offset(32'h0000_0080), 
    .rights("RW"),
    .unmapped(0) // default 0
  );

  lock_model();
endfunction

endclass
