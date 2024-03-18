%% This function finds the bifurcation diagram amplitude
%% for a given signal.

%% Cristina Riso
%% criso@gatech.edu

function r_diagram = compute_diagram_amplitude(t, x, x_e, peak_level, r_min_peaks)

% get peaks
[~, r_peaks] = compute_peaks(t,x,x_e,peak_level,1,1);

% get last peak
r_diagram = r_peaks(end);

% check if below threshold
if r_diagram < r_min_peaks
    r_diagram = 0;
end