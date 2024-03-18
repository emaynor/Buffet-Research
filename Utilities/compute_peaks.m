%% This function finds a time signal peaks.

%% Cristina Riso
%% criso@gatech.edu

function [t_peaks, r_peaks] = compute_peaks(t, x, x_e, peak_level, peak_from_start, peak_from_end)

% subtract equilibrium
x = x-x_e;

% select maxima or minima
if strcmp(peak_level,'lower') == 1
    x = -x;
end

% find peaks 
[r_peaks,locs] = findpeaks(x);
t_peaks = t(locs);

% select peaks
r_peaks = r_peaks(peak_from_start:end-peak_from_end);
t_peaks = t_peaks(peak_from_start:end-peak_from_end);
