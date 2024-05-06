package my_haos_pkg;
  // Widths
  localparam AWIDTH = 32;
  localparam DWIDTH = 32;

  // Data types
  typedef enum bit {OK, ERR} status_t;

  // Convinience parameters and data types
  localparam NUM_DATA_BYTES = DWIDTH / 8;
  localparam NUM_BITS_NUM_DATA_BYTES = $clog2(NUM_DATA_BYTES);
  typedef logic[AWIDTH-1:0]               addr_t;
  typedef logic[NUM_DATA_BYTES-1:0][7:0]  data_t;

  // Address map
  // Absolute address of registers of HAOS
  localparam HAOS_BASE=0;
  localparam HAOS_SIZE=128;

  // offseted register addresses relative to HAOS_BASE
  localparam HAOS_REG_ALPHA_ADDR = 48; //WO
  localparam HAOS_REG_BETA_ADDR  = 52; //RO value in address is alfa + 1; 
  
  // Absolute address of muos subdevice
  localparam MUOS_BASE = 128;
  localparam MUOS_SIZE = 128;
  
  // Register addresses relative to muos base
  localparam MUOS_REG_DUMMY_ADDR  = 8;  // RW
  localparam MUOS_REG_CR_ADDR     = 12; // RW with fields 

  // Memory address offset relative to MUOS_BASE
  localparam MUOS_MEM_OFFSET      = 64;
  localparam MUOS_MEM_SIZE        = 64;

  // Defaults
  localparam DEF_PUSHKIN      = 0;
  localparam DEF_GOGOL        = 1;
  localparam DEF_DOSTOEVSKIY  = 0;
  localparam DEF_MODE         = 0;
  localparam DEF_ID           = 16'hface;
  localparam DEF_ALPHA        = 32'hdead_beef;

endpackage