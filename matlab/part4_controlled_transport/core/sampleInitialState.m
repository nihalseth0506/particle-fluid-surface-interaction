function state0 = sampleInitialState()
% SAMPLEINITIALSTATE  Generate randomized initial particle state

x0  = 0;                           % release position
y0  = 0.01 + 0.002*randn;          % small height variation
vx0 = 1.0 + 0.1*randn;             % velocity spread
vy0 = 0;                           % released horizontally

state0 = [x0; y0; vx0; vy0; 0; 0];
end
