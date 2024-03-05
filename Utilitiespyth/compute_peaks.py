import numpy as np

def compute_peaks(t, x, x_e, peak_level, peak_from_start, peak_from_end):
    # subtract equilibrium
    x = x - x_e

    # select maxima or minima
    if peak_level == 'lower':
        x = -x

    # find peaks 
    r_peaks, locs = findpeaks(x)
    t_peaks = t[locs]

    # select peaks
    r_peaks = r_peaks[peak_from_start:-peak_from_end]
    t_peaks = t_peaks[peak_from_start:-peak_from_end]

    return t_peaks, r_peaks

def findpeaks(x):
    peaks = []
    locs = []
    for i in range(1, len(x) - 1):
        if x[i] > x[i-1] and x[i] > x[i+1]:
            peaks.append(x[i])
            locs.append(i)
    return np.array(peaks), np.array(locs)
