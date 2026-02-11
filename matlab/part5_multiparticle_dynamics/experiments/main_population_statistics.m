clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part5_multiparticle_dynamics\controllers")

% -------------------------------------------------
% Global simulation parameters
% -------------------------------------------------
params = parameters();

params.contactModel    = "energy";
params.depositionModel = "probabilistic";

% Target and capture settings
params.x_target = 1.0;
params.x_capture_center = params.x_target;
params.x_capture_width  = 0.03;

% Controller settings
params.controlMode = "PID";
params.Kp = 10;
params.Ki = 5;
params.Kd = 5;
params.u_max = 2;

% Disturbance OFF for statistics clarity
params.enableDisturbance = false;

% -------------------------------------------------
% Monte Carlo settings
% -------------------------------------------------
N_particles = 50;      % particles per run
N_runs      = 50;      % number of independent runs

% Storage for statistics
final_fraction_deposited = zeros(1, N_runs);
mean_deposition_time     = zeros(1, N_runs);
all_deposition_locations = [];

% -------------------------------------------------
% Monte Carlo loop
% -------------------------------------------------
for r = 1:N_runs

    % Reset controller memory for each run
    params.ctrl.intError = 0;

    all_dep_times = [];

    % Sample new particle population
    states0 = sampleInitialStates(N_particles, params);

    % Run multi-particle simulation
    results = runSimulationMulti(params, states0);

    % -------------------------------------------------
    % Extract statistics for this run
    % -------------------------------------------------
    deposited_final = results.deposited(:, end) == 1;

    % Fraction deposited
    final_fraction_deposited(r) = mean(deposited_final);

    % Deposition times
    dep_times = nan(N_particles,1);
    for p = 1:N_particles
        idx = find(results.deposited(p,:) == 1, 1, 'first');
        if ~isempty(idx)
            dep_times(p) = results.t(idx);
        end
    end

    mean_deposition_time(r) = mean(dep_times, 'omitnan');

    % Final deposition locations
    x_dep = results.x(deposited_final, end);
    all_deposition_locations = [all_deposition_locations; x_dep];

end

figure('Name','Monte Carlo Population Statistics','NumberTitle','off');

% 1. Fraction deposited
subplot(2,2,1)
histogram(final_fraction_deposited, 'BinEdges', 0:0.05:1)
xlabel('Final Fraction Deposited')
ylabel('Count')
title('Deposition Success Rate')
grid on

% 2. Mean deposition time
subplot(2,2,2)
histogram(mean_deposition_time, 15)
xlabel('Mean Deposition Time [s]')
ylabel('Count')
title('Mean Deposition Time Distribution')
grid on

% 3. Deposition locations
subplot(2,2,3)
histogram(all_deposition_locations, 25)
xline(params.x_target,'--r','Target')
xlabel('x position [m]')
ylabel('Count')
title('Deposition Location Distribution')
grid on

% 4. Cumulative deposition time
subplot(2,2,4)
[f, x] = ecdf(final_fraction_deposited);
plot(x, f, 'LineWidth', 1.5)
xlabel('Final Fraction Deposited')
ylabel('Cumulative Probability')
title('Deposition Reliability Across Runs')
grid on


sgtitle('Monte Carlo Population Statistics (PID Controlled)');