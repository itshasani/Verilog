`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2024 03:32:48 PM
// Design Name: 
// Module Name: tb1_sub
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb1_sub(
    );
    parameter fixed_scale = 4;
    parameter clk_pr = 10;
    parameter iteration = 4;
   
    parameter sample_num = 100000;
     reg signed [fixed_scale+1 :0] in_x;
     reg signed [fixed_scale+1 :0] in_y;
     reg signed [fixed_scale+2 :0] in_z;
     reg clk;
     reg rst;
     wire signed [fixed_scale+2 :0] out_x;
     wire signed [fixed_scale+2 :0] out_y;
     wire signed [fixed_scale+3 :0] out_z;
 
     integer i;
     integer j;
     integer filex;
     integer filey;
     integer filez;
     reg signed [fixed_scale+2 :0] datax;
     reg signed [fixed_scale+2 :0] datay;
     integer valid_time =(2*iteration)*clk_pr;
   cordic_top #(.fixed_scale(fixed_scale),.iteration(iteration))UUT0 (.in_x(in_x),
   .in_y(in_y),.in_z(in_z),.out_x(out_x),.out_y(out_y),.out_z(out_z),
   .clk(clk),.rst(rst)
   );   
    always #(clk_pr/2) clk = ~clk;
    
    initial begin 
        rst = 1;
        clk = 0;
        #15
        rst = 0;

        filex = $fopen("E:/VLSI/HW2/input_samples_x.txt", "r");  
        filey = $fopen("E:/VLSI/HW2/input_samples_y.txt", "r");
        filez = $fopen("E:/VLSI/HW2/outputverilog.txt", "w");  
        if ((filex == 0)||(filey == 0)||(filez == 0)) begin
            $display("Error: Could not open the file.");
            $finish; // Exit if the file cannot be opened
        end 
                      
        in_z = 0;
        $fscanf(filex, "%d\n", datax); // Read binary value
        $fscanf(filey, "%d\n", datay); // Read binary value
        
        in_x = datax;             
        in_y = datay;                  
       // #(clk_pr)
   for (i=0;i<sample_num-1; i = i+1)
    begin       
        #10
           $fscanf(filex, "%d\n", datax); // Read binary value
           $fscanf(filey, "%d\n", datay); // Read binary value  
            in_x = datax;             
            in_y = datay;                  

    end                               
    end
  initial begin
    @(negedge rst);
     
    #valid_time
   for (j=0;j<sample_num-1; j = j+1)
     begin       
         #10
         $fwrite(filez, "%0d\n", out_z);
      //   $display("outz: %d\t%t",out_z,$time);        
       end   
       #10
     //  $display("outz: %d\t%t",out_z,$time); 
        $fwrite(filez, "%0d\n", out_z); 
        $fclose(filez);
         
        
  end
endmodule
