function results = runSimulation(params)
% RUNSIMULATION  Time integration of particle motion

time = 0:params.dt:params.tEnd;
n = length(time);

state = params.initialState;

% Preallocate results
results.x  = zeros(1,n);
results.y  = zeros(1,n);
results.vx = zeros(1,n);
results.vy = zeros(1,n);
results.t  = time;

for i = 1:n
    % Store current state
    results.x(i)  = state(1);
    results.y(i)  = state(2);
    results.vx(i) = state(3);
    results.vy(i) = state(4);

    % Euler integration
    dstate = particleDynamics(state, params);
    state = state + dstate * params.dt;

    % Wall interaction (correction)
    state = wallInteraction(state, params);
end

end
