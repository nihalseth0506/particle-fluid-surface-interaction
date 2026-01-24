clear; clc; close all;

addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\core")
addpath("D:\LEARNING\Projects\particle-fluid-surface-interaction\matlab\part4_controlled_transport\controllers")

% -------------------------------------------------------------------------
% Base parameters (shared by all controllers)
% -------------------------------------------------------------------------
baseParams = parameters();
baseParams.contactModel    = "energy";
baseParams.depositionModel = "probabilistic";

% Control + capture settings
baseParams.x_target = 0.1;
baseParams.x_capture_center = baseParams.x_target;
baseParams.x_capture_width  = 0.005;

% Controller gains
baseParams.Kp = 5;
baseParams.Ki = 0.5;
baseParams.Kd = 0.5;
baseParams.u_max = 2;

% -------------------------------------------------------------------------
% Controllers to compare
% -------------------------------------------------------------------------
controlModes = ["openloop", "P", "PI", "PID"];

% -------------------------------------------------------------------------
% Loop over controllers
% -------------------------------------------------------------------------
for k = 1:length(controlModes)

    params = baseParams;
    params.controlMode = controlModes(k);

    results = runSimulation(params);

    % -------------------------------------------------------------
    % Create figure
    % -------------------------------------------------------------
    figure('Name', char(controlModes(k)), 'NumberTitle', 'off');

    % ---- 1. Trajectory (x-y) ----
    subplot(2,2,1)
    plot(results.x, results.y, 'LineWidth', 1.5)
    xlabel('x [m]')
    ylabel('y [m]')
    title('Trajectory')
    grid on

    % ---- 2. Horizontal velocity ----
    subplot(2,2,2)
    plot(results.t, results.vx, 'LineWidth', 1.5)
    xlabel('Time [s]')
    ylabel('v_x [m/s]')
    title('Horizontal Velocity')
    grid on

    % ---- 3. Horizontal position vs time ----
    subplot(2,2,3)
    plot(results.t, results.x, 'LineWidth', 1.5); hold on
    yl = yline(params.x_target, '--r', 'Target');
    yl.LabelHorizontalAlignment = 'right';
    yl.LabelVerticalAlignment   = 'bottom';
    xlabel('Time [s]')
    ylabel('x [m]')
    title('Horizontal Position')
    grid on

    % ---- 4. Deposition event ----
    subplot(2,2,4)
    stairs(results.t, results.deposited, 'LineWidth', 1.5)
    xlabel('Time [s]')
    ylabel('Deposited (0/1)')
    title('Deposition Event')
    ylim([-0.1 1.1])
    grid on

    % -------------------------------------------------------------
    % Visualization tuning for PID only
    % -------------------------------------------------------------
    if params.controlMode == "PID"

        % Zoom time window to show fast transient
        subplot(2,2,2)
        xlim([0 3])
        ylim([-0.1, 1])

        subplot(2,2,3)
        xlim([0 3])

        % Zoom around target for clarity
        ylim([0, params.x_target + 0.02])
    end

    % ---- Super title ----
    sgtitle("Control Mode: " + controlModes(k))

end
