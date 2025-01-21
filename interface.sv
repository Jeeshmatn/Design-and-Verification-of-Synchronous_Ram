interface Synram_if;
 
  logic  rst_n;
  logic  write_en;
  logic  [7:0]addr;
  logic  [31:0]data_in;
  logic  [31:0]data_out;
  logic  clk;
  
endinterface
