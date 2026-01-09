function state = wallInteraction(state, params)
% WALLINTERACTION  Handles collision, sticking, and persistent contact

y  = state(2);
vx = state(3);
vy = state(4);

% --- PRESERVE previous contact state ---
contact = state(5);

% Check if particle is at or below the wall
if y <= params.wallY

    % --- STICKING CONDITION (vertical) ---
    if vy > -params.vStick
        state(2) = params.wallY;
        state(4) = 0;
        contact  = 1;   % stay in contact

    % --- BOUNCE CONDITION ---
    elseif vy < 0
        state(2) = params.wallY;
        state(4) = -params.restitution * vy;
        contact  = 1;
    end

else
    % Particle is above wall → no contact
    contact = 0;
end

% --- FINAL HORIZONTAL STICKING ---
if contact == 1 && abs(state(3)) <= params.vxStick
    state(3) = 0;
end

% Write back contact state
state(5) = contact;

end
