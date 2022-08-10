class mem_req_item extends uvm_sequence_item;


`uvm_object_utils( mem_req_item )

typedef enum { WR, RD } op_t;

rand bit [AWIDTH - 1 : 0]  addr;
rand bit [DWIDTH - 1 : 0]  data;
rand op_t                    op;


function new();
  super.new;
endfunction


endclass
