import numpy as np
from scipy.interpolate import interp1d

def fit_peaks_interpolate(t, r, t_min, t_max, dt, method):
    # fit peaks with interpolation
    t_fit = np.arange(t_min, t_max + dt, dt)
    interpolator = interp1d(t, r, kind=method)
    r_fit = interpolator(t_fit)
    
    return t_fit, r_fit
