clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\controllers")

params = parameters();
params.contactModel    = "energy";
params.depositionModel = "probabilistic";   % deterministic or probabilistic
params.controlMode = "PI";

params.x_target = 0.1; 
params.x_capture_center = params.x_target;
params.Kp = 5;
params.Ki = 0.5;

params.u_max = 2;

results = runSimulation(params);

% --- Trajectory ---
figure;
plot(results.x, results.y, 'LineWidth', 1.5);
xlabel('x [m]');
ylabel('y [m]');
title('Trajectory with PI Feedback Control');
grid on;

% --- Horizontal velocity ---
figure;
plot(results.t, results.vx, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('v_x [m/s]');
title('Controlled Horizontal Velocity (PI)');
grid on;
