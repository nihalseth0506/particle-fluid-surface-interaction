function params = parameters()
% PARAMETERS  Define physical and simulation parameters

% Particle properties
params.mass = 1e-6;            % kg
params.dragCoeff = 1e-5;       % drag coefficient

% Environment
params.fluidVelocity = [0.0; 0.0]; % m/s (still fluid for now)

% Simulation time
params.dt = 0.001;             % time step
params.tEnd = 2.0;             % total simulation time

% Wall properties
params.wallY = 0;              % horizontal wall at y = 0
params.restitution = 0.8;      % coefficient of restitution
params.vStick = 0.1;           % [m/s] sticking threshold
params.vxStick = 0.005;

% Initial conditions
params.initialState = [0; 0.01; 1; 0; 0; 0]; 
% state = [x; y; vx; vy; contact; deposited]

params.mu = 0.3;      % surface friction coefficient
params.g  = 9.81;     % gravity (already used implicitly)

% --- Deposition model ---
params.E_adh = 1e-8;    % adhesion energy threshold [J]
%params.deposited = 0;   % deposition flag

params.contactModel = "velocity"; 
% options: "velocity", "energy"

end
