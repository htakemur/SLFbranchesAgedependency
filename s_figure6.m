function s_figure6

% Plot mean and standard deviation of quantitative R1 (qR1) of SLF I, II, and III in each age group.
% This script aims to reproduce Figure 6 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% Hiromasa Takemura, NICT CiNet BIT

cd Data/FAqR1_Main/

% Path to the data file
FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

% Load data and comppute mean/standard error
for i = 1:4
    load(FileToLoad{i});
    % Compute qR1 (inverse of qT1) averaged among all nodes between node 21 and node 80.
    for k = 1:6
        qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
    end
    qr1_mean(:,i) = mean(qr1_plot,1);
    qr1_std(:,i) = std(qr1_plot, 0, 1);
    qr1_ser(:,i) = qr1_std(:,i)./sqrt(length(qr1_plot));
    clear all_profile qr1_plot
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

% Create bar plot
for ng = 1:6
    subplot (3,2,ng)
    h = bar(transpose(qr1_mean(ordernum(ng),:)));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    hold on
    er = errorbar(transpose(qr1_mean(ordernum(ng),:)),transpose(qr1_ser(ordernum(ng),:)));
    er.Color = 'red';
    er.LineStyle = 'none';
    ylim([1.0 1.2])
    ylabel('qR1');
    yticks([1.0 1.1 1.2]);
    set(gca, 'tickdir', 'out', 'box', 'off');
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    title(groupnames(ordernum(ng)))
end