function s_figureS21

% Plot mean and standard deviation of quantitative R1 (qR1) of SLF I, II, and III in each age group, estimated by using exclusive ROIs.
% This script aims to reproduce Supplementary Figure 21 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% Hiromasa Takemura, NICT CiNet BIT

addpath(genpath('..'));

cd ../Data/FAqR1_ExclusiveROI/

FileToLoad{1}='CH_FAqR1_exclusiveROI.mat';
FileToLoad{2}='ADO_FAqR1_exclusiveROI.mat';
FileToLoad{3}='ADU_FAqR1_exclusiveROI.mat';
FileToLoad{4}='SEN_FAqR1_exclusiveROI.mat';

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
    
    % Compute d-prime and perform paired t-test
    [d(i,1)] = s_computedprime(qr1_plot(:,4), qr1_plot(:,1));
    [d(i,2)] = s_computedprime(qr1_plot(:,5), qr1_plot(:,2));
    [d(i,3)] = s_computedprime(qr1_plot(:,6), qr1_plot(:,3));
    [~,p(i,1)] = ttest(qr1_plot(:,4), qr1_plot(:,1));
    [~,p(i,2)] = ttest(qr1_plot(:,5), qr1_plot(:,2));
    [~,p(i,3)] = ttest(qr1_plot(:,6), qr1_plot(:,3));
    clear all_profile qr1_plot
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

% Create bar plot
for ng = 1:6
    subplot (3,2,ng);
    h = bar(transpose(qr1_mean(ordernum(ng),:)));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    hold on
    er = errorbar(transpose(qr1_mean(ordernum(ng),:)),transpose(qr1_ser(ordernum(ng),:)));
    er.Color = 'red';
    er.LineStyle = 'none';
    ylim([1.0 1.2]);
    ylabel('qR1');
    yticks([1.0 1.1 1.2]);
    set(gca, 'tickdir', 'out', 'box', 'off');    
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    title(groupnames(ordernum(ng)));
end