function state = wallInteraction(state, params)

y  = state(2);
vx = state(3);
vy = state(4);

contact = state(5);

if y <= params.wallY

    switch params.contactModel

        case "velocity"
            % --- Model A: Velocity-based sticking (reversible) ---
            if abs(vy) < params.vStick
                state(2) = params.wallY;
                state(4) = 0;
                contact  = 1;

            elseif vy < 0
                state(2) = params.wallY;
                state(4) = -params.restitution * vy;
                contact  = 1;
            end

        case "energy"

           % --- Spatially varying adhesion ---
            x = state(1);

            Eadh_local = adhesionProfile(x, params);

            En = 0.5 * params.mass * vy^2;


            if En < Eadh_local

                 if  strcmp(params.depositionModel, "probabilistic")
                       p = exp(-En / Eadh_local);
                       if rand < p
                          state(2) = params.wallY;
                          state(3) = 0;
                          state(4) = 0;
                          state(5) = 1;
                          state(6) = 1;   % deposited
                          return;
                       end

                 elseif strcmp(params.depositionModel, "deterministic")
                     % deterministic energy model
                     state(2) = params.wallY;
                     state(3) = 0;
                     state(4) = 0;
                     state(5) = 1;
                     state(6) = 1;
                     return;
                 end 

          elseif vy < 0
               state(2) = params.wallY;
               state(4) = -params.restitution * vy;
               state(5) = 1;
          end

    end

else
    contact = 0;
end

% --- Numerical stabilization (horizontal only) ---
if contact == 1 && abs(vx) < params.vxStick
    state(3) = 0;
end

state(2) = max(state(2), params.wallY);

state(5) = contact;
end
