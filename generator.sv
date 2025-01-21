class generator;
  
  transaction trans;
  mailbox #(transaction) mbx1;
  event drv_done;
  bit[7:0] prev_addr = 0;

  
  function new(mailbox #(transaction) mbx1 ,event  drv_done);
    this.mbx1=mbx1;
    this.drv_done=drv_done;
    trans=new();  
  endfunction
    
  task run();
    trans.rst_n=1'b1;
    trans.write_en=1'b1;
    
    for(int i=0; i<10; i++)begin
        trans.randomize();
        
      if(trans.write_en==1)begin
         prev_addr = trans.addr;
      end  
      else begin
          trans.addr= prev_addr;
          trans.data_in=0;
      end
      
        mbx1.put(trans);
    
      $display("[GEN]: DATA SENT TO DRV \t rst_n:%0d \t write_en:%0d \t addr:%0d \t data_in:%0d \t\t\t\t\t time :%0t  " , trans.rst_n, trans.write_en,trans.addr, trans.data_in, $time );
      #20;
    trans.write_en= ~ trans.write_en;
    end
  endtask

endclass