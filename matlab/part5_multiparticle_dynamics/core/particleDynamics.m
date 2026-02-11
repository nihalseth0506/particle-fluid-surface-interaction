function dstate = particleDynamics(state, params)
% PARTICLEDYNAMICS  Computes derivatives of particle state

% Terminal (absorbing) state: deposited particle
if state(6) == 1
    dstate = zeros(6,1);
    return;
end

x  = state(1);
y  = state(2);
vx = state(3);
vy = state(4);
contact = state(5);

% Relative velocity
vRelX = vx - params.fluidVelocity(1);
vRelY = vy - params.fluidVelocity(2);

% Forces
Fx_drag = -params.dragCoeff * vRelX;
Fy_drag = -params.dragCoeff * vRelY;
Fy_grav = -params.mass * params.g;

% Accelerations
ax = Fx_drag / params.mass;
ay = (Fy_drag + Fy_grav) / params.mass;

% --- NEW: surface friction in x (only if in contact) ---
if contact == 1 && abs(vx) > 1e-6
    Fx_friction = -params.mu * params.mass * params.g * sign(vx);
    ax = ax + Fx_friction / params.mass;
end
% --- FINAL STABILIZATION: stop re-acceleration in contact ---
if contact == 1 && vx==0
    ax = 0;
end
% State derivatives
dstate = [vx; vy; ax; ay; 0; 0];

end
