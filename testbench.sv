`include "transaction.sv"
`include "interface.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scorboard.sv"

module tb;
  
    
  Synram_if sif();
  generator gen;
  driver drv;
  monitor mon;
  scorboard sco;
 
  mailbox #(transaction) mbx1;
  mailbox #(transaction) mbx2;

  event drv_done;
  event mon_done;
  event sco_done;
  
  Synchronous_Ram   uut(sif.clk,sif.rst_n,sif.write_en,sif.addr,sif.data_in,sif.data_out                        );
  
  initial begin
    sif.clk <= 0;
  end
  
  always #10 sif.clk <= ~ sif.clk;

  initial begin
    
    mbx1=new();
    mbx2=new();
    gen=new(mbx1,drv_done);
    drv=new(mbx1,drv_done,mon_done,sco_done);
    drv.sif=sif;
    mon=new(mbx2,drv_done);
    mon.sif=sif;
    sco=new(mbx2, sco_done);
    
  end
  
  initial begin
    
    fork
      gen.run();
      drv.run();
     mon.run();
      sco.run();
    join_none  
    #210 $finish();
  end  
    
 initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;  
  end 
    
    
 
  
endmodule

