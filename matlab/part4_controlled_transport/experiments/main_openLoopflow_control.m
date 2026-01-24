clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\controllers")

params = parameters();
params.contactModel    = "energy";
params.depositionModel = "probabilistic";
params.E_adh           = 2.5e-9;
params.controlMode = "openloop";

results = runSimulation(params);

figure;
plot(results.x, results.y, 'LineWidth', 1.5);
xlabel('x [m]');
ylabel('y [m]');
title('Trajectory with Open-Loop Flow Control');
grid on;

figure;
plot(results.t, results.vy, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('v_y [m/s]');
title('Vertical Velocity under Open-Loop Flow');
grid on;
