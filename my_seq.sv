class my_seq extends uvm_sequence#(mem_req_item);

`uvm_object_utils( my_seq );

function new( string name = "" );
   super.new( name );
endfunction: new


task body;
   mem_req_item tr;

   tr = mem_req_item::type_id::create("tr");
   tr.set_write;
   tr.addr = 32'hfc40_0000;
   //tr.addr = 32'hce;
   tr.data = 12;
   
   start_item(tr);
   finish_item(tr);
endtask

endclass