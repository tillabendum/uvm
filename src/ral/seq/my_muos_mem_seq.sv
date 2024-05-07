class my_muos_mem_seq extends uvm_sequence#(my_haos_tr);
`uvm_object_utils( my_muos_mem_seq );

my_haos_reg_block ral;

function new( string name = "" );
   super.new( name );
endfunction: new


task body;
   uvm_status_e   status;
   data_t         write_data;
   data_t         read_data;

   std::randomize(write_data);
   ral.muos.mem.write(
      .status(status),
      .offset(5),
      .value(write_data),
      .parent(this)
   );
   
   // Does not work correctly because memory array is of byte width
   ral.muos.mem.peek(
      .status(status),
      .offset(20),
      .value(read_data),
      .parent(this)
   );

  if(read_data != write_data) begin
    `uvm_fatal("mem-write-peek", $sformatf("Muos memory was not updated correctly. Written=%0d, Read=%0d", write_data, read_data))
  end else begin
    `uvm_info("mem-write-peek", $sformatf("Successful mem-write-peek. Written=%0d, Read=%0d", write_data, read_data), UVM_NONE)
  end
  
endtask

endclass