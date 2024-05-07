class my_haos_seq extends uvm_sequence#(my_haos_tr);
`uvm_object_utils( my_haos_seq );

my_haos_reg_block ral;

function new( string name = "" );
   super.new( name );
endfunction: new


task body;
   uvm_status_e   status;
   data_t         write_data;
   data_t         read_data;

   write_data = 12;
   ral.alpha.write(
     .status(status),
     .value(write_data),
     .parent(this)
   );
   `uvm_info("write", $sformatf("Written data %0h in haos.alfa with status %s", write_data, status.name), UVM_NONE)

   ral.beta.read(
     .status(status),
     .value(read_data),
     .parent(this)
   );
   `uvm_info("read", $sformatf("Read data %0h from haos.beta with status %s", read_data, status.name), UVM_NONE)
   if(read_data != (write_data + 1)) begin
     `uvm_fatal("write-read", $sformatf("Beta register must me alpha register + 1. In fact alpha=%0d, beta=%0d", write_data, read_data))
   end

   write_data = 8'hce;
   ral.alpha.poke(
     .status(status),
     .value(write_data),
     .parent(this)
   );

   ral.beta.peek(
     .status(status),
     .value(read_data),
     .parent(this)
   );

   if(read_data != (write_data + 1)) begin
      `uvm_fatal("poke-peek", $sformatf("Beta register must me alpha register + 1. In fact alpha=%0d, beta=%0d", write_data, read_data))
   end

endtask

endclass