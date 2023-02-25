class my_obj extends uvm_object;

  typedef enum {HAOS,MUOS,DEI} val_t;

  val_t val;

  function new(string name="");
    super.new(name);
  endfunction






  `uvm_object_utils_begin(my_obj)
    `uvm_field_enum( val_t, val, UVM_ALL_ON )

  `uvm_object_utils_end

endclass
