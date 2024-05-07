class my_muos_reg_block extends uvm_reg_block;

`uvm_object_utils( my_muos_reg_block )

// Registers
rand my_dummy_reg    dummy;
rand my_cr_reg       cr;

// Memories
rand my_mem          mem;


function new( string name = "my_muos_reg_block" );
  super.new( name, UVM_NO_COVERAGE );
endfunction

virtual function void build();
  default_map = create_map( "default_map", 32'h0000_0000, 4, UVM_LITTLE_ENDIAN, 1 );

  // Per register set of actions
  dummy = my_dummy_reg::type_id::create( "dummy",, get_full_name );
  dummy.configure( .blk_parent(this), .regfile_parent(null), .hdl_path("dummy") );
  dummy.build();

  // Per register set of actions
  cr = my_cr_reg::type_id::create( "cr",, get_full_name );
  cr.configure( .blk_parent(this), .regfile_parent(null), .hdl_path("cr") );
  cr.build();

  // Per map set of actions
  mem = my_mem::type_id::create("mem", ,get_full_name);
  mem.configure( this, "" );

  // Mapping everything
  default_map.add_reg( dummy, MUOS_REG_DUMMY_ADDR );
  default_map.add_reg( cr, MUOS_REG_CR_ADDR );
  default_map.add_mem( 
    .mem(mem), 
    .offset(MUOS_MEM_OFFSET), 
    .rights("RW"),
    .unmapped(0) // default 0
  );

  lock_model();
endfunction

endclass