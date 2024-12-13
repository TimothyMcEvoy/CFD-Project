h = [1, 2, 4, 8, 16]; % Flip h

p1 = flip([0.000055, 0.000023, 0.000080, 0.000395, 0.002279]);
u1 = flip([0.000013, 0.000005, 0.000021, 0.000088, 0.000386]);
v1 = flip([0.000031, 0.000004, 0.000003, 0.000035, 0.000131]);

p2 = flip([0.000065, 0.000041, 0.000171, 0.000797, 0.003779]);
u2 = flip([0.000016, 0.000007, 0.000028, 0.000138, 0.000734]);
v2 = flip([0.000040, 0.000005, 0.000004, 0.000046, 0.000194]);

pinf = flip([0.000180, 0.000438, 0.001318, 0.003952, 0.011769]);
uinf = flip([0.000029, 0.000016, 0.000088, 0.000473, 0.002404]);
vinf = flip([0.000023, 0.000013, 0.000009, 0.000047, 0.000133]);


r = 2;

% Preallocate arrays
p_L1p = zeros(1, length(h)-1);
p_L2p = zeros(1, length(h)-1);
p_Linfp = zeros(1, length(h)-1);

p_L1u = zeros(1, length(h)-1);
p_L2u = zeros(1, length(h)-1);
p_Linfu = zeros(1, length(h)-1);

p_L1v = zeros(1, length(h)-1);
p_L2v = zeros(1, length(h)-1);
p_Linfv = zeros(1, length(h)-1);

% Calculate the values
for i = 1:length(h)-1
    p_L1p(i) = h(i)*(p1(i+1)/p1(i))/log(r);
    p_L2p(i) = h(i)*(p2(i+1)/p2(i))/log(r);
    p_Linfp(i) = h(i)*(pinf(i+1)/pinf(i))/log(r);

    p_L1u(i) = h(i)*(u1(i+1)/u1(i))/log(r);
    p_L2u(i) = h(i)*(u2(i+1)/u2(i))/log(r);
    p_Linfu(i) = h(i)*(uinf(i+1)/uinf(i))/log(r);

    p_L1v(i) = h(i)*(v1(i+1)/v1(i))/log(r);
    p_L2v(i) = h(i)*(v2(i+1)/v2(i))/log(r);
    p_Linfv(i) = h(i)*(vinf(i+1)/vinf(i))/log(r);
end

% Plot all results on the same plot
figure('Position', [100, 100, 800, 600]); % Adjust figure size for better screen fit
hold on;
plot(h(1:end-1), p_L1p, '-o', 'DisplayName', 'p: L1');
plot(h(1:end-1), p_L2p, '-x', 'DisplayName', 'p: L2');
plot(h(1:end-1), p_Linfp, '-s', 'DisplayName', 'p: Linf');

plot(h(1:end-1), p_L1u, '-^', 'DisplayName', 'u: L1');
plot(h(1:end-1), p_L2u, '-v', 'DisplayName', 'u: L2');
plot(h(1:end-1), p_Linfu, '-d', 'DisplayName', 'u: Linf');

plot(h(1:end-1), p_L1v, '-<', 'DisplayName', 'v: L1');
plot(h(1:end-1), p_L2v, '->', 'DisplayName', 'v: L2');
plot(h(1:end-1), p_Linfv, '-p', 'DisplayName', 'v: Linf');

% Customize plot
xlabel('h');
ylabel('Observed Order p');
legend('show', 'Location', 'best'); % Show legend in the best location
grid on;

% Set x-axis to log scale only and y-axis limit to 20
set(gca, 'XScale', 'log');
ylim([0, 20]); % Set y-axis limit to 20

hold off;
