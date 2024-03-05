import numpy as np

def dydt(t, y, A_lin, params):
    # system parameters
    beta = params.beta
    gamma = params.gamma

    # compute linear part of state velocity
    ydot = np.dot(A_lin, y)

    # add nonlinear terms
    r_sq = y[0]**2 + y[1]**2
    ydot[0] += beta * y[0] * (r_sq) - gamma * y[0] * (r_sq)**2
    ydot[1] += beta * y[1] * (r_sq) - gamma * y[1] * (r_sq)**2

    return ydot
