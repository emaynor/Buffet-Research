%% This function plots the bifurcation diagram for a selected state.

%% Cristina Riso
%% criso@gatech.edu

function [] = plot_bifurcation_diagram(plot_params, dynamic_results)

% plot parameters
output_folder = plot_params.output_folder;
save_plots = plot_params.save_plots;
plot_format = plot_params.plot_format;
state_max = plot_params.state_max;

% results
state_index = dynamic_results.state_index;
diagram_dyn = dynamic_results.diagram_dyn;
diagram = dynamic_results.diagram;

% plot bifurcation diagram 
fig = figure(800); hold on; 
set(fig,'Position',[0 0 1200 900]);

% plot bifurcation diagram from time marching
plot(diagram_dyn(:,1),diagram_dyn(:,2),'ko','LineWidth',2,'Color','k','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',8);

% plot bifurcation diagram from forecasting
plot(diagram(:,1),diagram(:,2),'k-','LineWidth',2);

% axes parameters
axis([diagram_dyn(1,1) diagram_dyn(end,1) 0 state_max])
xlabel('Parameter (-)'); ylabel('Amplitude (-)');
ax = gca; ax.FontSize = 36;
xticks(diagram_dyn(1,1):(diagram_dyn(end,1)-diagram_dyn(1,1))/4:diagram_dyn(end,1))
yticks(0:state_max/6:state_max)

% axes legend
hleg = legend('Time marching','Forecasting');
set(hleg,'Location','NorthWest');

% save plots
if save_plots == true
    
    filename = strcat(output_folder,'\diagram_state_',num2str(state_index),'.',plot_format);
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(fig,filename,strcat('-d',plot_format),'-r250')

end