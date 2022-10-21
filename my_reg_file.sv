class my_reg_file extends uvm_reg_file;

`uvm_object_utils( my_reg_file )

function new( string name = "" );
  super.new( name );
endfunction


endclass
