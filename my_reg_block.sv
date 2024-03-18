class my_reg_block extends uvm_reg_block;

`uvm_object_utils( my_reg_block )

// Registers
StartSendDataReg start_send_data;

function new( string name = "my_reg_block" );
  super.new( name, UVM_NO_COVERAGE );
endfunction

virtual function void build();
  default_map = create_map( "default_map", 32'hfc40_0000, 4, UVM_LITTLE_ENDIAN, 1 );

  // Per register set of actions
  start_send_data = StartSendDataReg::type_id::create( "start_send_data",, get_full_name );
  start_send_data.configure( this, null, "" );
  start_send_data.build();

  // Mapping everything
  default_map.add_reg( start_send_data, 0 );

  lock_model();
endfunction

endclass
