class scorboard;
    
  transaction trans;
  mailbox #(transaction) mbx2;
  bit [31:0] prev_data_in;

  event sco_done;
  
  function new(mailbox #(transaction) mbx2,event sco_done);
    this.mbx2=mbx2;
    this.sco_done=sco_done;
  endfunction
  
  task compare(input transaction trans,input bit[31:0] prev_data_in );
    if(trans.rst_n == 0) begin
//       Don't compare during reset
      return;
    end
    
    if(trans.write_en==0) begin // Only compare during read operations
      if(trans.data_out == prev_data_in)begin
        $display("[SCO] : Read Data Matched at addr %0d: Expected %d, Got %0d",
               trans.addr, prev_data_in, trans.data_out);
      end
      else begin
        $error("[SCO] : Read Data Mismatched at addr %0d: Expected %d, Got %0d",
               trans.addr, prev_data_in, trans.data_out);
      end
    end
  endtask
  
  
  task run();
    forever begin
      #17;
      mbx2.get(trans);
      
        $display("[SCO]: DATA RCVD FRM MON \t rst_n:%0d \t write_en:%0d \t addr:%0d \t data_in:%0d\t data_out:%0d " , trans.rst_n, trans.write_en   ,                 trans.addr, trans.data_in ,trans.data_out );

      compare(trans,prev_data_in);
      prev_data_in=trans.data_in;
    
    end
  endtask
  
  
  
 
endclass