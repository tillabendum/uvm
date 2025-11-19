virtual class harness_if_proxy #(type T=int);
  pure virtual function T       get_current_val();
  pure virtual function T       get_preponed_val();
  pure virtual function void    force_val(T new_val);
  pure virtual task             wait_posedge();
  pure virtual task             force_next_nba(T new_val);
  pure virtual function bit     name(output string str);

  static harness_if_proxy#(.T(T)) proxies[$];
  
  function new();
    // Register action
    proxies.push_back(this);
  endfunction
endclass