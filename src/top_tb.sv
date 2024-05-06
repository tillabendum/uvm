import uvm_pkg::*;
import tb_pkg::*;
module top_tb;

bit   clk;


initial
  forever
    #( 5ns ) clk = ~clk;

my_reset_if reset_if(
    .clk(clk)
  );

my_haos_if haos_if(
    .reset(reset_if.reset),
    .clk(clk)
  );

my_haos_terminal dut(
    .haos_if(haos_if),
    .reset(reset_if.reset),
    .clk(clk) 
  );

initial
  begin
    uvm_config_db #( virtual interface my_haos_if)::set( null, "uvm_test_top", "haos_vif", haos_if );
    uvm_config_db #( virtual interface my_reset_if)::set( null, "uvm_test_top", "reset_vif", reset_if );
    run_test();
  end

endmodule
