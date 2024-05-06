class my_seq extends uvm_sequence#(my_haos_tr);
`uvm_object_utils( my_seq );

my_haos_reg_block ral;

function new( string name = "" );
   super.new( name );
endfunction: new


task body;
   uvm_status_e   status;

   ral.alpha.write(
      .status(status),
      .value(12),
      .parent(this)
   );

endtask

endclass