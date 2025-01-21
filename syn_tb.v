module syn_tb;
reg  clk;
reg  rst_n;
reg   write_en;
reg   [7:0]addr;
reg  [31:0]data_in;
wire  [31:0]data_out; 
    
Synchronous_Ram uut(  .clk(clk),  .rst_n(rst_n),  .write_en(write_en), .addr(addr), .data_in(data_in), .data_out(data_out)  );   
    
 always #5 clk =~clk;
    
initial begin
    clk=0;
    rst_n=0;
    write_en=0;
    addr=8'h0;
    data_in=32'h0;

    #10; rst_n=1;
    @(posedge clk);
        write_en=1;
        addr=8'h10;
        data_in=32'hABCD1234;
    
     @(posedge clk);
        write_en = 0;
    
    #100;
    $finish();  
end    
    
initial begin
$monitor("Time :%0t \t RST :%0b \t write_en:%0b \t addr:%0h \t data_in:%0h \t data_out :%0h" ,
    $time,rst_n, write_en,addr,data_in,data_out); 
end    
    
endmodule
