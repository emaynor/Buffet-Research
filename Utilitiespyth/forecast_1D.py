import numpy as np
from scipy.interpolate import interp1d

def forecast_1D(mu, r, lambda_, fit_type, direction):
    # amplitude range
    r_diagram = r[-1]  # Last element of r
    n_r = len(r_diagram)

    # control parameter increments
    n_mu = len(mu)

    # allocate diagram
    diagram = np.zeros((n_r, 2))
    diagram[:, 1] = r_diagram

    # allocate coefficients
    coeff = np.zeros((n_r, 3))

    # allocate interpolated recovery rates
    lambda_temp = []

    # fit recovery rates on the bifurcation diagram amplitude range
    for i in range(n_mu):
        # get data
        r_i = r[i]
        lambda_i = lambda_[i]

        # interpolate data
        interp_func = interp1d(r_i, lambda_i, kind='pchip')
        lambda_temp.append(interp_func(r_diagram))

    # loop the amplitude values
    for i in range(n_r):
        # temporary variable
        lambda_i = np.zeros(n_mu)

        # loop the mu values
        for j in range(n_mu):
            lambda_i[j] = lambda_temp[j][i]

        if fit_type == 'linear':
            # linear fitting
            p = np.polyfit(mu, lambda_i, 1)

            # get coefficients
            a2_i = 0
            a1_i = p[0]
            a0_i = p[1]

            # compute root of fitting function
            mu1_tilde = -a0_i / a1_i

        elif fit_type == 'quadratic':
            # quadratic fitting
            p = np.polyfit(mu, lambda_i, 2)

            # get coefficients
            a2_i = p[0]
            a1_i = p[1]
            a0_i = p[2]

            # compute root of fitting function
            if a1_i**2 - 4.0 * a2_i * a0_i >= 0:
                mu1_tilde = (-a1_i + direction * np.sqrt(a1_i**2 - 4.0 * a2_i * a0_i)) / (2.0 * a2_i)
            else:
                mu1_tilde = np.nan

        # store diagram
        diagram[i, 0] = mu1_tilde

        # store coefficients
        coeff[i, 0] = a0_i
        coeff[i, 1] = a1_i
        coeff[i, 2] = a2_i

    return coeff, diagram
