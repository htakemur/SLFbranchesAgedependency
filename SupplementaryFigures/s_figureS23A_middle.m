function s_figureS23A_middle

% Create a bar plot comparing adolescent subgroup analysis and main analysis on SLF fractional anisotropy (FA).
% This script aims to reproduce the middle panel of Supplementary Figure 23A in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% Hiromasa Takemura, NICT CiNet BIT

% Load data
cd ../Data/DatasetInfo/
load DatasetInformation.mat

cd ../FAqR1_Main/

FileToLoad{1}='ADO_FAqR1_main.mat';

% Load data
load(FileToLoad{1});
for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
end

% Compute summary statistics in the main analysis
fa_mean(:,1) = mean(fa_plot,1);
fa_std(:,1) = std(fa_plot, 0, 1);
fa_ser(:,1) = fa_std(:,1)./sqrt(length(fa_plot));

% Compute summary statistics in the subgroups
age_subgroup = find(age.ADO > 11); % chose participants older than 11 years old
fa_mean(:,2) = mean(fa_plot(age_subgroup,:),1);
fa_std(:,2) = std(fa_plot(age_subgroup,:), 0, 1);
fa_ser(:,2) = fa_std(:,2)./sqrt(length(fa_plot(age_subgroup,:)));

% Plot results
h = bar(fa_mean);
h(1).FaceColor = [0.2078 0.1647 0.5255];
h(2).FaceColor = [0.9725 0.9804 0.0510];
hold on
er = errorbar(fa_mean, fa_ser);
er(1).Color = [1 0 0];
er(1).LineStyle = 'none';
er(1).XData = [0.87 1.87 2.87 3.87 4.87 5.87];
er(2).Color = [1 0 0];
er(2).LineStyle = 'none';
er(2).XData = [1.13 2.13 3.13 4.13 5.13 6.13];
ylim([0.35 0.55])
ylabel('FA');
ytick = [0.35 0.4 0.45 0.5 0.55];
set(gca, 'tickdir', 'out', 'box', 'off', 'ytick',ytick);
set(gca, 'XTickLabel', {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'}, 'fontsize', 12);
legend('Age 10-18','Age 12-18');