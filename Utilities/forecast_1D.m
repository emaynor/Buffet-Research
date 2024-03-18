%% This function computes a one-dimensional bifurcation diagram using forecasting.

%% Cristina Riso
%% criso@gatech.edu

function [coeff, diagram] = forecast_1D(mu,r,lambda,fit_type,direction)

% amplitude range
r_diagram = r{1,end}; n_r = length(r_diagram);

% control parameter increments
n_mu = length(mu);

% allocate diagram
diagram = zeros(n_r,2);
diagram(:,2) = r_diagram;

% allocate coefficients
coeff = zeros(n_r,3);

% allocate interpolated recovery rates
lambda_temp = cell(1,n_mu);

% fit recovery rates on the bifurcation diagram amplitude range
for i = 1:n_mu
    
    % get data 
    r_i = r{1,i}; lambda_i = lambda{1,i};
    
    % interpolate data
    lambda_temp{1,i} = interp1(r_i,lambda_i,r_diagram,'pchip');
    
end

% loop the amplitude values
for i = 1:n_r
    
    % temporary variable
    lambda_i = zeros(n_mu,1);
    
    % loop the mu values
    for j = 1:n_mu
        temp = lambda_temp{1,j};
        lambda_i(j) = temp(i);
    end
    
    switch fit_type
        
        case 'linear'
            
            % linear fitting        
            p = polyfit(mu,lambda_i,1);
            
            % get coefficients
            a2_i = 0;
            a1_i = p(1);
            a0_i = p(2);
            
            % compute root of fitting function
            mu1_tilde = -a0_i/a1_i;
            
        case 'quadratic'
            
            % quadratic fitting
            p = polyfit(mu,lambda_i,2);
            
            % get coefficients
            a2_i = p(1);
            a1_i = p(2);
            a0_i = p(3);
            
            % compute root of fitting function
            if (a1_i^2-4.0*a2_i*a0_i >= 0)
                mu1_tilde =(-a1_i+direction*sqrt(a1_i^2-4.0*a2_i*a0_i))/(2.0*a2_i);
            else
                mu1_tilde = NaN;
            end
        
    end
    
    % store diagram
    diagram(i,1) = mu1_tilde;
    
    % store coefficients
    coeff(i,1) = a0_i;
    coeff(i,2) = a1_i;
    coeff(i,3) = a2_i;
    
end