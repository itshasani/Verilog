`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2024 04:19:52 PM
// Design Name: 
// Module Name: cordic_top
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


module cordic_top #(
    parameter iteration = 4,
    parameter fixed_scale = 4,
    parameter integer signed atani0 = 13176795,
    parameter integer signed atani1 = 7778716,
    parameter integer signed atani2 = 4110060,
    parameter integer signed atani3 = 2086331,
    parameter integer signed atani4 = 1047214,
    parameter integer signed atani5 = 524117,
    parameter integer signed atani6 = 262123,
    parameter integer signed atani7 = 131069,
    parameter integer signed atani8 = 65536,
    parameter integer signed atani9 = 32768,
    parameter integer signed atani10 = 16384,
    parameter integer signed atani11 = 8192,
    parameter integer signed atani12 = 4096,
    parameter integer signed atani13 = 2048,
    parameter integer signed atani14 = 1024,
    parameter integer signed atani15 = 512,
    parameter integer signed atani16 = 256,
    parameter integer signed atani17 = 128,
    parameter integer signed atani18 = 64,
    parameter integer signed atani19 = 32,
    parameter integer signed atani20 = 16,
    parameter integer signed atani21 = 8,
    parameter integer signed atani22 = 4,
    parameter integer signed atani23 = 2,
    parameter integer signed atani24 = 1
    )
    
    (    input signed [fixed_scale+1 :0] in_x,
    input signed [fixed_scale+1 :0] in_y,
    input signed [fixed_scale+2 :0] in_z,
    input clk,
    input rst,
    output wire signed [fixed_scale+2 :0] out_x,
    output wire signed [fixed_scale+2 :0] out_y,
    output wire signed [fixed_scale+3 :0] out_z
    );
    
    wire signed [fixed_scale+2:0] chain_x [0:iteration]; // Internal signals for the chain    
    wire signed [fixed_scale+2:0] chain_y [0:iteration]; // Internal signals for the chain    
    wire signed [fixed_scale+3 :0] chain_z [0:iteration]; // Internal signals for the chain    
    reg signed [fixed_scale+2:0] x;
    reg signed [fixed_scale+2:0] y;
    reg signed [fixed_scale+3 :0] z;
    //integer signed pi_fixed = 52707179;
    integer signed pi_fixed = 50;
    assign chain_x[0] = x;
    assign chain_y[0] = y;
    assign chain_z[0] = z;
    
    genvar i;
      generate
          for (i = 0; i < iteration; i = i + 1) begin : unrolled_instances
                      unrolled_sub #(
              .fixed_scale(fixed_scale),
              .atan2i((i == 0) ? atani0 :
                      (i == 1) ? atani1 :
                      (i == 2) ? atani2 :
                      (i == 3) ? atani3 :
                      (i == 4) ? atani4 :
                      (i == 5) ? atani5 :
                      (i == 6) ? atani6 :
                      (i == 7) ? atani7 :
                      (i == 8) ? atani8 :
                                 atani9),
              .shift_num(i)  // Example shift amount, modify as needed
          )
          UUT (
                          .in_x(chain_x[i]),
                          .in_y(chain_y[i]),
                          .in_z(chain_z[i]),
                          .out_x(chain_x[i + 1]),
                          .out_y(chain_y[i + 1]),
                          .out_z(chain_z[i + 1]),
                          .clk(clk),
                          .rst(rst)
                      );
                  end
              endgenerate
     assign out_x = chain_x[iteration];
     assign out_y = chain_y[iteration];
     assign out_z = chain_z[iteration];
     
     always@(*)
        begin
            if (in_x < 0)
                begin 
                   x = -in_x;
                   y = -in_y;
                   z = in_z - pi_fixed; 
                end
            else 
                begin 
                   x = in_x;
                   y = in_y;
                   z = in_z;
                end
        end
     
endmodule
