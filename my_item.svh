class my_item extends uvm_sequence_item;

int a;
bit flag;
typedef enum { WRITE, READ, BLOCK_WRITE } op_t;
op_t op;


`uvm_object_utils_begin( my_item )

  `uvm_field_enum( op_t, op, UVM_ALL_ON )
  `uvm_field_int( a, UVM_ALL_ON | UVM_DEC )
  `uvm_field_int( flag, UVM_ALL_ON | UVM_BIN )


`uvm_object_utils_end




endclass
