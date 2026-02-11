function results = runSimulationMulti(params, states0)
% RUNSIMULATIONMULTI
% Time integration of multiple particles under shared flow and disturbance
%
% states0: 6 x N initial state matrix

time = 0:params.dt:params.tEnd;
nt   = length(time);
N    = size(states0, 2);

% Initialize states
states = states0;

% Preallocate results
results.x  = zeros(N, nt);
results.y  = zeros(N, nt);
results.vx = zeros(N, nt);
results.vy = zeros(N, nt);
results.deposited = zeros(N, nt);
results.t  = time;

% Disturbance state (shared)
dist.x = 0;

for k = 1:nt

    % -------------------------------------------------
    % Shared flow + disturbance (once per time step)
    % -------------------------------------------------
    switch params.controlMode

        case "openloop"
            u_flow = openLoopFlow(time(k));

        case "PID"
            % Mean x-position of airborne particles
            active = states(6,:) == 0;
            if any(active)
                x_mean = mean(states(1,active));
            else
                x_mean = params.x_target;
            end

            % Virtual state for controller
            ctrlState = [x_mean; 0; 0; 0; 0; 0];
            [ux, params.ctrl] = PID_controller(ctrlState, params.ctrl, params);
            u_flow = [ux; 0];

        otherwise
            u_flow = [0; 0];
    end

    % Disturbance (shared)
    if params.enableDisturbance
        [u_dist, dist] = coloredDisturbance(dist, params);
    else
        u_dist = [0; 0];
    end

    params.fluidVelocity = u_flow + u_dist;

    % -------------------------------------------------
    % Update each particle
    % -------------------------------------------------
    for p = 1:N

        % Skip deposited particles
        if states(6,p) == 1
            % Store current state
        results.x(p,k)  = states(1,p);
        results.y(p,k)  = states(2,p);
        results.vx(p,k) = states(3,p);
        results.vy(p,k) = states(4,p);
        results.deposited(p,k) = states(6,p);
        continue;
        end

        % Continuous dynamics
        dstate = particleDynamics(states(:,p), params);
        states(:,p) = states(:,p) + dstate * params.dt;

        % Wall interaction
        states(:,p) = wallInteraction(states(:,p), params);

        % Store current state
        results.x(p,k)  = states(1,p);
        results.y(p,k)  = states(2,p);
        results.vx(p,k) = states(3,p);
        results.vy(p,k) = states(4,p);
        results.deposited(p,k) = states(6,p);
    end
end
end
