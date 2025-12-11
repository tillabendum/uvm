class my_obj extends uvm_object;
`uvm_object_utils(my_obj)

function new(string name="uvm_object");
  super.new(name);
endfunction

endclass