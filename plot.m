% plot.m
% Script to plot x and y against p, u, and v from cavity.dat

% Load the data
filename = 'cavity.dat';
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
dataArray = cell(1,5); % Initialize cell array to store data from all zones
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
        tempData = textscan(fid, '%f%f%f%f%f', 'Delimiter', {' ', '\t'}, ...
            'MultipleDelimsAsOne', true, 'CollectOutput', true);
        if ~isempty(tempData{1})
            blockData = tempData{1};
            % Append to the main dataArray
            dataArray{1} = [dataArray{1}; blockData(:,1)];
            dataArray{2} = [dataArray{2}; blockData(:,2)];
            dataArray{3} = [dataArray{3}; blockData(:,3)];
            dataArray{4} = [dataArray{4}; blockData(:,4)];
            dataArray{5} = [dataArray{5}; blockData(:,5)];
        end
    end
end
fclose(fid);

% Check if data has been loaded
if isempty(dataArray{1})
    error('Data could not be loaded. Check the file format and delimiters.');
end

% Extract variables
x = dataArray{1};
y = dataArray{2};
p = dataArray{3};
u = dataArray{4};
v = dataArray{5};

% Display a few values to verify data loading
disp('First few values of x:'); disp(x(1:min(5,end)));
disp('First few values of y:'); disp(y(1:min(5,end)));
disp('First few values of p:'); disp(p(1:min(5,end)));

% Optional: Sort data by x and y
% [~, sortIdx] = sortrows(data, {'Var1', 'Var2'});
% x = x(sortIdx);
% y = y(sortIdx);
% p = p(sortIdx);
% u = u(sortIdx);
% v = v(sortIdx);

% Determine I and J
J = 129;
totalElements = length(x);
I = totalElements / J;
if mod(totalElements, J) ~= 0
    error('Total number of data points is not divisible by J.');
end
disp(['Reshaping data with I=', num2str(I), ' and J=', num2str(J)]);

% Reshape data into matrices
X = reshape(x, I, J);
Y = reshape(y, I, J);
P = reshape(p, I, J);
U = reshape(u, I, J);
V = reshape(v, I, J);
disp(['X size: ', num2str(size(X))]);
disp(['Y size: ', num2str(size(Y))]);
disp(['P size: ', num2str(size(P))]);
disp(['U size: ', num2str(size(U))]);
disp(['V size: ', num2str(size(V))]);

% Optional: Plot a simple scatter to verify data
figure;
scatter(x, y, 10, p, 'filled');
title('Pressure Scatter Plot');
xlabel('x (m)');
ylabel('y (m)');
colorbar;

% Plot Pressure
figure;
surf(X, Y, P);
title('Pressure Field');
xlabel('x (m)');
ylabel('y (m)');
zlabel('p (N/m^2)');
shading interp;
colorbar;

% Plot Velocity u
figure;
surf(X, Y, U);
title('Velocity u');
xlabel('x (m)');
ylabel('y (m)');
zlabel('u (m/s)');
shading interp;
colorbar;

% Plot Velocity v
figure;
surf(X, Y, V);
title('Velocity v');
xlabel('x (m)');
ylabel('y (m)');
zlabel('v (m/s)');
shading interp;
colorbar;