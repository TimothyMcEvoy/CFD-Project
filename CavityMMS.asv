clear
clc
% plot.m
% Script to plot x and y against p, u, and v from a data file with 11 columns.

% Load the data
filename = 'cavity.dat'; % Update the filename as needed
fid = fopen(filename, 'r');

% Skip lines until 'DATAPACKING=POINT' is found
while true
    tline = fgetl(fid);
    if ~ischar(tline)
        error('End of file reached without finding data start.');
    end
    if contains(tline, 'DATAPACKING=POINT')
        break;
    end
end

% Skip empty lines after the header
while true
    tline = fgetl(fid);
    if ~ischar(tline)
        error('End of file reached without finding data.');
    end
    if ~isempty(strtrim(tline))
        % Move the file position indicator back one line
        fseek(fid, -length(tline)-2, 'cof');
        break;
    end
end

% Read the data
dataArray = cell(1, 11); % Initialize cell array to store data from all zones
fid = fopen(filename, 'r');

while ~feof(fid)
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    if contains(tline, 'DATAPACKING=POINT')
        % Skip empty lines after 'DATAPACKING=POINT'
        while true
            pos = ftell(fid);
            tline = fgetl(fid);
            if ~ischar(tline) || ~isempty(strtrim(tline))
                fseek(fid, pos, 'bof'); % Go back one line
                break;
            end
        end

        % Read data block
        tempData = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f', 'Delimiter', {' ', '\t'}, ...
            'MultipleDelimsAsOne', true, 'CollectOutput', true);
        if ~isempty(tempData{1})
            blockData = tempData{1};
            for i = 1:11
                dataArray{i} = [dataArray{i}; blockData(:, i)];
            end
        end
    end
end
fclose(fid);

% Check if data has been loaded
if isempty(dataArray{1})
    error('Data could not be loaded. Check the file format and delimiters.');
end

% Extract variables from dataArray
% Extract variables from dataArray
J = 9;
x = dataArray{1};
y = dataArray{2};
p = dataArray{3};
u = dataArray{4};
v = dataArray{5};
p_exact = dataArray{6};
u_exact = dataArray{7};
v_exact = dataArray{8};
DE_p = dataArray{9};
DE_u = dataArray{10};
DE_v = dataArray{11};

% Get the length of each array
x_len = length(x);
y_len = length(y);
p_len = length(p);
u_len = length(u);
v_len = length(v);
p_exact_len = length(p_exact);
u_exact_len = length(u_exact);
v_exact_len = length(v_exact);
DE_p_len = length(DE_p);
DE_u_len = length(DE_u);
DE_v_len = length(DE_v);

% Ensure J^2 doesn't exceed the array length and calculate the trim index
trim_index_x = max(x_len - J^2 + 1, 1);
trim_index_y = max(y_len - J^2 + 1, 1);
trim_index_p = max(p_len - J^2 + 1, 1);
trim_index_u = max(u_len - J^2 + 1, 1);
trim_index_v = max(v_len - J^2 + 1, 1);
trim_index_p_exact = max(p_exact_len - J^2 + 1, 1);
trim_index_u_exact = max(u_exact_len - J^2 + 1, 1);
trim_index_v_exact = max(v_exact_len - J^2 + 1, 1);
trim_index_DE_p = max(DE_p_len - J^2 + 1, 1);
trim_index_DE_u = max(DE_u_len - J^2 + 1, 1);
trim_index_DE_v = max(DE_v_len - J^2 + 1, 1);

% Trim each array from the calculated index to the end and save to the same variables
x = x(trim_index_x:end);
y = y(trim_index_y:end);
p = p(trim_index_p:end);
u = u(trim_index_u:end);
v = v(trim_index_v:end);
p_exact = p_exact(trim_index_p_exact:end);
u_exact = u_exact(trim_index_u_exact:end);
v_exact = v_exact(trim_index_v_exact:end);
DE_p = DE_p(trim_index_DE_p:end);
DE_u = DE_u(trim_index_DE_u:end);
DE_v = DE_v(trim_index_DE_v:end);


totalElements = length(x);
I = totalElements / J;
if mod(totalElements, J) ~= 0
    error('Total number of data points is not divisible by J.');
end
disp(['Reshaping data with I=', num2str(I), ' and J=', num2str(J)]);



% Reshape each array into I x J matrix
X = reshape(x, I, J);
Y = reshape(y, I, J);
P = reshape(p, I, J);
U = reshape(u, I, J);
V = reshape(v, I, J);
P_exact = reshape(p_exact, I, J);
U_exact = reshape(u_exact, I, J);
V_exact = reshape(v_exact, I, J);
DE_P = reshape(DE_p, I, J);
DE_U = reshape(DE_u, I, J);
DE_V = reshape(DE_v, I, J);
% Validate array lengths
expectedLength = J^2;
variables = {'x', 'y', 'p', 'u', 'v', 'p_exact', 'u_exact', 'v_exact', 'DE_p', 'DE_u', 'DE_v'};
for i = 1:length(variables)
    if length(eval(variables{i})) < expectedLength
        error('%s array length is insufficient for reshaping. Check the data.', variables{i});
    end
end

% Reshape data into matrices
I = length(x) / J;
if mod(length(x), J) ~= 0
    error('Total number of data points is not divisible by J.');
end

X = reshape(x, I, J);
Y = reshape(y, I, J);
P = reshape(p, I, J);
U = reshape(u, I, J);
V = reshape(v, I, J);
P_exact = reshape(p_exact, I, J);
U_exact = reshape(u_exact, I, J);
V_exact = reshape(v_exact, I, J);
DE_P = reshape(DE_p, I, J);
DE_U = reshape(DE_u, I, J);
DE_V = reshape(DE_v, I, J);

% % Plot Pressure
% figure;
% contourf(X, Y, P);
% title('Pressure');
% xlabel('x (m)');
% ylabel('y (m)');
% colorbar;
% 
% % Plot Velocity u
% figure;
% contourf(X, Y, U);
% title('Velocity u');
% xlabel('x (m)');
% ylabel('y (m)');
% colorbar;
% 
% % Plot Velocity v
% figure;
% contourf(X, Y, V);
% title('Velocity v');
% xlabel('x (m)');
% ylabel('y (m)');
% colorbar;

% % Plot Exact Pressure
% figure;
% contourf(X, Y, P_exact);
% title('Exact Pressure');
% xlabel('x (m)');
% ylabel('y (m)');
% colorbar;
% 
% % Plot Exact Velocity u
% figure;
% contourf(X, Y, U_exact);
% title('Exact Velocity u');
% xlabel('x (m)');
% ylabel('y (m)');
% colorbar;
% 
% % Plot Exact Velocity v
% figure;
% contourf(X, Y, V_exact);
% title('Exact Velocity v');
% xlabel('x (m)');
% ylabel('y (m)');
% colorbar;
