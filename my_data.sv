class my_data extends uvm_transaction;
`uvm_object_utils( my_data )

rand int a;

function new( string name = "" );
  super.new( name );
endfunction : new

virtual function void do_copy( uvm_object rhs );
  my_data RHS;
  super.do_copy( rhs );
  $cast( RHS, rhs );

  a = RHS.a;
endfunction: do_copy

endclass : my_data

