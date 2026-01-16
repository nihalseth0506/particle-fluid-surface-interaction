% MAIN_COMPARISON_PROB_VS_DET
% Part 3: Comparison of deterministic and probabilistic
% energy-based deposition models

clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part3_deposition_statistics\core")

%% --- Run deterministic sweep ---
Eadh_det = logspace(-10, -6, 40);
nE = length(Eadh_det);

det_deposited = zeros(1,nE);
det_time      = nan(1,nE);

for i = 1:nE
    params = parameters();
    params.contactModel = "energy";
    params.depositionModel = "deterministic";
    params.E_adh = Eadh_det(i);

    results = runSimulation(params);

    det_deposited(i) = results.deposited(end);
    if det_deposited(i)
        idx = find(results.deposited==1,1,'first');
        det_time(i) = results.t(idx);
    end
end

%% --- Run probabilistic sweep ---
Eadh_prob = logspace(-9.5, -7.5, 40);
nRuns = 200;

prob_fraction = zeros(1,length(Eadh_prob));
prob_time     = nan(1,length(Eadh_prob));

for i = 1:length(Eadh_prob)
    params = parameters();
    params.contactModel = "energy";
    params.depositionModel = "probabilistic";
    params.E_adh = Eadh_prob(i);

    depositTimes = [];

    for j = 1:nRuns
        results = runSimulation(params);
        if any(results.deposited==1)
            idx = find(results.deposited==1,1,'first');
            depositTimes(end+1) = results.t(idx); %#ok<SAGROW>
        end
    end

    prob_fraction(i) = numel(depositTimes)/nRuns;
    if ~isempty(depositTimes)
        prob_time(i) = mean(depositTimes);
    end
end

%% --- 2x2 Comparison Plot ---
figure;

subplot(2,2,1)
semilogx(Eadh_det, det_deposited, 'o-', 'LineWidth',1.5)
ylabel('Deposited (0/1)')
title('Deterministic Deposition')
grid on

subplot(2,2,2)
semilogx(Eadh_prob, prob_fraction, 'o-', 'LineWidth',1.5)
ylabel('Deposition Probability')
title('Probabilistic Deposition')
grid on

subplot(2,2,3)
semilogx(Eadh_det, det_time, 's-', 'LineWidth',1.5)
xlabel('Adhesion Energy [J]')
ylabel('Time to Deposition [s]')
grid on

subplot(2,2,4)
semilogx(Eadh_prob, prob_time, 's-', 'LineWidth',1.5)
xlabel('Adhesion Energy [J]')
ylabel('Mean Deposition Time [s]')
grid on

sgtitle('Deterministic vs Probabilistic Deposition Models');
