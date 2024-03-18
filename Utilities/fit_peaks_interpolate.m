%% This function fits peaks using interpolation. 

%% Cristina Riso
%% criso@gatech.edu

function [t_fit, r_fit] = fit_peaks_interpolate(t, r, t_min, t_max, dt, method)

% fit peaks with interpolation
t_fit = t_min:dt:t_max;
r_fit = interp1(t,r,t_fit,method);