class storage extends uvm_mem;
`uvm_object_utils(storage)
function new(string name = "storage");
  super.new(
    .name(name), 
    .size(32'h0080), 
    .n_bits(AWIDTH), 
    .access("RW"),
    .has_coverage(UVM_NO_COVERAGE)
  );
endfunction
endclass: storage