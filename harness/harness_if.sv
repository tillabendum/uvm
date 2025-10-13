
interface harness_if#(parameter type T=int) (ref T val);



  class proxy_concrete extends my_pkg::harness_if_proxy#(.T(T));
    function T get_val();
      return val;
    endfunction

    

    function static void force_val(input T new_val);
      force val = new_val;
    endfunction
  endclass

  proxy_concrete proxy = new;
endinterface