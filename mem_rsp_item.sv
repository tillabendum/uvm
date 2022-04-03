class mem_rsp_item #(
    parameter DWIDTH = 8
  ) extends uvm_sequence_item;

`uvm_object_utils( mem_rsp_item )


logic [DWIDTH - 1 : 0]  data;





function new();
  super.new;
endfunction

endclass
