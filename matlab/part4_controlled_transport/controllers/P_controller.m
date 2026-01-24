function u = P_controller(state, params)
% P_CONTROLLER  Proportional feedback on x-position with saturation

% Extract state
x = state(1);

% Position error
error = params.x_target - x;

% Raw proportional control
ux_unsat = params.Kp * error;

% --- Saturation ---
ux = max(min(ux_unsat, params.u_max), -params.u_max);

uy = 0;   % no vertical control

u = [ux; uy];
end
