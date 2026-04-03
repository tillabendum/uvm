class my_seq_item extends uvm_sequence_item;
`uvm_object_utils( my_seq_item )

int id;
int cnt;


function new(string name="item");
  super.new(name);
endfunction

function string convert2string();
  return  $sformatf("id=%0d, cnt=%0d", id, cnt);
endfunction


endclass
