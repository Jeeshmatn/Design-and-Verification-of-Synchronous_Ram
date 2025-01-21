module Synchronous_Ram(
input  clk,
input  rst_n,
input   write_en,
input   [7:0]addr,
input  [31:0]data_in,
output reg [31:0]data_out 
    );
    
    
reg [31:0] mem [0:255] ;  
integer i;  

always @(posedge clk or negedge rst_n)begin   

    if(!rst_n)
        for(i=0 ; i<256 ; i=i+1)begin
            mem[i]<=32'h0;
            data_out[i]<=32'h0;
        end   
     else begin   
         if(write_en) begin
                mem[addr]<=data_in;
          end  
          else begin
                data_out<=  mem[addr];
          end
      end   
 end
 
endmodule
