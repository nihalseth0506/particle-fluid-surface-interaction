clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part3_deposition_statistics\core")

%% Adhesion energy regimes (low / transition / high)
Eadh_set = [2e-9, 2.5e-9, 3.0e-9];
labels   = {'Low adhesion', 'Transition', 'High adhesion'};

nParticles = 500;

%% Loop over adhesion energies
for k = 1:length(Eadh_set)

    %% Parameters
    params = parameters();
    params.contactModel    = "energy";
    params.depositionModel = "probabilistic";
    params.E_adh           = Eadh_set(k);

    %% Storage
    deposited   = zeros(1, nParticles);
    depositX    = nan(1, nParticles);
    depositTime = nan(1, nParticles);

    %% Multi-particle loop
    for p = 1:nParticles

        params.initialState = sampleInitialState();

        results = runSimulation(params);

        if any(results.deposited == 1)
            deposited(p) = 1;
            idx = find(results.deposited == 1, 1, 'first');
            depositX(p)    = results.x(idx);
            depositTime(p) = results.t(idx);
        end
    end

   %% Combined 2x2 visualization
figure;

% --- Subplot 1: Representative trajectory ---
subplot(2,2,1);
plot(results.x, results.y, 'LineWidth', 1.5);
xlabel('x [m]');
ylabel('y [m]');
title('Representative Particle Trajectory');
grid on;

% --- Subplot 2: Deposition fraction ---
subplot(2,2,2);
bar(mean(deposited));
ylim([0 1]);
ylabel('Fraction Deposited');
title('Deposition Fraction');
grid on;

% --- Subplot 3: Deposition location ---
subplot(2,2,3);
histogram(depositX(~isnan(depositX)), 50);
xlabel('x position [m]');
ylabel('Count');
title('Deposition Location');
grid on;

% --- Subplot 4: Time to deposition ---
subplot(2,2,4);
histogram(depositTime(~isnan(depositTime)), 50);
xlabel('Time [s]');
ylabel('Count');
title('Time to Deposition');
grid on;

sgtitle(['Multi-Particle Deposition Statistics – ' labels{k}]);

end
