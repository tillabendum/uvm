class ctrl_seq_item extends uvm_sequence_item;
   `uvm_object_utils( ctrl_seq_item )

   rand byte data;

   function new();
      super.new();
   endfunction

   virtual function string convert2string;
      return $psprintf( "data : %d", data );
   endfunction:convert2string

   virtual function void do_copy( uvm_object rhs );
      ctrl_seq_item RHS;
      super.copy( rhs );
      $cast ( RHS, rhs );
      data = RHS.data;
   endfunction : do_copy

endclass : ctrl_seq_item
