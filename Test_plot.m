% Define data
y_position = [1.0000, 0.9766, 0.9688, 0.9609, 0.9531, 0.8516, 0.7344, 0.6172, 0.5, 0.4531, 0.2813, 0.1719, 0.1016, 0.0703, 0.0625, 0.0547, 0];
u_velocity_Re100 = [1.0000, 0.84123, 0.78871, 0.73722, 0.68717, 0.23151, 0.00332, -0.13641, -0.20581, -0.21090, -0.15662, ...
    -0.1015, -0.06434, -0.04775, -0.04192, -0.03717, 0]; % Match length with y_position

% Plot
figure;
plot(y_position, u_velocity_Re100, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'MarkerFaceColor', 'blue');
grid on;
xlabel('y Position');
ylabel('u Velocity');
title('u-velocity along Vertical Line through Geometric Center of Cavity');


