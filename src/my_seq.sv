class my_seq extends uvm_sequence#(my_haos_tr);
`uvm_object_utils( my_seq );

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
   `uvm_info("wr", $sformatf("Written data %0h in haos.alfa with status %s", write_data, status.name), UVM_NONE)

   ral.beta.read(
      .status(status),
      .value(read_data),
      .parent(this)
      );
   `uvm_info("rd", $sformatf("Read data %0h from haos.beta with status %s", read_data, status.name), UVM_NONE)

endtask

endclass