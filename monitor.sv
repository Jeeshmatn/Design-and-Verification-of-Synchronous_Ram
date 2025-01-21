class monitor;
  
  transaction trans;
  virtual Synram_if sif;
  mailbox #(transaction) mbx2;

  event mon_done;
  
  function new(mailbox #(transaction) mbx2 ,event mon_done);
    this.mbx2=mbx2;
    this.mon_done=mon_done;
    trans=new();  
  endfunction
    
  task run();
    forever begin
      @(posedge sif.clk);
      #5;
        trans.rst_n=sif.rst_n;
        trans.write_en=sif.write_en;
        trans.addr=sif.addr;
        trans.data_in=sif.data_in;
        trans.data_out=sif.data_out;
        mbx2.put(trans);
        $display("[MON]: DATA SENT TO SCO \t rst_n:%0d \t write_en:%0d \t addr:%0d \t data_in:%0d\t data_out:%0d\t\t time :%0t " ,trans.rst_n, trans.write_en,trans.addr,         trans.data_in,trans.data_out,$time );
    end
  endtask

endclass