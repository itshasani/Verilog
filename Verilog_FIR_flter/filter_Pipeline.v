
`timescale 1 ns / 1 ns

module filter
               (
                clk,
                clk_enable,
                reset,
                filter_in,
                filter_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [13:0] filter_in; //sfix14_En13
  output  signed [13:0] filter_out; //sfix14_En13

////////////////////////////////////////////////////////////////
//Module Architecture: filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [9:0] coeff1 = 10'b1111101101; //sfix10_En9
  parameter signed [9:0] coeff2 = 10'b1111111101; //sfix10_En9
  parameter signed [9:0] coeff3 = 10'b0000001000; //sfix10_En9
  parameter signed [9:0] coeff4 = 10'b1111111110; //sfix10_En9
  parameter signed [9:0] coeff5 = 10'b0000001000; //sfix10_En9
  parameter signed [9:0] coeff6 = 10'b0000110000; //sfix10_En9
  parameter signed [9:0] coeff7 = 10'b0000011000; //sfix10_En9
  parameter signed [9:0] coeff8 = 10'b1110101110; //sfix10_En9
  parameter signed [9:0] coeff9 = 10'b1110011011; //sfix10_En9
  parameter signed [9:0] coeff10 = 10'b0000101101; //sfix10_En9
  parameter signed [9:0] coeff11 = 10'b0010010100; //sfix10_En9
  parameter signed [9:0] coeff12 = 10'b0000101101; //sfix10_En9
  parameter signed [9:0] coeff13 = 10'b1110011011; //sfix10_En9
  parameter signed [9:0] coeff14 = 10'b1110101110; //sfix10_En9
  parameter signed [9:0] coeff15 = 10'b0000011000; //sfix10_En9
  parameter signed [9:0] coeff16 = 10'b0000110000; //sfix10_En9
  parameter signed [9:0] coeff17 = 10'b0000001000; //sfix10_En9
  parameter signed [9:0] coeff18 = 10'b1111111110; //sfix10_En9
  parameter signed [9:0] coeff19 = 10'b0000001000; //sfix10_En9
  parameter signed [9:0] coeff20 = 10'b1111111101; //sfix10_En9
  parameter signed [9:0] coeff21 = 10'b1111101101; //sfix10_En9

  // Signals
  reg  signed [13:0] delay_pipeline [0:20] ; // sfix14_En13
  wire signed [23:0] product21; // sfix24_En22
  wire signed [23:0] product20; // sfix24_En22
  wire signed [23:0] product19; // sfix24_En22
  wire signed [23:0] product18; // sfix24_En22
  wire signed [14:0] mulpwr2_temp; // sfix15_En13
  wire signed [23:0] product17; // sfix24_En22
  wire signed [23:0] product16; // sfix24_En22
  wire signed [23:0] product15; // sfix24_En22
  wire signed [23:0] product14; // sfix24_En22
  wire signed [23:0] product13; // sfix24_En22
  wire signed [23:0] product12; // sfix24_En22
  wire signed [23:0] product11; // sfix24_En22
  wire signed [23:0] product10; // sfix24_En22
  wire signed [23:0] product9; // sfix24_En22
  wire signed [23:0] product8; // sfix24_En22
  wire signed [23:0] product7; // sfix24_En22
  wire signed [23:0] product6; // sfix24_En22
  wire signed [23:0] product5; // sfix24_En22
  wire signed [23:0] product4; // sfix24_En22
  wire signed [14:0] mulpwr2_temp_1; // sfix15_En13
  wire signed [23:0] product3; // sfix24_En22
  wire signed [23:0] product2; // sfix24_En22
  wire signed [24:0] product1_cast; // sfix25_En22
  wire signed [23:0] product1; // sfix24_En22
  wire signed [24:0] sum1; // sfix25_En22
  wire signed [24:0] add_signext; // sfix25_En22
  wire signed [24:0] add_signext_1; // sfix25_En22
  wire signed [25:0] add_temp; // sfix26_En22
  wire signed [24:0] sum2; // sfix25_En22
  wire signed [24:0] add_signext_2; // sfix25_En22
  wire signed [24:0] add_signext_3; // sfix25_En22
  wire signed [25:0] add_temp_1; // sfix26_En22
  wire signed [24:0] sum3; // sfix25_En22
  wire signed [24:0] add_signext_4; // sfix25_En22
  wire signed [24:0] add_signext_5; // sfix25_En22
  wire signed [25:0] add_temp_2; // sfix26_En22
  wire signed [24:0] sum4; // sfix25_En22
  wire signed [24:0] add_signext_6; // sfix25_En22
  wire signed [24:0] add_signext_7; // sfix25_En22
  wire signed [25:0] add_temp_3; // sfix26_En22
  wire signed [24:0] sum5; // sfix25_En22
  wire signed [24:0] add_signext_8; // sfix25_En22
  wire signed [24:0] add_signext_9; // sfix25_En22
  wire signed [25:0] add_temp_4; // sfix26_En22
  wire signed [24:0] sum6; // sfix25_En22
  wire signed [24:0] add_signext_10; // sfix25_En22
  wire signed [24:0] add_signext_11; // sfix25_En22
  wire signed [25:0] add_temp_5; // sfix26_En22
  wire signed [24:0] sum7; // sfix25_En22
  wire signed [24:0] add_signext_12; // sfix25_En22
  wire signed [24:0] add_signext_13; // sfix25_En22
  wire signed [25:0] add_temp_6; // sfix26_En22
  wire signed [24:0] sum8; // sfix25_En22
  wire signed [24:0] add_signext_14; // sfix25_En22
  wire signed [24:0] add_signext_15; // sfix25_En22
  wire signed [25:0] add_temp_7; // sfix26_En22
  wire signed [24:0] sum9; // sfix25_En22
  wire signed [24:0] add_signext_16; // sfix25_En22
  wire signed [24:0] add_signext_17; // sfix25_En22
  wire signed [25:0] add_temp_8; // sfix26_En22
  wire signed [24:0] sum10; // sfix25_En22
  wire signed [24:0] add_signext_18; // sfix25_En22
  wire signed [24:0] add_signext_19; // sfix25_En22
  wire signed [25:0] add_temp_9; // sfix26_En22
  wire signed [24:0] sum11; // sfix25_En22
  wire signed [24:0] add_signext_20; // sfix25_En22
  wire signed [24:0] add_signext_21; // sfix25_En22
  wire signed [25:0] add_temp_10; // sfix26_En22
  wire signed [24:0] sum12; // sfix25_En22
  wire signed [24:0] add_signext_22; // sfix25_En22
  wire signed [24:0] add_signext_23; // sfix25_En22
  wire signed [25:0] add_temp_11; // sfix26_En22
  wire signed [24:0] sum13; // sfix25_En22
  wire signed [24:0] add_signext_24; // sfix25_En22
  wire signed [24:0] add_signext_25; // sfix25_En22
  wire signed [25:0] add_temp_12; // sfix26_En22
  wire signed [24:0] sum14; // sfix25_En22
  wire signed [24:0] add_signext_26; // sfix25_En22
  wire signed [24:0] add_signext_27; // sfix25_En22
  wire signed [25:0] add_temp_13; // sfix26_En22
  wire signed [24:0] sum15; // sfix25_En22
  wire signed [24:0] add_signext_28; // sfix25_En22
  wire signed [24:0] add_signext_29; // sfix25_En22
  wire signed [25:0] add_temp_14; // sfix26_En22
  wire signed [24:0] sum16; // sfix25_En22
  wire signed [24:0] add_signext_30; // sfix25_En22
  wire signed [24:0] add_signext_31; // sfix25_En22
  wire signed [25:0] add_temp_15; // sfix26_En22
  wire signed [24:0] sum17; // sfix25_En22
  wire signed [24:0] add_signext_32; // sfix25_En22
  wire signed [24:0] add_signext_33; // sfix25_En22
  wire signed [25:0] add_temp_16; // sfix26_En22
  wire signed [24:0] sum18; // sfix25_En22
  wire signed [24:0] add_signext_34; // sfix25_En22
  wire signed [24:0] add_signext_35; // sfix25_En22
  wire signed [25:0] add_temp_17; // sfix26_En22
  wire signed [24:0] sum19; // sfix25_En22
  wire signed [24:0] add_signext_36; // sfix25_En22
  wire signed [24:0] add_signext_37; // sfix25_En22
  wire signed [25:0] add_temp_18; // sfix26_En22
  wire signed [24:0] sum20; // sfix25_En22
  wire signed [24:0] add_signext_38; // sfix25_En22
  wire signed [24:0] add_signext_39; // sfix25_En22
  wire signed [25:0] add_temp_19; // sfix26_En22
  wire signed [13:0] output_typeconvert; // sfix14_En13
  reg  signed [13:0] output_register; // sfix14_En13

// adding new Pipe Line ***************************************************************************************************** //
  reg signed [23:0] Product_pipe_0;
  reg signed [23:0] Product_pipe_1;
  reg signed [23:0] Product_pipe_2;
  reg signed [23:0] Product_pipe_3;
  reg signed [23:0] Product_pipe_4;
  reg signed [23:0] Product_pipe_5;
  reg signed [23:0] Product_pipe_6;
  reg signed [23:0] Product_pipe_7;
  reg signed [23:0] Product_pipe_8;
  reg signed [23:0] Product_pipe_9;
  reg signed [23:0] Product_pipe_10;
  reg signed [23:0] Product_pipe_11;
  reg signed [23:0] Product_pipe_12;
  reg signed [23:0] Product_pipe_13;
  reg signed [23:0] Product_pipe_14;
  reg signed [23:0] Product_pipe_15;
  reg signed [23:0] Product_pipe_16;
  reg signed [23:0] Product_pipe_17;
  reg signed [23:0] Product_pipe_18;
  reg signed [23:0] Product_pipe_19;
  reg signed [23:0] Product_pipe_20; 

  reg signed [23:0] Adder_Tree_0;
  reg signed [23:0] Adder_Tree_1;
  reg signed [23:0] Adder_Tree_2;
  reg signed [23:0] Adder_Tree_3;
  reg signed [23:0] Adder_Tree_4;
  reg signed [23:0] Adder_Tree_5;
  reg signed [23:0] Adder_Tree_6;
  reg signed [23:0] Adder_Tree_7;
  reg signed [23:0] Adder_Tree_8;
  reg signed [23:0] Adder_Tree_9;

// stage 2'nd for adding tree *************************************************************************************************  //
  reg signed [23:0] Adder_TreeB_0;
  reg signed [23:0] Adder_TreeB_1;
  reg signed [23:0] Adder_TreeB_2;
  reg signed [23:0] Adder_TreeB_3;
  reg signed [23:0] Adder_TreeB_4;

// stage 3'nd for adding tree *************************************************************************************************  //
  reg signed [23:0] Adder_TreeC_0;
  reg signed [23:0] Adder_TreeC_1;
  reg signed [23:0] Adder_TreeC_2;

  reg signed [23:0] Adder_TreeD_0;

  reg signed [13:0] output_staged;

  always @(posedge clk )
    begin 
      // Register Product Results
      Product_pipe_0 <= delay_pipeline[0] * coeff1;
      Product_pipe_1 <= delay_pipeline[1] * coeff2;
      Product_pipe_2 <= delay_pipeline[2] * coeff3;
      Product_pipe_3 <= delay_pipeline[3] * coeff4;
      Product_pipe_4 <= delay_pipeline[4] * coeff5;
      Product_pipe_5 <= delay_pipeline[5] * coeff6;
      Product_pipe_6 <= delay_pipeline[6] * coeff7;
      Product_pipe_7 <= delay_pipeline[7] * coeff8;
      Product_pipe_8 <= delay_pipeline[8] * coeff9;
      Product_pipe_9 <= delay_pipeline[9] * coeff10;
      Product_pipe_10 <= delay_pipeline[10] * coeff11;
      Product_pipe_11 <= delay_pipeline[11] * coeff12;
      Product_pipe_12 <= delay_pipeline[12] * coeff13;
      Product_pipe_13 <= delay_pipeline[13] * coeff14;
      Product_pipe_14 <= delay_pipeline[14] * coeff15;
      Product_pipe_15 <= delay_pipeline[15] * coeff16;
      Product_pipe_16 <= delay_pipeline[16] * coeff17;
      Product_pipe_17 <= delay_pipeline[17] * coeff18;
      Product_pipe_18 <= delay_pipeline[18] * coeff19;
      Product_pipe_19 <= delay_pipeline[19] * coeff20;
      Product_pipe_20 <= delay_pipeline[20] * coeff21;

// Adder Tree ******************************************************************************************************************* //
      Adder_Tree_0 <= Product_pipe_0 + Product_pipe_1;
      Adder_Tree_1 <= Product_pipe_2 + Product_pipe_3;
      Adder_Tree_2 <= Product_pipe_4 + Product_pipe_5;
      Adder_Tree_3 <= Product_pipe_6 + Product_pipe_7;
      Adder_Tree_4 <= Product_pipe_8 + Product_pipe_9;
      Adder_Tree_5 <= Product_pipe_10 + Product_pipe_11;
      Adder_Tree_6 <= Product_pipe_12 + Product_pipe_13;
      Adder_Tree_7 <= Product_pipe_14 + Product_pipe_15;
      Adder_Tree_8 <= Product_pipe_16 + Product_pipe_17;
      Adder_Tree_9 <= Product_pipe_18 + Product_pipe_19 + Product_pipe_20;
      
      Adder_TreeB_0 <= Adder_Tree_0 + Adder_Tree_1;
      Adder_TreeB_1 <= Adder_Tree_2 + Adder_Tree_3;
      Adder_TreeB_2 <= Adder_Tree_4 + Adder_Tree_5;
      Adder_TreeB_3 <= Adder_Tree_6 + Adder_Tree_7;
      Adder_TreeB_4 <= Adder_Tree_8 + Adder_Tree_9;

      Adder_TreeC_0 <= Adder_TreeB_0 + Adder_TreeB_1;
      Adder_TreeC_1 <= Adder_TreeB_2 + Adder_TreeB_3 + Adder_TreeB_4;

      Adder_TreeD_0 <= Adder_TreeC_0 + Adder_TreeC_1;

      output_staged <= {Adder_TreeD_0[22:9]};
      


      
    end   
  // Block Statements
  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
        delay_pipeline[12] <= 0;
        delay_pipeline[13] <= 0;
        delay_pipeline[14] <= 0;
        delay_pipeline[15] <= 0;
        delay_pipeline[16] <= 0;
        delay_pipeline[17] <= 0;
        delay_pipeline[18] <= 0;
        delay_pipeline[19] <= 0;
        delay_pipeline[20] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
          delay_pipeline[12] <= delay_pipeline[11];
          delay_pipeline[13] <= delay_pipeline[12];
          delay_pipeline[14] <= delay_pipeline[13];
          delay_pipeline[15] <= delay_pipeline[14];
          delay_pipeline[16] <= delay_pipeline[15];
          delay_pipeline[17] <= delay_pipeline[16];
          delay_pipeline[18] <= delay_pipeline[17];
          delay_pipeline[19] <= delay_pipeline[18];
          delay_pipeline[20] <= delay_pipeline[19];
        end
      end
    end // Delay_Pipeline_process

/*
  assign product21 = delay_pipeline[20] * coeff21;

  assign product20 = delay_pipeline[19] * coeff20;

  assign product19 = $signed({delay_pipeline[18][13:0], 3'b000});

  assign mulpwr2_temp = (delay_pipeline[17]==14'b10000000000000) ? $signed({1'b0, delay_pipeline[17]}) : -delay_pipeline[17];

  assign product18 = $signed({mulpwr2_temp[14:0], 1'b0});

  assign product17 = $signed({delay_pipeline[16][13:0], 3'b000});

  assign product16 = delay_pipeline[15] * coeff16;

  assign product15 = delay_pipeline[14] * coeff15;

  assign product14 = delay_pipeline[13] * coeff14;

  assign product13 = delay_pipeline[12] * coeff13;

  assign product12 = delay_pipeline[11] * coeff12;

  assign product11 = delay_pipeline[10] * coeff11;

  assign product10 = delay_pipeline[9] * coeff10;

  assign product9 = delay_pipeline[8] * coeff9;

  assign product8 = delay_pipeline[7] * coeff8;

  assign product7 = delay_pipeline[6] * coeff7;

  assign product6 = delay_pipeline[5] * coeff6;

  assign product5 = $signed({delay_pipeline[4][13:0], 3'b000});

  assign mulpwr2_temp_1 = (delay_pipeline[3]==14'b10000000000000) ? $signed({1'b0, delay_pipeline[3]}) : -delay_pipeline[3];

  assign product4 = $signed({mulpwr2_temp_1[14:0], 1'b0});

  assign product3 = $signed({delay_pipeline[2][13:0], 3'b000});

  assign product2 = delay_pipeline[1] * coeff2;

  assign product1_cast = $signed({{1{product1[23]}}, product1});

  assign product1 = delay_pipeline[0] * coeff1;

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{1{product2[23]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[24:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{1{product3[23]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[24:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{1{product4[23]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[24:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{1{product5[23]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[24:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{1{product6[23]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[24:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{1{product7[23]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[24:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{1{product8[23]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[24:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{1{product9[23]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[24:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{1{product10[23]}}, product10});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[24:0];

  assign add_signext_18 = sum9;
  assign add_signext_19 = $signed({{1{product11[23]}}, product11});
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sum10 = add_temp_9[24:0];

  assign add_signext_20 = sum10;
  assign add_signext_21 = $signed({{1{product12[23]}}, product12});
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum11 = add_temp_10[24:0];

  assign add_signext_22 = sum11;
  assign add_signext_23 = $signed({{1{product13[23]}}, product13});
  assign add_temp_11 = add_signext_22 + add_signext_23;
  assign sum12 = add_temp_11[24:0];

  assign add_signext_24 = sum12;
  assign add_signext_25 = $signed({{1{product14[23]}}, product14});
  assign add_temp_12 = add_signext_24 + add_signext_25;
  assign sum13 = add_temp_12[24:0];

  assign add_signext_26 = sum13;
  assign add_signext_27 = $signed({{1{product15[23]}}, product15});
  assign add_temp_13 = add_signext_26 + add_signext_27;
  assign sum14 = add_temp_13[24:0];

  assign add_signext_28 = sum14;
  assign add_signext_29 = $signed({{1{product16[23]}}, product16});
  assign add_temp_14 = add_signext_28 + add_signext_29;
  assign sum15 = add_temp_14[24:0];

  assign add_signext_30 = sum15;
  assign add_signext_31 = $signed({{1{product17[23]}}, product17});
  assign add_temp_15 = add_signext_30 + add_signext_31;
  assign sum16 = add_temp_15[24:0];

  assign add_signext_32 = sum16;
  assign add_signext_33 = $signed({{1{product18[23]}}, product18});
  assign add_temp_16 = add_signext_32 + add_signext_33;
  assign sum17 = add_temp_16[24:0];

  assign add_signext_34 = sum17;
  assign add_signext_35 = $signed({{1{product19[23]}}, product19});
  assign add_temp_17 = add_signext_34 + add_signext_35;
  assign sum18 = add_temp_17[24:0];

  assign add_signext_36 = sum18;
  assign add_signext_37 = $signed({{1{product20[23]}}, product20});
  assign add_temp_18 = add_signext_36 + add_signext_37;
  assign sum19 = add_temp_18[24:0];

  assign add_signext_38 = sum19;
  assign add_signext_39 = $signed({{1{product21[23]}}, product21});
  assign add_temp_19 = add_signext_38 + add_signext_39;
  assign sum20 = add_temp_19[24:0];

  assign output_typeconvert = (sum20[22:0] + {sum20[9], {8{~sum20[9]}}})>>>9;
*/
  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_staged;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filter
