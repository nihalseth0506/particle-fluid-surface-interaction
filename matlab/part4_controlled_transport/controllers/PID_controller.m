
function [ux, ctrl] = PID_controller(state, ctrl, params)
% PID_CONTROLLER  Computes horizontal flow velocity using PID control

% Extract states
x  = state(1);
vx = state(3);

% Parameters
dt = params.dt;

% Error (position tracking)
error = params.x_target - x;

% --- Integral update (candidate) ---
intError_new = ctrl.intError + error * dt;

% --- Derivative term ---
derr = -vx;   % because d/dt(x_target - x) = -vx

% --- Unsaturated control ---
u_unsat = params.Kp * error + ...
          params.Ki * intError_new + ...
          params.Kd * derr;

% --- Saturation ---
ux = max(min(u_unsat, params.u_max), -params.u_max);

% --- Anti-windup ---
if abs(ux) < params.u_max
    ctrl.intError = intError_new;

end
end
