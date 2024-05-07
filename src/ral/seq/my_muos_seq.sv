class my_muos_seq extends uvm_sequence#(my_haos_tr);
`uvm_object_utils( my_muos_seq );

my_haos_reg_block ral;

function new( string name = "" );
   super.new( name );
endfunction: new


task body;
   uvm_status_e   status;
   data_t         write_data;
   data_t         read_data;

   write_data = 42;
   ral.muos.dummy.write(
     .status(status),
     .value(write_data),
     .parent(this)
   );
   `uvm_info("write", $sformatf("Written data %0h in haos.muos.dummy with status %s", write_data, status.name), UVM_NONE)

   ral.muos.dummy.read(
     .status(status),
     .value(read_data),
     .parent(this)
   );
   `uvm_info("read", $sformatf("Read data %0h from haos.muos.dummy with status %s", read_data, status.name), UVM_NONE)
   if(read_data != write_data) begin
     `uvm_fatal("write-read", $sformatf("Write-read test failed. In fact written=%0d, read=%0d", write_data, read_data))
   end

  // Quasi write
  ral.muos.dummy.randomize(); 
  write_data = ral.muos.dummy.get();
  ral.muos.dummy.update(status);

  ral.muos.dummy.peek(
     .status(status),
     .value(read_data),
     .parent(this)
   );

  if(read_data != write_data) begin
    `uvm_fatal("update-peek", $sformatf("Dummy register was not updated correctly. Written=%0d, Read=%0d", write_data, read_data))
  end else begin
    `uvm_info("update-peek", $sformatf("Successful update-peek. Written=%0d, Read=%0d", write_data, read_data), UVM_NONE)
  end
endtask
endclass