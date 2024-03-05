import numpy as np

def compute_recovery_rate_FD(t_in, r_in, r_min, order):
    # set time outputs
    t = t_in
    r = r_in

    # number of time outputs
    n_t = len(r)

    # allocate vectors to store processed time outputs
    t_out = np.zeros(n_t - order)
    r_out = np.zeros(n_t - order)

    # allocate vector to store recovery rates
    lambda_ = np.zeros(n_t - order)

    # initialize counter
    k = 0

    # loop the time outputs
    for j in range(order, n_t - order):
        # break when r is below a threshold   
        if r[j] < r_min:
            break

        # compute r_dot 
        if order == 2:
            # this applies to variable time step
            r_dot_j = (r[j + 1] - r[j - 1]) / (t[j + 1] - t[j - 1])
        elif order == 4:
            # this applies to uniform time step
            r_dot_j = (-r[j + 2] + 8 * r[j + 1] - 8 * r[j - 1] + r[j - 2]) / (12 * (t[j + 1] - t[j]))

        # compute recovery rate 
        lambda_j = r_dot_j / r[j]

        # store time
        t_out[k] = t[j]

        # store amplitude
        r_out[k] = r[j]

        # store recovery rate
        lambda_[k] = lambda_j

        # increment counter
        k += 1

    # delete extra elements
    t_out = t_out[:k]
    r_out = r_out[:k]
    lambda_ = lambda_[:k]

    return t_out, r_out, lambda_
