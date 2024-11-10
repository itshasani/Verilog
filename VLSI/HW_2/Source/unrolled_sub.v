`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2024 10:20:23 PM
// Design Name: 
// Module Name: unrolled_sub
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


module unrolled_sub
#(parameter  fixed_scale = 24,
    parameter signed atan2i = 13176795,
    parameter shift_num = 1
    )
(
    input signed [fixed_scale+2 :0] in_x,
    input signed [fixed_scale+2 :0] in_y,
    input signed [fixed_scale+3 :0] in_z,
    input clk,
    input rst,
    output reg signed [fixed_scale+2 :0] out_x,
    output reg signed [fixed_scale+2 :0] out_y,
    output reg signed [fixed_scale+3 :0] out_z
    );
    
    reg signed [fixed_scale+2 :0] shifterx;
    reg signed [fixed_scale+2 :0] shiftery;
    reg signed [fixed_scale+2 :0]inmuxz;

    reg signed [fixed_scale+2 :0] intan_reg;
    reg signed [fixed_scale+2 :0] out_x_reg;
    reg signed [fixed_scale+2 :0] out_y_reg;
    reg signed [fixed_scale+3 :0] out_z_reg;
    
    reg signed [fixed_scale+2 :0] in_x_reg;
    reg signed [fixed_scale+2 :0] in_y_reg;
    reg signed [fixed_scale+3 :0] in_z_reg;
       
    always @(posedge clk)
        begin 
            if (rst == 1)
                begin 
                    shifterx <= 0;
                    shiftery <= 0;
                end
            else
                begin
                    
                  
                    intan_reg <= atan2i;
                    inmuxz <= intan_reg;
                    in_x_reg <= in_x;
                    in_y_reg <= in_y;
                    in_z_reg <= in_z;
                    out_x <= out_x_reg;
                    out_y <= out_y_reg;
                    out_z <= out_z_reg;
                end     
        end
    always @(*)
        begin 
            shifterx = in_x_reg >>> shift_num;
            shiftery = in_y_reg >>> shift_num;// if signed extended

            if (in_y_reg >= 0) 
                begin 
                    out_x_reg = in_x_reg + shiftery;
                    out_y_reg = in_y_reg - shifterx;
                    out_z_reg = in_z_reg + inmuxz;
                end
            else 
                begin 
                    out_x_reg = in_x_reg - shiftery;
                    out_y_reg = in_y_reg + shifterx;
                    out_z_reg = in_z_reg - inmuxz;                
                    
                end   
        end
endmodule



