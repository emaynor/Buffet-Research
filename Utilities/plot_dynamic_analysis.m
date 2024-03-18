%% This function plots the dynamic analysis results for a selected state.

%% Cristina Riso
%% criso@gatech.edu

function [] = plot_dynamic_analysis(plot_params, dynamic_results)

% plot parameters
c2 = plot_params.c2;
output_folder = plot_params.output_folder;
save_plots = plot_params.save_plots;
plot_format = plot_params.plot_format;
state_min = plot_params.state_min;
state_max = plot_params.state_max;

% results
state_index = dynamic_results.state_index;
n_mu_dyn = dynamic_results.n_mu_dyn;
t = dynamic_results.t;
y = dynamic_results.y;
t_peaks_dyn = dynamic_results.t_peaks_dyn;
r_peaks_dyn = dynamic_results.r_peaks_dyn;

% loop responses
for i = 1:n_mu_dyn
    
    % get response
    t_i = t{1,i};
    y_i = y{1,i};
    
    % get selected state 
    dof_i = y_i(state_index,:);
    
    % get peaks if available
    t_peaks_i = t_peaks_dyn{1,i};
    r_peaks_i = r_peaks_dyn{1,i};
    
    % plot response
    fig = figure(1000+i); hold all;
    set(fig,'Position',[0 0 1200 900]);
    plot(t_i,dof_i,'k-','LineWidth',2);
    plot(t_peaks_i,r_peaks_i,'--','Color',c2,'LineWidth',2);
    
    axis([min(t_i) max(t_i) state_min state_max]);
    xticks(min(t_i):(max(t_i)-min(t_i))/4:max(t_i))
    yticks(state_min:(state_max-state_min)/6:state_max)
    xlabel('Time (-)'); ylabel('Amplitude (-)');
    ax = gca; ax.FontSize = 36;
    
    % add legend if applicable
    if i == 1
        hleg = legend('Response','Envelope');
        set(hleg,'Location','NorthWest');
    end
    
    % save response
    if save_plots == true
        filename = strcat(output_folder,'\state_',num2str(state_index),'_sim_',num2str(i),'.',plot_format);
        set(fig,'Units','Inches');
        pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(fig,filename,strcat('-d',plot_format),'-r250')
    end
    
end