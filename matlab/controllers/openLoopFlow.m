function u = openLoopFlow(t)
% OPENLOOPFLOW  Prescribed fluid velocity (open-loop)

% Example 1: constant horizontal flow
ux = 2 * (t < 1);     % m/s
uy = 0.0;     % no vertical flow

u = [ux; uy];

end
