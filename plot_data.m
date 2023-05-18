close all; clear; clc

% load data
load('output_data_average.mat')

% parameters
num_plot = height(output_data_average);

%% plot
for plot_iter = 1:num_plot
    figure(plot_iter)
% accuracy
    subplot(2,1,1)
    plot(cell2mat(output_data_average.time_cond(plot_iter)),table2array(output_data_average.condition_accuracy{plot_iter,1})*100,'Marker','.','LineWidth',2,'MarkerSize',20)
    xlabel('Timing Offset (ms)','FontSize',20)
    xlim([-60 60])
    ylabel('Percent Correct','FontSize',20)
    ylim([0 100])
    title('Accuracy','FontSize',24,'FontWeight','normal')
% add vertical line
    line([0 0],[0 100])
    lgd = legend([cellstr(num2str(output_data_average.pitch_cond{plot_iter,1}'));cellstr('')],'Location','bestoutside','FontSize', 16,'Box','off');
    title(lgd,'pitch condition')

% long-short
    subplot(2,1,2)
    hold on
    plot(cell2mat(output_data_average.time_cond(plot_iter)),table2array(output_data_average.condition_longshort_ratio{plot_iter,1}),'Marker','.','LineWidth',2,'MarkerSize',20)
% add perfect
    y_perfect = [zeros(1,width(cell2mat(output_data_average.time_cond(plot_iter)))/2),ones(1,width(cell2mat(output_data_average.time_cond(plot_iter)))/2)];
    plot(cell2mat(output_data_average.time_cond(plot_iter)),y_perfect,'--','color',[0.5 0.5 0.5],'DisplayName','perfect');
    hold off
    xlabel('Timing Offset (ms)','FontSize',20)
    xlim([-60 60])
    ylabel('Prop Resp "Long Short"','FontSize',20)
    ylim([0 1])
    title('PSE','FontSize',24,'FontWeight','normal')
% add vertical line
    line([0 0],[0 1])
    lgd = legend([cellstr(num2str(output_data_average.pitch_cond{plot_iter,1}'));cellstr('perfect');cellstr('')],'Location','bestoutside','FontSize', 16,'Box','off');
    title(lgd,'pitch condition')
end