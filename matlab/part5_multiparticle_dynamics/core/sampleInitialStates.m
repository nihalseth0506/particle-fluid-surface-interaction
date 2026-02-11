function states0 = sampleInitialStates(N, params)
% SAMPLEINITIALSTATES  Generate randomized initial states for N particles
%
% Output:
%   states0 : 6 x N matrix
%             each column is [x; y; vx; vy; contact; deposited]

% ----------------------------
% Initial position distribution
% ----------------------------
x0  = zeros(1, N);                         % same release x
y0  = 0.05 + 0.002 * randn(1, N);          % small height variation

% ----------------------------
% Initial velocity distribution
% ----------------------------
vx0 = 1.0 + 0.1 * randn(1, N);             % horizontal spread
vy0 = zeros(1, N);                         % released horizontally

% ----------------------------
% Contact & deposition flags
% ----------------------------
contact0   = zeros(1, N);
deposited0 = zeros(1, N);

% ----------------------------
% Assemble state matrix
% ----------------------------
states0 = [
    x0;
    y0;
    vx0;
    vy0;
    contact0;
    deposited0
];

end
