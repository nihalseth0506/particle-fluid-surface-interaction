clear; clc; close all;

% ---------------------------------------------------------
% Paths
% ---------------------------------------------------------
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\utilities")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\controllers")

% ---------------------------------------------------------
% Parameters
% ---------------------------------------------------------
params = parameters();

% Physics
params.contactModel    = "energy";
params.depositionModel = "probabilistic";

% Control mode
params.controlMode = "openloop";

% Disturbance
params.enableDisturbance = true;   % set false for deterministic baseline

% ---------------------------------------------------------
% Particle population
% ---------------------------------------------------------
N = 50;   % number of particles

states0 = sampleInitialStates(N, params);   % 6 x N matrix

% ---------------------------------------------------------
% Run multi-particle simulation
% ---------------------------------------------------------
results = runSimulationMulti(params, states0);

% ---------------------------------------------------------
% Visualization
% ---------------------------------------------------------
figure;

% --- 1. Trajectories ---
subplot(2,2,1); hold on;
for p = 1:N
    plot(results.x(p,:), results.y(p,:), 'LineWidth', 0.8);
end
xlabel('x [m]');
ylabel('y [m]');
title('Trajectories (Open-Loop)');
grid on;

% --- 2. Mean x vs time ---
subplot(2,2,2);
mean_x = mean(results.x, 1);
plot(results.t, mean_x, 'LineWidth', 1.5); hold on;
yline(params.x_target, '--r', 'Target');
xlabel('Time [s]');
ylabel('Mean x [m]');
title('Mean Horizontal Position');
grid on;

% --- 3. Deposition fraction ---
subplot(2,2,3);
depositFraction = mean(results.deposited, 1);
plot(results.t, depositFraction, 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('Fraction Deposited');
title('Deposition Fraction');
ylim([0 1]);
grid on;

% --- 4. Final x distribution (all particles) ---
subplot(2,2,4);
histogram(results.x(:,end), 25);
xlabel('x position [m]');
ylabel('Count');
title('Final Particle Positions');
grid on;

sgtitle('Open-Loop Multi-Particle Transport');
