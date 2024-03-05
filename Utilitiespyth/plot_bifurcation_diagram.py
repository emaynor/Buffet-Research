import matplotlib.pyplot as plt
import numpy as np

def plot_bifurcation_diagram(plot_params, dynamic_results):
    # plot parameters
    output_folder = plot_params['output_folder']
    save_plots = plot_params['save_plots']
    plot_format = plot_params['plot_format']
    state_max = plot_params['state_max']

    # results
    state_index = dynamic_results['state_index']
    diagram_dyn = dynamic_results['diagram_dyn']
    diagram = dynamic_results['diagram']

    # plot bifurcation diagram
    fig = plt.figure(800, figsize=(15, 10))
    plt.plot(diagram_dyn[:, 0], diagram_dyn[:, 1], 'ko', linewidth=2, markersize=8, label='Time marching')
    plt.plot(diagram[:, 0], diagram[:, 1], 'k-', linewidth=2, label='Forecasting')

    # axes parameters
    plt.xlabel('Parameter (-)')
    plt.ylabel('Amplitude (-)')
    plt.axis([diagram_dyn[0, 0], diagram_dyn[-1, 0], 0, state_max])
    plt.xticks(np.arange(diagram_dyn[0, 0], diagram_dyn[-1, 0], (diagram_dyn[-1, 0] - diagram_dyn[0, 0]) / 4))
    plt.yticks(np.arange(0, state_max, state_max / 6))
    plt.legend(loc='upper left', fontsize=14)
    plt.grid(True)

    # save plots
    if save_plots:
        filename = f"{output_folder}/diagram_state_{state_index}.{plot_format}"
        plt.savefig(filename, format=plot_format, dpi=250)

    plt.show()
