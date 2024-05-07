class my_haos_reg_block extends uvm_reg_block;

`uvm_object_utils( my_haos_reg_block )

// Registers
rand my_alpha_reg       alpha;
rand my_beta_reg        beta;
rand my_muos_reg_block  muos;



function new( string name = "my_haos_reg_block" );
  super.new( name, UVM_NO_COVERAGE );
endfunction

virtual function void build();
  default_map = create_map( "default_map", 32'h0000_0000, 4, UVM_LITTLE_ENDIAN, 1 );

  // Per register set of actions
  alpha = my_alpha_reg::type_id::create( "alpha",, get_full_name );
  alpha.configure( .blk_parent(this), .regfile_parent(null), .hdl_path("alpha") );
  alpha.build();

  // Per register set of actions
  beta = my_beta_reg::type_id::create( "beta",, get_full_name );
  beta.configure( .blk_parent(this), .regfile_parent(null), .hdl_path("beta") );
  beta.build();

  // Per subblock set of actions
  muos = my_muos_reg_block::type_id::create("muos",,get_full_name);
  muos.configure(.parent(this), .hdl_path("muos"));
  muos.build();


  // Mapping everything
  default_map.add_reg( alpha, HAOS_REG_ALPHA_ADDR );
  default_map.add_reg( beta, HAOS_REG_BETA_ADDR );
  default_map.add_submap(muos.default_map, MUOS_BASE);

  lock_model();
endfunction

endclass
