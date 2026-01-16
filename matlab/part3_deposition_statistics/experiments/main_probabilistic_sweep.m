clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part3_deposition_statistics\core")

%% Probabilistic deposition sweep

params = parameters();
params.contactModel = "energy";        % reuse energy logic
params.depositionModel = "probabilistic";

Eadh_values = logspace(-9.5, -7.5, 40);    % adhesion energy sweep
nE = length(Eadh_values);

nRuns = 200;   % number of simulations per adhesion energy

depositFraction = zeros(1, nE);
meanDepositTime = nan(1, nE);

for i = 1:nE

    params.E_adh = Eadh_values(i);

    depositedCount = 0;
    depositTimes = [];

    for j = 1:nRuns

        results = runSimulation(params);

        if any(results.deposited == 1)
            depositedCount = depositedCount + 1;

            idx = find(results.deposited == 1, 1, 'first');
            depositTimes(end+1) = results.t(idx); %#ok<SAGROW>
        end
    end

    depositFraction(i) = depositedCount / nRuns;

    if ~isempty(depositTimes)
        meanDepositTime(i) = mean(depositTimes);
    end
end

%% Plot results

figure;
semilogx(Eadh_values, depositFraction, '-o', 'LineWidth', 1.8);
xlabel('Adhesion Energy E_{adh} [J]');
ylabel('Deposition Probability');
title('Probabilistic Deposition vs Adhesion Energy');
grid on;

figure;
semilogx(Eadh_values, meanDepositTime, '-s', 'LineWidth', 1.8);
xlabel('Adhesion Energy E_{adh} [J]');
ylabel('Mean Deposition Time [s]');
title('Mean Time to Deposition');
grid on;
