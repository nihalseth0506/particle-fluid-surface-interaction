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
results.deposited = zeros(1,n);
results.u_x = zeros(1,n);   % store applied fluid velocity

% --- Controller internal state ---
ctrl.intError = 0;

% --- Disturbance internal state ---
dist.x = 0;

for i = 1:n

    % Store current state
    results.x(i)  = state(1);
    results.y(i)  = state(2);
    results.vx(i) = state(3);
    results.vy(i) = state(4);
    results.deposited(i) = state(6);

    % ===============================
    % 1) Select control law
    % ===============================
    switch params.controlMode

        case "openloop"
            u_cmd = openLoopFlow(time(i));

        case "P"
            u_cmd = P_controller(state, params);

        case "PI"
            [ux, ctrl] = PI_controller(state, params, ctrl);
            u_cmd = [ux; 0];

        case "PID"
            [ux, ctrl] = PID_controller(state, ctrl, params);
            u_cmd = [ux; 0];

        otherwise
            error("Unknown control mode");
    end

    % ===============================
    % 2) Add disturbance (all modes)
    % ===============================
    if params.enableDisturbance
        [u_dist, dist] = coloredDisturbance(dist, params);
    else
        u_dist = [0; 0];
    end

    % ===============================
    % 3) Apply fluid velocity
    % ===============================
    params.fluidVelocity = u_cmd + u_dist;

    % Store applied control
    results.u_x(i) = params.fluidVelocity(1);

    % ===============================
    % 4) Continuous dynamics
    % ===============================
    dstate = particleDynamics(state, params);
    state  = state + dstate * params.dt;

    % ===============================
    % 5) Wall interaction
    % ===============================
    state = wallInteraction(state, params);

end

end
