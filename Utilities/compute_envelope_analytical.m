%% This function computes the analytical envelope of the analytical test case response.

%% Cristina Riso
%% criso@gatech.edu

function [t_peaks, r_peaks] = compute_envelope_analytical(t, x, x_e)

% subtract equilibrium
x = x-x_e;

% output time
t_peaks = t;

% output amplitude
r_peaks = sqrt(x(1,:).^2+x(2,:).^2);