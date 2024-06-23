`timescale 1ns / 1ps


module FIR_tb(

    );
reg clk;                     
reg clk_enable;              
reg reset;                   
reg signed [13:0] filter_in; 
wire signed [13:0] filter_out;
reg signed [13:0] step_input = 14'd7373 ;
integer file_out ;
integer i ;
parameter clk_period = 10;
initial begin clk =0;
              reset = 1;
              clk_enable = 1;
              #45
              reset = 0;
 end
 
 always begin
 #(clk_period/2)
 clk = ~clk ;
 end
 
 

   
    
filter uut(clk,
                clk_enable,
                reset,
                filter_in,
                filter_out);
                
                
 always @(posedge(clk)) begin

    filter_in <= step_input ;
 end 
               
 initial @(negedge(reset))  begin
 file_out = $fopen("output_Pipelined.txt" , "w") ;
 #((clk_period/2)*14)
 i=0;
 
for( i=0 ; i<100 ; i =i+1) begin
        #(clk_period)
        $fwrite(file_out , "%d\n" , filter_out);
    end
$fclose(file_out) ;  
end       
endmodule
