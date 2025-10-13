
interface harness_if #(
    parameter type T=int
  )(
    ref T val,
    input clk
  );

  class proxy_concrete extends my_pkg::harness_if_proxy#(.T(T));
    function T get_val();
      return val;
    endfunction

    function static void force_val(input T new_val);
      force val = new_val;
    endfunction

    task wait_posedge();
      @(posedge clk);
    endtask

    task wait_negedge();
      @(negedge clk);
    endtask

  endclass

  proxy_concrete proxy = new;
endinterface