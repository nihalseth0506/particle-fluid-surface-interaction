clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part3_deposition_statistics\core")

%% Part 3A – Adhesion Energy Sweep with Time-to-Deposition

% Adhesion energy sweep (log scale)
E_adh_values = logspace(-10, -6, 40);   % [J]
nE = length(E_adh_values);

% Storage
deposited     = zeros(1, nE);   % 0 or 1
t_deposition  = nan(1, nE);     % time to deposition [s]

%% Loop over adhesion energies
for i = 1:nE

    % Base parameters
    params = parameters();
    params.contactModel = "energy";
    params.depositionModel = "deterministic";
    params.E_adh = E_adh_values(i);

    % Run simulation
    results = runSimulation(params);

    % Final deposition state
    deposited(i) = results.deposited(end);

    % Time to deposition (first occurrence)
    if deposited(i) == 1
        idx = find(results.deposited == 1, 1, 'first');
        t_deposition(i) = results.t(idx);
    end
end

%% Plot 1: Deposition outcome vs adhesion energy
figure;
semilogx(E_adh_values, deposited, 'o-', ...
    'LineWidth', 1.5, 'MarkerSize', 6);
xlabel('Adhesion Energy E_{adh} [J]');
ylabel('Deposition Outcome');
yticks([0 1]);
yticklabels({'Rebound','Deposited'});
title('Deposition vs Adhesion Energy');
grid on;

%% Plot 2: Time to deposition vs adhesion energy
figure;
semilogx(E_adh_values, t_deposition, 's-', ...
    'LineWidth', 1.5, 'MarkerSize', 6);
xlabel('Adhesion Energy E_{adh} [J]');
ylabel('Time to Deposition [s]');
title('Time to Deposition vs Adhesion Energy');
grid on;
