class my_mem extends uvm_mem;
`uvm_object_utils(my_mem)

function new(string name = "mem");
  super.new(
    .name(name), 
    .size(MUOS_MEM_SIZE), 
    .n_bits(AWIDTH), 
    .access("RW"),
    .has_coverage(UVM_NO_COVERAGE)
  );
endfunction
endclass: my_mem