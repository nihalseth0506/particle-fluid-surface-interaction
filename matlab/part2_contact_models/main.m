clear; clc; close all;

% Part 2: Velocity-based vs Energy-based contact comparison

params = parameters();

% Run velocity-based model
params.contactModel = "velocity";
results_vel = runSimulation(params);

% Run energy-based model
params.contactModel = "energy";
results_eng = runSimulation(params);

figure;
% Velocity-based model
plot(results_vel.x, results_vel.y, 'Color', [0 0.45 0.74], 'LineWidth', 1.8); 
hold on;
% Energy-based model
plot(results_eng.x, results_eng.y, 'Color', [0.85 0.33 0.10], 'LineWidth', 1.8);

% Terminal markers
plot(results_vel.x(end), results_vel.y(end), 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', [0 0.45 0.74], ...
    'MarkerEdgeColor', 'k');

plot(results_eng.x(end), results_eng.y(end), 's', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', [0.85 0.33 0.10], ...
    'MarkerEdgeColor', 'k');

xlabel('x [m]');
ylabel('y [m]');
title('Particle Trajectory: Contact Model Comparison');
legend('Velocity-based','Energy-based', 'Location','best');
grid on;

figure;
plot(results_vel.t, results_vel.vy, 'Color', [0 0.45 0.74], 'LineWidth', 1.6); 
hold on;
plot(results_eng.t, results_eng.vy, 'Color', [0.85 0.33 0.10], 'LineWidth', 1.6);

xlabel('Time [s]');
ylabel('v_y [m/s]');
title('Vertical Velocity: Contact Model Comparison');
legend('Velocity-based','Energy-based', 'Location','best');
grid on;

% Zoom into the contact/deposition region
xlim([0.15 0.30]);
