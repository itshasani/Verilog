
clear all
sample_num = 100000;
fixed_scale = 2^8;
pi_fixed = round(pi * fixed_scale);

fileIDy = fopen('input_samples_y.txt', 'r');
datay = fscanf(fileIDy, '%d');
fclose(fileIDy);

fileIDx = fopen('input_samples_x.txt', 'r');
datax = fscanf(fileIDx, '%d');
fclose(fileIDx);

fileIDoutm = fopen('cordic_mout.txt', 'r');
datam = fscanf(fileIDoutm, '%d');
fclose(fileIDoutm);  

for i=1:sample_num
      if (datam(i) >  pi_fixed || datam(i) < - pi_fixed)

        datam(i) = mod(datam(i),2*pi_fixed);
      end

end 

data_tan = zeros(1,sample_num);
data_matlab = zeros(1,sample_num);

for j=1:sample_num

    data_tan(j) = atan2(datay(j),datax(j));
    data_tan(j) = mod(data_tan(j) + pi, 2*pi) - pi;
end

for j=1:sample_num
    datam(j) = datam(j)/fixed_scale;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_matlab = datam';

for j=1:sample_num
    data_matlab(j) = mod(data_matlab(j) + pi, 2*pi) - pi;
end
isEqual = data_tan - data_matlab;
for k = 1:sample_num
if ((data_tan(k) > 2.6)&&(data_matlab(k) < -2.6))
    data_tan(k) = data_tan(k) - 2*pi;
elseif ((data_tan(k) < -2.6)&&(data_matlab(k) > 2.6))
    data_matlab(k) = data_matlab(k) - 2*pi;
end
end

isEqual = abs(data_tan - data_matlab);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data_matlab = datam';
% 
% 
% isEqual = data_tan - data_matlab;
% 
% datam(245)
% data_tan(245)
% for k = 1:sample_num
% if (isEqual(k) > 6)
%     data_tan(k) = data_tan(k) - 2*pi;
% elseif (isEqual(k) < -6)
%     data_matlab(k) = data_matlab(k) + 2*pi;
% end
% end
% isEqual = abs(data_tan - data_matlab);


% Generate index array
i = 1:sample_num;

% Plot the arrays with index i
figure;
stem(i, isEqual(i), 'DisplayName', 'data_matlab 1', 'LineStyle', 'none', 'Marker', 'o');
hold on;
% Add labels and legend
xlabel('Index i');
ylabel('error');
title('Plot of tan() - cordic matlab');
legend('show');
grid on;
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% verilog output 
fileIDoutver = fopen('outputverilog.txt', 'r');
dataver = fscanf(fileIDoutver, '%d');
fclose(fileIDoutver);  



data_verilog = dataver';
for j=1:sample_num
    data_verilog(j) = data_verilog(j)/fixed_scale;
end


for j=1:sample_num
    data_verilog(j) = mod(data_verilog(j) + pi, 2*pi) - pi;
end


for k = 1:sample_num
if ((data_tan(k) > 2.7)&&(data_verilog(k) < -2.7))
    data_tan(k) = data_tan(k) - 2*pi;
elseif ((data_tan(k) < -2.7)&&(data_verilog(k) > 2.7))
    data_verilog(k) = data_verilog(k) - 2*pi;
end
end


isEqual2 = abs(data_tan - data_verilog);




% Generate index array
i = 1:sample_num;

% Plot the arrays with index i
figure;
stem(i, isEqual2(i), 'DisplayName', 'data_verilog ', 'LineStyle', 'none', 'Marker', 'o');
hold on;
% Add labels and legend
xlabel('Index i');
ylabel('error');
title('Plot of tan() - cordic data_verilog');
legend('show');
grid on;
hold off;

