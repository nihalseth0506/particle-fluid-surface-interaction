clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\controllers")

params = parameters();
params.contactModel    = "energy";
params.depositionModel = "probabilistic";
params.controlMode = "PID";

params.x_target = 0.1; 
params.x_capture_center = params.x_target;
params.Kp = 5;
params.Ki = 0.5;
params.Kd =0.5;
params.u_max = 2;

results = runSimulation(params);

% --- Trajectory ---
figure;
plot(results.x, results.y, 'LineWidth', 1.5);
xlabel('x [m]');
ylabel('y [m]');
title('Trajectory with PID Feedback Control');
grid on;

% --- Control response ---
figure;
plot(results.t, results.vx, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('v_x [m/s]');
title('Controlled Horizontal Velocity (PID)');
grid on;

figure;
plot(results.t, results.x, 'LineWidth', 1.5);
yline(params.x_target, '--r', 'Target');
xlabel('Time [s]');
ylabel('x [m]');
title('Horizontal Position vs Time');
grid on;

figure;
stairs(results.t, results.deposited, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('Deposited (0/1)');
title('Deposition Event');
ylim([-0.1 1.1]);
grid on;
