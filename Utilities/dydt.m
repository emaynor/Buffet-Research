%% This function computes the state velocity for the analytical test case using 
%% the Cartesian form of the equations.

%% Cristina Riso
%% criso@gatech.edu

function ydot = dydt(~,y,A_lin,params)

% system parameters
beta = params.beta;
gamma = params.gamma;

% compute linear part of state velocity
ydot = A_lin*y;

% add nonlinear terms
ydot(1) = ydot(1)+beta*y(1)*(y(1)^2+y(2)^2)-gamma*y(1)*(y(1)^2+y(2)^2)^2;
ydot(2) = ydot(2)+beta*y(2)*(y(1)^2+y(2)^2)-gamma*y(2)*(y(1)^2+y(2)^2)^2;