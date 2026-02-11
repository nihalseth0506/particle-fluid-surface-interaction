function Eadh_local = adhesionProfile(x, params)
% ADHESIONPROFILE  Spatially varying adhesion energy
%
% Low adhesion in transport region
% High adhesion in capture zone around target

if abs(x - params.x_capture_center) < params.x_capture_width
    Eadh_local = params.E_adh_high;   % capture zone
else
    Eadh_local = params.E_adh_low;    % transport region
end

end
