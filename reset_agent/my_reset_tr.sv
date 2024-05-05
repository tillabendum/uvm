class my_reset_tr extends uvm_sequence_item;
`uvm_object_utils(my_reset_tr)

function new(string name="reset_tr");
  super.new(name);  
endfunction

int num_clocks = 1;

endclass