function [] = convergence_plot()

figure

% Load these norms:
stats_17_use_gpu_1
stats_31_use_gpu_1
stats_50_use_gpu_1
stats_101_use_gpu_1
%stats_101_use_gpu_2
%stats_101_use_gpu_3

%allcases = [ n17_use_gpu_1, n31_use_gpu_1, n50_use_gpu_1, n101_use_gpu_1 ];
%lineTypes={'-ko', '-bs', '-rv', '-md'};
lineTypes={'-ko', '-ks', '-kv', '-kd'};
markerTypes={'r', 'y', 'g', 'm'};

plotConvergence([n17_gpu_1 n31_gpu_1 n50_gpu_1 n101_gpu_1 ], 'l2_error', lineTypes, markerTypes)

legend('n=17', 'n=31', 'n=50', 'n=101','Location','SouthWest');

ylabel('Normalized $\ell_2$ error','Interpreter', 'LaTex','FontSize', 28);
xlabel('$N$','Interpreter', 'LaTex','FontSize', 28);
set(gca,'FontSize',24)
axis([3e3, 3e4, 1e-3, 1e0]);
%axis([1e3, 3e4, 1e-3, 1e0]);
set(gcf,'Position',[100 100 700 650])
% This fills the figure window with the plot
plot_pos = get(gca,'Position')
set(gca,'Unit','normalized','Position',[0.15 0.125 0.825 0.8],'XTickLabelMode', 'auto')



end

function [] = plotConvergence(stenSize, plotField, lineType, markerType)

for stenCase=1:length(stenSize)

    lineForm=char(lineType(stenCase));
    markerForm=char(markerType(stenCase));
    data=getField(stenSize(stenCase), plotField);
    X = data(:,1); 
    Y = data(:,3);

    loglog(X, Y, lineForm, 'LineWidth', 1.25,'MarkerSize', 12, 'MarkerFace', markerForm);
   
    hold on
end 
hold off;
end

function [] = oldFun()
hold on
loglog(n31.l2norms(:,1), n31.l2norms(:,3), '-ks', 'LineWidth', 1, 'MarkerSize', 8, 'MarkerFace', 'y');
loglog(n50.l2norms(:,1), n50.l2norms(:,3), '-kv', 'LineWidth', 1, 'MarkerSize', 8, 'MarkerFace', 'g');
loglog(n101.l2norms(:,1), n101.l2norms(:,3), '-kd', 'LineWidth', 1, 'MarkerSize', 8, 'MarkerFace', 'm');
hold off; 

 end
