class transaction ;
  
  bit  rst_n;
  bit   write_en;
  randc bit   [7:0]addr;
  randc bit  [31:0]data_in;
  bit  [31:0]data_out;
 
endclass