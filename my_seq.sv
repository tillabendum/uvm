class my_seq extends uvm_sequence#(mem_req_item);

`uvm_object_utils( my_seq );

function new( string name = "" );
   super.new( name );
endfunction: new


task body;
   mem_req_item tr;
   my_reg_block ral;
   uvm_status_e   status;

   if (!(uvm_resource_db#(my_reg_block)::read_by_type(get_full_name, ral, this))) begin
     `uvm_fatal("config", "Failed to receive ral from test")
   end

  
   //ral.cnt.write(status, 16'hFA, , ,this);
   //ral.start_send_data.write(status, '1, , ,this);
   
   ral.randomize();
   ral.update(status,,this);
   #10;

   /*
   tr = mem_req_item::type_id::create("tr");
   tr.set_write;
   tr.addr = 32'hfc40_0000;
   //tr.addr = 32'hce;
   tr.data = 12;
   
   start_item(tr);
   finish_item(tr);
   */
endtask

endclass