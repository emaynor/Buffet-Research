%% This function computes recovery rates from time outputs using finite differences.

%% Cristina Riso
%% criso@gatech.edu

function [t_out, r_out, lambda] = compute_recovery_rate_FD(t_in, r_in, r_min, order)

% set time outputs
t = t_in;
r = r_in;

% number of time outputs
n_t = length(r);

% allocate vectors to store processed time outputs
t_out = zeros(n_t-order,1);
r_out = zeros(n_t-order,1);

% allocate vector to store recovery rates
lambda = zeros(n_t-order,1);

% initialize counter
k = 1;

% loop the time outputs
for j = order:n_t-order
    
    % break when r is below a threshold   
    if r(j) < r_min
        break;
    end
    
    % compute r_dot 
    switch order
        case 2
            % this applies to variable time step
            r_dot_j = (r(j+1)-r(j-1))/(t(j+1)-t(j-1));
        case 4
            % this applies to uniform time step
            r_dot_j = (-r(j+2)+8*r(j+1)-8*r(j-1)+r(j-2))/(12*(t(j+1)-t(j)));        
    end
    
    % compute recovery rate 
    lambda_j = r_dot_j/r(j);

    % store time
    t_out(k) = t(j);
    
    % store amplitude
    r_out(k) = r(j);
    
    % store recovery rate
    lambda(k) = lambda_j;
    
    % increment counter
    k = k+1;
    
end

% delete extra elements
t_out(k:end) = [];
r_out(k:end) = [];
lambda(k:end) = [];