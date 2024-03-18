%% This function computes the state matrix of the analytical test case
%% linearized about the equilibrium state.

%% Cristina Riso
%% criso@gatech.edu


function A = compute_A_lin(sys_params, mu)

% system parameters
alpha = sys_params.alpha;
omega_bar = sys_params.omega_bar;

% state matrix
A = [alpha*mu -omega_bar; omega_bar alpha*mu];

end