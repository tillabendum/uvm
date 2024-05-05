class my_reset_seq extends uvm_sequence#(my_reset_tr);
`uvm_object_utils(my_reset_seq)

function new(string name="seq");
  super.new(name);  
endfunction


task body();
  my_reset_tr tr;
  `uvm_do(tr)
endtask


endclass