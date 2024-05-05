class my_dummy_reg extends uvm_reg;
`uvm_object_utils( my_dummy_reg );

rand uvm_reg_field cont;

function new(string name = "dummy");
  super.new(
    .name(name), 
    .n_bits(DWIDTH), 
    .has_coverage(UVM_NO_COVERAGE)
  );
endfunction

virtual function build();
  cont = uvm_reg_field::type_id::create( .name( "cont" ));
  cont.configure( 
    .parent( this ), 
    .size( DWIDTH ), 
    .lsb_pos( 0 ), 
    .access( "RW" ), 
    .volatile( 0 ), 
    .reset( 0 ), 
    .has_reset( 1 ), 
    .is_rand( 1 ), 
    .individually_accessible( 0 ) 
  );
endfunction

endclass