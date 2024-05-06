module my_haos_terminal(
    my_haos_if haos_if,
    input      clk, 
    input      reset
  );
  
  import my_haos_pkg::*;

  my_haos_if muos_if(clk,reset);
  
  status_t                              wstatus;
  logic                                 wstatus_valid;

  logic [NUM_DATA_BYTES-1:0][7:0]       rdata;
  logic                                 rdata_valid;
  status_t                              rstatus;

  // Registers
  data_t alpha;
  data_t beta;
  
  assign beta = alpha + 1;

  always @(posedge clk) begin
    if (reset) begin
      alpha         <= DEF_ALPHA;
      wstatus       <='x;
      wstatus_valid <= 0;
    end else if (haos_if.wr) begin // !! ignore wstrb
      if (haos_if.addr inside {[HAOS_BASE : HAOS_BASE+HAOS_SIZE-1]})begin
        wstatus_valid <= 1;
        if(haos_if.addr == HAOS_REG_ALPHA_ADDR) begin
          alpha <= haos_if.wdata;
          wstatus <= OK;
        end else begin
          wstatus <= ERR;
        end
      end else begin
        wstatus       <='x;
        wstatus_valid <= 0;
      end
    end else begin
      wstatus       <='x;
      wstatus_valid <= 0;
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      rdata         <='x;
      rstatus       <='x;
      rdata_valid <= 0;
    end else if (haos_if.rd) begin
      if (haos_if.addr inside {[HAOS_BASE : HAOS_BASE+HAOS_SIZE-1]})begin
        rdata_valid <= 1;
        if(haos_if.addr == HAOS_REG_BETA_ADDR) begin
          rdata <= beta; 
          rstatus <= OK;
        end else begin
          rdata   <= 'x;
          rstatus <= ERR;
        end
      end else begin
        rdata         <='x;
        rstatus       <='x;
        rdata_valid   <= 0;
      end
    end else begin
      rdata         <='x;
      rstatus       <='x;
      rdata_valid   <= 0;
    end
  end

  my_muos muos(
    .haos_if(muos_if),
    .clk(clk), 
    .reset(reset)
  );


  // Connecting request channels
  assign muos_if.rd    = haos_if.rd;
  assign muos_if.wr    = haos_if.wr;
  assign muos_if.addr  = haos_if.addr;
  assign muos_if.wdata = haos_if.wdata;
  assign muos_if.wstrb = haos_if.wstrb;
  // Connecting write response channel
  assign haos_if.wstatus_valid = wstatus_valid ? 1'b1 : muos_if.wstatus_valid;
  assign haos_if.wstatus = wstatus_valid ? wstatus : muos_if.wstatus;

  two_write_responses: assert property (
    @(posedge clk)
    disable iff ( reset !== 1'b0 ) 
    
    wstatus_valid |-> !muos_if.wstatus_valid
  ) else begin
    $error("Two wstatus_valid collide");
  end

  // Connecting read response channel
  assign haos_if.rdata_valid = rdata_valid ? 1'b1 : muos_if.rdata_valid;
  assign haos_if.rdata = rdata_valid ? rdata : muos_if.rdata;
  assign haos_if.rstatus = rdata_valid ? rstatus : muos_if.rstatus;

  two_read_responses: assert property (
    @(posedge clk)
    disable iff ( reset !== 1'b0 ) 
    rdata_valid |-> !muos_if.rdata_valid
  ) else begin
    $error("Two rdata_valid collide");
  end




endmodule