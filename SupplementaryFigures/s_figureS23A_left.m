function s_figureS23A_left

% Create a bar plot comparing adolescent subgroup analysis and main analysis on SLF tract volume.
% This script aims to reproduce the left panel of Supplementary Figure 23A in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

% Load data
cd ../Data/DatasetInfo/
load DatasetInformation.mat

cd ../TractVolume_Main/

FileToLoad{1}='ADO_tractvolume_main.mat';

% Compute summary statistics in the main analysis
load(FileToLoad{1});
tractvolume_mean(:,1) = mean(tractvolume,2);
tractvolume_std(:,1) = std(tractvolume, 0, 2);
tractvolume_ser(:,1) = tractvolume_std(:,1)./sqrt(length(tractvolume));

% Compute summary statistics in the subgroup analysis
age_subgroup = find(age.ADO > 11); % chose participants older than 11 years old
tractvolume_mean(:,2) = mean(tractvolume(:,age_subgroup),2);
tractvolume_std(:,2) = std(tractvolume(:, age_subgroup), 0, 2);
tractvolume_ser(:,2) = tractvolume_std(:,2)./sqrt(length(tractvolume(:, age_subgroup)));

% Plot results
h = bar(tractvolume_mean);
h(1).FaceColor = [0.2078 0.1647 0.5255];
h(2).FaceColor = [0.9725 0.9804 0.0510];
hold on
er = errorbar(tractvolume_mean, tractvolume_ser);
er(1).Color = [1 0 0];
er(1).LineStyle = 'none';
er(1).XData = [0.87 1.87 2.87 3.87 4.87 5.87];
er(2).Color = [1 0 0];
er(2).LineStyle = 'none';
er(2).XData = [1.13 2.13 3.13 4.13 5.13 6.13];
ylim([0 20000]);
ylabel('Tract volume (mm^3)');
ytick = [0 10000 20000];
set(gca, 'tickdir', 'out', 'box', 'off', 'ytick',ytick);
set(gca, 'XTickLabel', {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'}, 'fontsize', 12);
legend('Age 10-18','Age 12-18');