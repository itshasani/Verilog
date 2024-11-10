%%
% matlab data

output = FIR_Output.data(:) * 2^13 ;

file_output_signal = fopen ('output_vec.txt','w');

for i = 1:length(output)
    fprintf(file_output_signal ,'%d\r\n',output(i));
end
fclose(file_output_signal);
%%
% verilog _ no pipeline
file_Output_Signal_1 = fopen('output_vec.txt');
Output_Vec_Sig = fscanf(file_Output_Signal_1 , '%d');
fclose(file_Output_Signal_1);

file_Output_Signal_2 = fopen('output_noPipeline.txt');
Output_Vec_Sig_HDL = fscanf(file_Output_Signal_2 , '%d');
fclose(file_Output_Signal_2);



plot(Output_Vec_Sig(:))
hold
plot(Output_Vec_Sig_HDL(:), 'ro')
legend('MATLAB - Fixed-Point','Verilog - Fixed-Point')