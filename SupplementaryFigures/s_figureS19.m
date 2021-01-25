function s_figureS19

% Plot mean and standard deviation of volumes of SLF I, II, and III in each age group, estimated by using exclusive ROIs.
% This script aims to reproduce Supplementary Figure 19 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

addpath(genpath('..'));

cd ../Data/TractVolume_ExclusiveROI/

FileToLoad{1}='CH_tractvolume_exclusiveROI.mat';
FileToLoad{2}='ADO_tractvolume_exclusiveROI.mat';
FileToLoad{3}='ADU_tractvolume_exclusiveROI.mat';
FileToLoad{4}='SEN_tractvolume_exclusiveROI.mat';

% Load data and comppute mean/standard error
for i = 1:4
    load(FileToLoad{i});
    tractvolume_mean(:,i) = mean(tractvolume,2);
    tractvolume_std(:,i) = std(tractvolume, 0, 2);
    tractvolume_ser(:,i) = tractvolume_std(:,i)./sqrt(length(tractvolume));
    
    % Compute d-prima and perform paired t-test
    [d(i,1)] = s_computedprime(tractvolume(4,:), tractvolume(1,:));
    [d(i,2)] = s_computedprime(tractvolume(5,:), tractvolume(2,:));
    [d(i,3)] = s_computedprime(tractvolume(6,:), tractvolume(3,:));
    [~,p(i,1)] = ttest(tractvolume(4,:), tractvolume(1,:));
    [~,p(i,2)] = ttest(tractvolume(5,:), tractvolume(2,:));
    [~,p(i,3)] = ttest(tractvolume(6,:), tractvolume(3,:));
    clear tractvolume
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

% Plot results
for ng = 1:6
    subplot (3,2,ng);
    h = bar(transpose(tractvolume_mean(ordernum(ng),:)));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    hold on
    er = errorbar(transpose(tractvolume_mean(ordernum(ng),:)),transpose(tractvolume_ser(ordernum(ng),:)));
    er.Color = 'red';
    er.LineStyle = 'none';
    ylim([0 20000]);
    yticks([0 10000 20000]);
    ylabel('Tract volume (mm^3)');
    set(gca, 'tickdir', 'out', 'box', 'off');
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    title(groupnames(ordernum(ng)));
end