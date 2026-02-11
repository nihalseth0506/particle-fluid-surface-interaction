function params = parameters()
% PARAMETERS  Define physical, control, and disturbance parameters

%% --- Particle properties ---
params.mass = 1e-6;            % kg
params.dragCoeff = 1e-5;       % drag coefficient

%% --- Environment ---
params.fluidVelocity = [0; 0]; % m/s (initial, overwritten by control)

%% --- Simulation time ---
params.dt   = 0.001;           % time step [s]
params.tEnd = 5.0;             % total simulation time [s]

%% --- Wall properties ---
params.wallY = 0;              % horizontal wall at y = 0
params.restitution = 0.8;      % coefficient of restitution
params.vStick = 0.1;           % normal velocity threshold [m/s]
params.vxStick = 0.005;        % tangential stabilization threshold

%% --- Initial conditions ---
params.initialState = [0; 0.05; 1; 0; 0; 0];
% state = [x; y; vx; vy; contact; deposited]

%% --- Gravity & friction ---
params.mu = 0.3;               % surface friction coefficient
params.g  = 9.81;              % gravity [m/s^2]

%% --- Deposition model ---
params.contactModel = "energy";
% options: "velocity", "energy"

params.depositionModel = "probabilistic";
% options: "deterministic", "probabilistic"

params.E_adh = 2.5e-9;           % base adhesion energy [J]

%% --- Spatial adhesion (Part 4C) ---
params.E_adh_low  = 1e-10;     % weak adhesion (transport region)
params.E_adh_high = 3e-9;      % strong adhesion (capture zone)

params.x_target = 1.0;         % desired capture location [m]
params.x_capture_center = params.x_target;
params.x_capture_width  = 0.03; % capture zone half-width [m]

%% --- Control selection ---
params.enableControl = true;

params.controlMode = "openloop";
% options:
% "openloop"
% "P"
% "PI"
% "PID"

%% --- Control gains ---
params.Kp = 10.0;
params.Ki = 5;
params.Kd = 5;

params.u_max = 2.0;            % actuator saturation [m/s]

%% --- Disturbance model (colored noise) ---
params.enableDisturbance = false;

params.dist_tau   = 0.2;       % correlation time [s]
params.dist_sigma = 0.3;       % disturbance intensity [m/s]

%%
params.ctrl.intError = 0;

end
