class my_haos_tr extends uvm_sequence_item;
  `uvm_object_utils(my_haos_tr)
  
  function new(string name="tr");
    super.new(name);
  endfunction

  op_t        op;
  addr_t      addr;
  data_t      data;
  bit [NUM_BITS_NUM_DATA_BYTES-1:0]   wstrb;
  // Status type is same for write and read operations for simplicity
  status_t    status;
  int         delay;
 
endclass