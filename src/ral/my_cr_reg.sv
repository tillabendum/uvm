class my_cr_reg extends uvm_reg;
`uvm_object_utils( my_cr_reg );

rand uvm_reg_field cont;

  // bytes 3-2
  rand uvm_reg_field  id;
  // byte 1
  rand uvm_reg_field  timeout;
  // byte 0
  rand uvm_reg_field  mode;
  rand uvm_reg_field  reserved;
  rand uvm_reg_field  dostoevskiy;
  rand uvm_reg_field  gogol;
  rand uvm_reg_field  pushkin;

function new(string name = "cr");
  super.new(
    .name(name), 
    .n_bits(DWIDTH), 
    .has_coverage(UVM_NO_COVERAGE)
  );
endfunction

virtual function build();
  
  id = uvm_reg_field::type_id::create( .name( "id" ));
  id.configure( 
    .parent( this ), 
    .size( 16 ), 
    .lsb_pos( 16 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( DEF_ID ), 
    .has_reset( 1 ), 
    .is_rand( 1 ), 
    .individually_accessible( 1 ) 
  );

  timeout = uvm_reg_field::type_id::create( .name( "timeout" ));
  timeout.configure( 
    .parent( this ), 
    .size( 8 ), 
    .lsb_pos( 8 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( 0 ), 
    .has_reset( 0 ), 
    .is_rand( 1 ), 
    .individually_accessible( 1 ) 
  );

  mode = uvm_reg_field::type_id::create( .name( "mode" ));
  mode.configure( 
    .parent( this ), 
    .size( 4 ), 
    .lsb_pos( 4 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( DEF_MODE ), 
    .has_reset( 1 ), 
    .is_rand( 1 ), 
    .individually_accessible( 0 ) 
  );


  dostoevskiy = uvm_reg_field::type_id::create( .name( "dostoevskiy" ));
  dostoevskiy.configure( 
    .parent( this ), 
    .size( 1 ), 
    .lsb_pos( 2 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( DEF_DOSTOEVSKIY ), 
    .has_reset( 1 ), 
    .is_rand( 1 ), 
    .individually_accessible( 0 ) 
  );

  gogol = uvm_reg_field::type_id::create( .name( "gogol" ));
  gogol.configure( 
    .parent( this ), 
    .size( 1 ), 
    .lsb_pos( 1 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( DEF_GOGOL ), 
    .has_reset( 1 ), 
    .is_rand( 1 ), 
    .individually_accessible( 0 ) 
  );

  pushkin = uvm_reg_field::type_id::create( .name( "pushkin" ));
  pushkin.configure( 
    .parent( this ), 
    .size( 1 ), 
    .lsb_pos( 0 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( DEF_PUSHKIN ), 
    .has_reset( 1 ), 
    .is_rand( 1 ), 
    .individually_accessible( 0 ) 
  );

endfunction

endclass