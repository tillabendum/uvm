interface harness_if #(
    parameter type T = int,
    parameter string VAR_NAME="variable"
  )(    
    input T val,
    input clk
  );

  clocking cb@(posedge clk);
    input val;
  endclocking

  class proxy_concrete extends my_pkg::harness_if_proxy#(.T(T), .VAR_NAME(VAR_NAME));
    function T get_current_val();
      return val;
    endfunction
    
    function T get_preponed_val();
      return cb.val;
    endfunction

    task wait_posedge();
      @(posedge clk);
    endtask


    function bit name(output string str);
      int qi;

      str = $sformatf("%m");

      // Need to remove useless tail after two last dots
      repeat(2) begin
        if (!find_last_dot(str, qi)) begin
          return 0;
        end

        if(qi == 0) begin
          return 0;
        end

        str = cut_head(str, qi - 1);
      end

      str = {str, ".", VAR_NAME};

      return 1;
    endfunction


    local function bit find_last_dot(
      input string str,
      output int   idx
    );
      bit found;

      for(int i = 0; i < str.len(); i++) begin
        if (str[i] == ".") begin
          found = 1;
          idx = i;
        end
      end

      return found;
    endfunction


    local function string cut_head(input string str, input int last);
      string ret;

      for(int i = 0; i <= last; i++) begin
        ret = {ret, str[i]};
      end
      
      return ret;
    endfunction

  endclass

  proxy_concrete proxy = new;
endinterface