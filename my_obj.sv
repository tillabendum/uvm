class my_obj extends uvm_object;


function new( string name = "" );
endfunction


int val = 12;

`uvm_object_utils_begin(my_obj)

`uvm_field_int( val, UVM_ALL_ON | UVM_BIN )

`uvm_object_utils_end


endclass
