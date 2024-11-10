
clear all 
sample_num = 100000;
fixed_scale = 2^12;
fileIDx = fopen('input_samples_x.txt', 'r');
datax = fscanf(fileIDx, '%d');
fclose(fileIDx);

fileIDy = fopen('input_samples_y.txt', 'r');
datay = fscanf(fileIDy, '%d');
fclose(fileIDy);

fileIDt = fopen('input_samples_tan.txt', 'r');
datat = fscanf(fileIDt, '%d');
fclose(fileIDt);

pi_fixed = round(pi * fixed_scale);
iterations = 13; % More iterations yield higher accuracy

data_out = zeros(1,sample_num);
    % Initialize x and y with the input values
for j = 1:sample_num
    x = datax(j);
    y = datay(j);
    z = 0; % Initial angle
    
    if x < 0 
       d = -1;
    else
       d = 1;
    end
    x = d*x;
    y = d*y;
    if d == 1
        z = z;
    else
        z = z - pi_fixed;
    end
        
    for i = 1:iterations
        % Determine rotation direction
 
            if y >= 0            
                d = -1;            
            else             
                d = +1;            
            end


        new_x = x - d * y * 2^-(i-1);
        new_y = y + d * x * 2^-(i-1);
        
        z = z - d * datat(i); % Accumulate the rotation angle based on direction
        
        % Update x and y for next iteration
        x = new_x;
        y = new_y;
        
    end

    data_out(j) = (z);

end
    fileIDc = fopen('cordic_mout.txt', 'w');
    for k = 1:sample_num
        fprintf(fileIDc, '%d\n', data_out(k));  % Write each element on a new line
    end
    


