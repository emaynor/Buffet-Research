import numpy as np

def compute_envelope_analytical(t, x, x_e):
    # subtract equilibrium
    x = x - x_e

    # output time
    t_peaks = t

    # output amplitude
    r_peaks = np.sqrt(x[0,:]**2 + x[1,:]**2)

    return t_peaks, r_peaks
