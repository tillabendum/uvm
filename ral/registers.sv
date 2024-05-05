// Fields confiure arguments
//function void configure(
//
//      uvm_reg         parent,    // put 'this'
//      int   unsigned  size,      // in bits
//      int   unsigned  lsb_pos,   // in bits
//      string          access,    // policy (RO, RW, ...) see details below
//      bit             volatile,  // TRUE if its value may be changed between accesses (usually by design)
//      uvm_reg_data_t  reset,     // Value to reset to if "has_reset"
//      bit             has_reset, // TRUE for resettable field
//      bit             is_rand,   // TRUE if field may be randomized
//      bit             individually_accessible // whether the field is the only one to occupy a byte lane in the register.  That is for use of byte select.
//)
//
// Allowed access policies for fields 'configure' function:
//
// "RO"       W: no effect,                                                    R: no effect
// "RW"       W: as-is,                                                        R: no effect
// "RC"       W: no effect,                                                    R: clears all bits
// "RS"       W: no effect,                                                    R: sets all bits
// "WRC"      W: as-is,                                                        R: clears all bits
// "WRS"      W: as-is,                                                        R: sets all bits
// "WC"       W: clears all bits,                                              R: no effect
// "WS"       W: sets all bits,                                                R: no effect
// "WSRC"     W: sets all bits,                                                R: clears all bits
// "WCRS"     W: clears all bits,                                              R: sets all bits
// "W1C"      W: 1/0 clears/no effect on matching bit,                         R: no effect
// "W1S"      W: 1/0 sets/no effect on matching bit,                           R: no effect
// "W1T"      W: 1/0 toggles/no effect on matching bit,                        R: no effect
// "W0C"      W: 1/0 no effect on/clears matching bit,                         R: no effect
// "W0S"      W: 1/0 no effect on/sets matching bit,                           R: no effect
// "W0T"      W: 1/0 no effect on/toggles matching bit,                        R: no effect
// "W1SRC"    W: 1/0 sets/no effect on matching bit,                           R: clears all bits
// "W1CRS"    W: 1/0 clears/no effect on matching bit,                         R: sets all bits
// "W0SRC"    W: 1/0 no effect on/sets matching bit,                           R: clears all bits
// "W0CRS"    W: 1/0 no effect on/clears matching bit,                         R: sets all bits
// "WO"       W: as-is,                                                        R: error
// "WOC"      W: clears all bits,                                              R: error
// "WOS"      W: sets all bits,                                                R: error
// "W1"       W: first one after HARD reset is as-is, other W have no effects, R: no effect
// "WO1"      W: first one after HARD reset is as-is, other W have no effects, R: error
// "NOACCESS" W: no effect,                                                    R: no effect

class StartSendDataReg extends uvm_reg;

`uvm_object_utils( StartSendDataReg )

function new( string name = "StartSendDataReg", int unsigned n_bits = 32, int has_coverage = UVM_NO_COVERAGE );
  super.new( name, n_bits, has_coverage );
endfunction

////////////////////////////////////////////////////////////////////////////////
// Fields list
////////////////////////////////////////////////////////////////////////////////
rand uvm_reg_field ecpri_type;
rand uvm_reg_field ptp;

////////////////////////////////////////////////////////////////////////////////
// Fields configuration
////////////////////////////////////////////////////////////////////////////////
virtual function build();
  ecpri_type = uvm_reg_field::type_id::create( .name( "ecpri_type" ));
  ecpri_type.configure( .parent( this ), .size( 8 ), .lsb_pos( 0 ), .access( "RW" ), .volatile( 0 ), .reset( 0 ), .has_reset( 1 ), .is_rand( 1 ), .individually_accessible( 0 ) );

  ptp = uvm_reg_field::type_id::create( .name( "ptp" ));
  ptp.configure( .parent( this ), .size( 4 ), .lsb_pos( 8 ), .access( "RW" ), .volatile( 0 ), .reset( 0 ), .has_reset( 1 ), .is_rand( 1 ), .individually_accessible( 0 ) );
endfunction

endclass:StartSendDataReg

class cnt_reg extends uvm_reg;
`uvm_object_utils( cnt_reg );

rand uvm_reg_field cont;

function new(string name = "ctrl");
  super.new(name, 16, UVM_NO_COVERAGE);
endfunction

virtual function build();
  cont = uvm_reg_field::type_id::create( .name( "cont" ));
  cont.configure( .parent( this ), .size( DWIDTH ), .lsb_pos( 0 ), .access( "RW" ), .volatile( 0 ), .reset( 0 ), .has_reset( 1 ), .is_rand( 1 ), .individually_accessible( 0 ) );
endfunction

endclass


