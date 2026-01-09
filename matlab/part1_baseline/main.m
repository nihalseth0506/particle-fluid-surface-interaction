clear; clc; close all;

params = parameters();
results = runSimulation(params);

figure;
plot(results.x, results.y, 'LineWidth', 1.5);
xlabel('X Position [m]');
ylabel('Y Position [m]');
title('Particle Trajectory with Wall Interaction');
grid on;

figure;
plot(results.t, results.vx, 'LineWidth', 1.5); hold on;
plot(results.t, results.vy, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('Velocity [m/s]');
legend('v_x', 'v_y');
title('Particle Velocity vs Time');
grid on;

%% Comparison: Effect of Fluid Velocity on v_x

% Case 1: Still fluid
params1 = parameters();
params1.fluidVelocity = [0; 0];
results_still = runSimulation(params1);

% Case 2: Moving fluid
params2 = parameters();
params2.fluidVelocity = [0.5; 0];
results_flow = runSimulation(params2);

% Plot comparison
figure;
plot(results_still.t, results_still.vx, 'LineWidth', 1.5); hold on;
plot(results_flow.t, results_flow.vx, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('v_x [m/s]');
legend('Still fluid (v_f = 0)', 'Moving fluid (v_f = 0.5 m/s)', ...
       'Location', 'best');
title('Effect of Fluid Velocity on Particle Horizontal Motion');
grid on;