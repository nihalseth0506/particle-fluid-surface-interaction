function state = wallInteraction(state, params)

y  = state(2);
vx = state(3);
vy = state(4);

contact = state(5);

if y <= params.wallY

    switch params.contactModel

        case "velocity"
            % --- Model A: Velocity-based sticking (reversible) ---
            if abs(vy) < params.vStick
                state(2) = params.wallY;
                state(4) = 0;
                contact  = 1;

            elseif vy < 0
                state(2) = params.wallY;
                state(4) = -params.restitution * vy;
                contact  = 1;
            end

        case "energy"
            % --- Model B: Energy-based deposition (irreversible) ---
            En = 0.5 * params.mass * vy^2;

            if En < params.E_adh
                state(2) = params.wallY;
                state(3) = 0;
                state(4) = 0;
                contact  = 1;
                state(6) = 1;   % terminal state
                return;

            elseif vy < 0
                state(2) = params.wallY;
                state(4) = -params.restitution * vy;
                contact  = 1;
            end
    end

else
    contact = 0;
end

% --- Numerical stabilization (horizontal only) ---
if contact == 1 && abs(vx) < params.vxStick
    state(3) = 0;
end

state(5) = contact;
end
