
clear all
num_samples = 100000;
iterations = 13;
input_x = zeros(1,num_samples);
input_y = zeros(1,num_samples);
atan_inputs = zeros(1,iterations);
scaleFactor = 2^12;
for i=1 : num_samples
   % Generate random values in (-1, 1) and scale them
    while true
%         % Check if both values are zero
%         if ~(input_x(i) == 0 && input_y(i) == 0)
%             break; % Exit the loop if both are not zero
%         end
        
              % Check if both values are too close to zero
         temp_x = (-1 + 2 * rand()) * scaleFactor;
        temp_y = (-1 + 2 * rand()) * scaleFactor;
        
        % Check if both values are zero
        if ~(temp_x == 0 && temp_y == 0)
            input_x(i) = temp_x;
            input_y(i) = temp_y;
            break; % Exit the loop if both are not zero
        end
    end
end

for j = 1 : iterations
    atan_inputs(j) = atan(2^-(j-1))*scaleFactor;
end
fileIDx = fopen('input_samples_x.txt', 'w');

fileIDy = fopen('input_samples_y.txt', 'w');
fileIDt = fopen('input_samples_tan.txt', 'w');

for i = 1:num_samples
    fprintf(fileIDx, '%d\n', round(input_x(i)));  % Write each element on a new line
end
for i = 1:num_samples
    fprintf(fileIDy, '%d\n', round(input_y(i)));  % Write each element on a new line
end

for i = 1:iterations
    fprintf(fileIDt, '%d\n', round(atan_inputs(i)));  % Write each element on a new line
end