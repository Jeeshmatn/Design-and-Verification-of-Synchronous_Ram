class driver;
    
  transaction data;
  virtual Synram_if sif;
  mailbox #(transaction) mbx1;
  
  event drv_done;
  event mon_done;
  event sco_done;
  
  function new(mailbox #(transaction) mbx1 , event drv_done, event mon_done,event sco_done);
    this.mbx1=mbx1;
    this.drv_done=drv_done;
    this.mon_done=mon_done;
    this.sco_done=sco_done;
  endfunction
    
  task run();
    forever begin
        mbx1.get(data);
      @(posedge sif.clk);

      
        sif.rst_n=data.rst_n;
        sif.write_en=data.write_en;
        sif.addr=data.addr;
        sif.data_in=data.data_in;
        sif.data_out=data.data_out;
      

      
      $display("[DRV]: DATA RCVD FRM GEN \t rst_n:%0d \t write_en:%0d \t addr:%0d \t data_in:%0d \t\t\t\t\t time :%0t " , data.rst_n, data.write_en   ,           data.addr, data.data_in , $time );
      
//             $display("[DRV]: DATA TO INT \t rst_n:%0d \t write_en:%0d \t addr:%0d \t data_in:%0d  \t data_out:%0d \t time :%0t " , sif.rst_n, sif.write_en   ,           sif.addr, sif.data_in ,sif.data_out , $time );

      
    end
  endtask
 
endclass