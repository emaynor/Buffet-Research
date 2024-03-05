import matplotlib.pyplot as plt
import numpy as np

def plot_dynamic_analysis(plot_params, dynamic_results):
    # plot parameters
    c2 = plot_params['c2']
    output_folder = plot_params['output_folder']
    save_plots = plot_params['save_plots']
    plot_format = plot_params['plot_format']
    state_min = plot_params['state_min']
    state_max = plot_params['state_max']

    # results
    state_index = dynamic_results['state_index']
    n_mu_dyn = dynamic_results['n_mu_dyn']
    t = dynamic_results['t']
    y = dynamic_results['y']
    t_peaks_dyn = dynamic_results['t_peaks_dyn']
    r_peaks_dyn = dynamic_results['r_peaks_dyn']

    # loop responses
    for i in range(n_mu_dyn):
        # get response
        t_i = t[i]
        y_i = y[i]

        # get selected state
        dof_i = y_i[state_index, :]

        # get peaks if available
        t_peaks_i = t_peaks_dyn[i]
        r_peaks_i = r_peaks_dyn[i]

        # plot response
        fig = plt.figure(1000 + i, figsize=(15, 10))
        plt.plot(t_i, dof_i, 'k-', linewidth=2, label='Response')
        if t_peaks_i and r_peaks_i:  # Check if peaks are available
            plt.plot(t_peaks_i, r_peaks_i, '--', color=c2, linewidth=2, label='Envelope')

        plt.axis([min(t_i), max(t_i), state_min, state_max])
        plt.xticks(np.arange(min(t_i), max(t_i), (max(t_i) - min(t_i)) / 4))
        plt.yticks(np.arange(state_min, state_max, (state_max - state_min) / 6))
        plt.xlabel('Time (-)')
        plt.ylabel('Amplitude (-)')
        plt.legend(loc='upper left', fontsize=14)
        plt.grid(True)

        # save response
        if save_plots:
            filename = f"{output_folder}/state_{state_index}_sim_{i}.{plot_format}"
            plt.savefig(filename, format=plot_format, dpi=250)

    plt.show()
