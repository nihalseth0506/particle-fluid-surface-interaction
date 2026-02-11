function [u, ctrl] = PI_controller(state, params, ctrl)

x = state(1);
dt = params.dt;

% Position error
error = params.x_target - x;

% --- Integrate error (tentative) ---
intError_new = ctrl.intError + error * dt;

% --- Raw PI control ---
u_unsat = params.Kp * error + params.Ki * intError_new;

% --- Saturation ---
u = max(min(u_unsat, params.u_max), -params.u_max);

% --- Anti-windup condition ---
if abs(u) < params.u_max
    ctrl.intError = intError_new;   % allow integration
end

end
