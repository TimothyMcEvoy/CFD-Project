clear
clc

% Data
h = [1, 2, 4, 8, 16];

p1 = [0.000055, 0.000023, 0.000080, 0.000395, 0.002279];
u1 = [0.000013, 0.000005, 0.000021, 0.000088, 0.000386];
v1 = [0.000031, 0.000004, 0.000003, 0.000035, 0.000131];

p2 = [0.000065, 0.000041, 0.000171, 0.000797, 0.003779];
u2 = [0.000016, 0.000007, 0.000028, 0.000138, 0.000734];
v2 = [0.000040, 0.000005, 0.000004, 0.000046, 0.000194];

pinf = [0.000180, 0.000438, 0.001318, 0.003952, 0.011769];
uinf = [0.000029, 0.000016, 0.000088, 0.000473, 0.002404];
vinf = [0.000023, 0.000013, 0.000009, 0.000047, 0.000133];

% Define colors for each group
color_p = 'b'; % Blue for p norms
color_u = 'r'; % Red for u norms
color_v = 'g'; % Green for v norms

% Create log-log plot
figure; % Open a new figure

% Plot p norms (all the same color)
loglog(h, p1, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_p, 'DisplayName', 'p: L1');
hold on;
loglog(h, p2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_p, 'DisplayName', 'p: L2');
loglog(h, pinf, '-d', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_p, 'DisplayName', 'p Linf}');

% Plot u norms (all the same color)
loglog(h, u1, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_u, 'DisplayName', 'u: L1');
loglog(h, u2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_u, 'DisplayName', 'u: L2');
loglog(h, uinf, '-d', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_u, 'DisplayName', 'u: Linf');

% Plot v norms (all the same color)
loglog(h, v1, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_v, 'DisplayName', 'v: L1');
loglog(h, v2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_v, 'DisplayName', 'v: L2');
loglog(h, vinf, '-d', 'LineWidth', 1.5, 'MarkerSize', 8, 'Color', color_v, 'DisplayName', 'v: Linf');

% Add grid, labels, title, and legend
grid on;
xlabel('h', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('DE norms', 'FontSize', 12, 'Interpreter', 'latex');
%title('Log-Log Plot of $p$, $u$, and $v$ norms', 'FontSize', 14, 'Interpreter', 'latex');
legend('Location', 'best', 'FontSize', 7);

% Adjust axis limits (optional)
xlim([min(h) max(h)]);
ylim([1e-6 1e-1]);

% Final touch
set(gca, 'FontSize', 12, 'LineWidth', 1); % Enhance axis appearance
hold off;
