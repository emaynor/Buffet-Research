



def compute_diagram_amplitude(t, x, x_e, peak_level, r_min_peaks):
    # get peaks
    _, r_peaks = compute_peaks(t, x, x_e, peak_level, 1, 1)

    # get last peak
    r_diagram = r_peaks[-1]

    # check if below threshold
    if r_diagram < r_min_peaks:
        r_diagram = 0
    
    return r_diagram
