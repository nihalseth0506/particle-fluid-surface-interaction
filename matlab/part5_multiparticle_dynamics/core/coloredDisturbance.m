function [u_dist, dist] = coloredDisturbance(dist, params)
% COLOREDDISTURBANCE  Time-correlated flow disturbance (OU process)

dt   = params.dt;
tau  = params.dist_tau;     % correlation time
sigma = params.dist_sigma;  % disturbance strength

% OU process coefficient
a = exp(-dt / tau);

% Update disturbance state
dist.x = a * dist.x + sigma * sqrt(1 - a^2) * randn;

% Horizontal disturbance only
u_dist = [dist.x; 0.3 * dist.x];
end
