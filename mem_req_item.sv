class mem_req_item extends uvm_sequence_item;


`uvm_object_utils( mem_req_item )

typedef enum { WR, RD, RESP } op_t;

rand bit [AWIDTH - 1 : 0]  addr;
rand bit [DWIDTH - 1 : 0]  data;
rand op_t                    op;


function new( string name = "" );
  super.new( name );
endfunction


function set_write();
  op = WR;
endfunction

function set_read();
  op = RD;
endfunction

function set_resp();
  op = RESP;
endfunction


endclass
