clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\utilities")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\controllers")

% -------------------------------------------------
% Parameters
% -------------------------------------------------
params = parameters();

params.contactModel    = "energy";
params.depositionModel = "probabilistic";

% Control settings
params.controlMode = "PID";
params.x_target = 1.0;
params.x_capture_center = params.x_target;
params.x_capture_width  = 0.03;

params.Kp = 10;
params.Ki = 5;
params.Kd = 5;
params.u_max = 2;

% Disturbance OFF for clean comparison
params.enableDisturbance = false;

% -------------------------------------------------
% Initial particle population
% -------------------------------------------------
N = 50;
states0 = sampleInitialStates(N);

% Initialize controller memory
params.ctrl.intError = 0;

% -------------------------------------------------
% Run simulation
% -------------------------------------------------
results = runSimulationMulti(params, states0);

% -------------------------------------------------
% Visualization: Controlled Flow (2x2)
% -------------------------------------------------

figure('Name','Controlled Flow – Multi-Particle Transport','NumberTitle','off');

% -------------------------------------------------
% 1. Trajectories (x–y)
% -------------------------------------------------
subplot(2,2,1)
hold on
for p = 1:N
    plot(results.x(p,:), results.y(p,:), 'LineWidth', 0.8);
end
xlabel('x [m]')
ylabel('y [m]')
title('Trajectories (Controlled Flow)')
grid on

% -------------------------------------------------
% 2. Mean horizontal position vs time
% -------------------------------------------------
subplot(2,2,2)
mean_x = mean(results.x, 1);
plot(results.t, mean_x, 'LineWidth', 1.5); hold on
yline(params.x_target, '--r', 'Target')
xlabel('Time [s]')
ylabel('Mean x [m]')
title('Mean Horizontal Position')
grid on

% -------------------------------------------------
% 3. Deposition fraction vs time
% -------------------------------------------------
subplot(2,2,3)
fractionDeposited = mean(results.deposited, 1);
plot(results.t, fractionDeposited, 'LineWidth', 1.5)
xlabel('Time [s]')
ylabel('Fraction Deposited')
title('Population Deposition Fraction')
ylim([0 1])
grid on

% -------------------------------------------------
% 4. Final particle x-position distribution
% -------------------------------------------------
subplot(2,2,4)
finalX = results.x(:, end);
histogram(finalX, 20)
xlabel('x position [m]')
ylabel('Count')
title('Final Particle Positions')
grid on

% -------------------------------------------------
% Super title
% -------------------------------------------------
sgtitle('Controlled (PID) Multi-Particle Transport and Deposition');

disp(params.x_target-mean_x)