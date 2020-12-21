function s_figure3

% Plot mean and standard deviation of fractional anistropy (FA) along SLF I, II, and III in each age group. This script aims to reproduce Figure 3 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/FAqR1_Main/

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

% Load data and comppute mean/standard error
for i = 1:4
    load(FileToLoad{i});
    % Compute FA averaged among all nodes between node 21 and node 80.
    for k = 1:6
        fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
    end
    fa_mean(:,i) = mean(fa_plot,1);
    fa_std(:,i) = std(fa_plot, 0, 1);
    fa_ser(:,i) = fa_std(:,i)./sqrt(length(fa_plot));
    clear all_profile fa_plot
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

for ng = 1:6;
    subplot (3,2,ng)
    h = bar(transpose(fa_mean(ordernum(ng),:)));
    hold on
    er = errorbar(transpose(fa_mean(ordernum(ng),:)),transpose(fa_ser(ordernum(ng),:)));
    er.Color = 'red';
    er.LineStyle = 'none';
    ylim([0.35 0.55])
    ylabel('FA');
    set(gca, 'XTickLabel', {'CH','ADO','AD','SEN'}, 'fontsize', 12);
    title(groupnames(ordernum(ng)))
end