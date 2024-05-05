module my_muos(
    my_haos_if haos_if,
    input      clk, 
    input      reset
  );

import my_haos_pkg::*;

reg [NUM_DATA_BYTES-1:0][7:0] dummy;
struct packed {
  // bytes 3-2
  reg [15:0] id;
  // byte 1
  reg [7:0] timeout;
  // byte 0
  reg [3:0] mode;
  reg reserved;
  reg dostoevskiy;
  reg gogol;
  reg pushkin;
} cr;

reg [7:0] mem[MUOS_MEM_SIZE];

// wr requests processing
always @(posedge clk) begin
  if(reset) begin
    cr.dostoevskiy        <= DEF_DOSTOEVSKIY;
    cr.gogol              <= DEF_GOGOL;
    cr.pushkin            <= DEF_PUSHKIN;
    cr.mode               <= DEF_MODE;
    cr.id                 <= DEF_ID;
    haos_if.wstatus       <= 'x;
    haos_if.wstatus_valid <= 0;
  end else if (haos_if.wr) begin
    if(haos_if.addr inside {[MUOS_BASE : MUOS_BASE + MUOS_SIZE - NUM_DATA_BYTES]}) begin
      addr_t local_addr;
      local_addr = haos_if.addr - MUOS_BASE;
      haos_if.wstatus_valid <= 1;
      if (local_addr inside {[MUOS_MEM_OFFSET : MUOS_MEM_OFFSET + MUOS_MEM_SIZE - NUM_DATA_BYTES]}) begin
        for(int byte_i = 0; byte_i < 4; byte_i++) begin
          if( haos_if.wstrb[byte_i]) begin
            mem[local_addr - MUOS_MEM_OFFSET + byte_i] <= haos_if.wdata[byte_i];
          end
        end
        haos_if.wstatus <= OK;
      end else begin
        haos_if.wstatus <= OK;
        case (local_addr)
          MUOS_REG_DUMMY_ADDR : begin
            for(int byte_i = 0; byte_i < 4; byte_i++) begin
              if( haos_if.wstrb[byte_i]) begin
                dummy[byte_i] <= haos_if.wdata[byte_i];
              end
            end
          end

          MUOS_REG_CR_ADDR: begin
            data_t flat_data;

            for(int byte_i = 0; byte_i < 4; byte_i++) begin
              if( haos_if.wstrb[byte_i]) begin
                flat_data[byte_i] = haos_if.wdata[byte_i];
              end
            end
            cr <= flat_data;
          end

          default: begin
            haos_if.wstatus <= ERR;
          end
        endcase
      end // registers
    end else begin // not our address space
      haos_if.wstatus       <='x;
      haos_if.wstatus_valid <= 0;
    end 
  end else begin // no write
    haos_if.wstatus       <= 'x;
    haos_if.wstatus_valid <= 0;
  end
end // always

always @(posedge clk) begin
  if(reset) begin
    haos_if.rdata       <='x;
    haos_if.rdata_valid <= 0;
    haos_if.rstatus     <= 'x;
  end else if (haos_if.rd) begin
    if(haos_if.addr inside {[MUOS_BASE : MUOS_BASE + MUOS_SIZE - NUM_DATA_BYTES]}) begin
      addr_t local_addr;
      local_addr = haos_if.addr - MUOS_BASE;
      haos_if.rdata_valid <= 1;

      if (local_addr inside {[MUOS_MEM_OFFSET : MUOS_MEM_OFFSET + MUOS_MEM_SIZE - NUM_DATA_BYTES]}) begin
        for(int byte_i = 0; byte_i < 4; byte_i++) begin
          haos_if.rdata[byte_i] <= mem[local_addr - MUOS_MEM_OFFSET + byte_i];
        end
        haos_if.rstatus <= OK;
      end else begin
        haos_if.rstatus <= OK;
        case (local_addr)
          MUOS_REG_DUMMY_ADDR : haos_if.rdata <= dummy;
          MUOS_REG_CR_ADDR:     haos_if.rdata <= cr;
          default: begin
            haos_if.rstatus <= ERR;
            haos_if.rdata   <='x;
          end
        endcase
      end //registers
    end else begin // no read
      haos_if.rdata       <='x;
      haos_if.rdata_valid <= 0;
      haos_if.rstatus     <= 'x;
    end
  end else begin // rd
    haos_if.rdata       <='x;
    haos_if.rdata_valid <= 0;
    haos_if.rstatus     <= 'x;
  end // no read
end //always

endmodule
    
  
