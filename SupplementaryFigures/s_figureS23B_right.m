function s_figureS23B_right

% Create a bar plot comparing senior subgroup analysis and main analysis on SLF quantitative R1 (qR1).
% This script aims to reproduce the right panel of Supplementary Figure 23B in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/FAqR1_Main/

FileToLoad{1}='SEN_FAqR1_main.mat';

% Calculate summary statistics in each subgroups
load(FileToLoad{1});
group_1 = [1 4:6 14 16:21];
group_2 = [2:3 7:13 15 22];
for k = 1:6
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end

qr1_mean(:,1) = mean(qr1_plot(group_1,:),1);
qr1_std(:,1) = std(qr1_plot(group_1,:), 0, 1);
qr1_ser(:,1) = qr1_std(:,1)./sqrt(length(qr1_plot(group_1,:)));

qr1_mean(:,2) = mean(qr1_plot(group_2,:),1);
qr1_std(:,2) = std(qr1_plot(group_2,:), 0, 1);
qr1_ser(:,2) = qr1_std(:,2)./sqrt(length(qr1_plot(group_2,:)));

% Plot Results
h = bar(qr1_mean);
h(1).FaceColor = [0.2078 0.1647 0.5255];
h(2).FaceColor = [0.9725 0.9804 0.0510];
hold on
er = errorbar(qr1_mean, qr1_ser);
er(1).Color = [1 0 0];
er(1).LineStyle = 'none';
er(1).XData = [0.87 1.87 2.87 3.87 4.87 5.87];
er(2).Color = [1 0 0];
er(2).LineStyle = 'none';
er(2).XData = [1.13 2.13 3.13 4.13 5.13 6.13];
ylim([1.0 1.2])
ylabel('qR1');
ytick = [1.0 1.1 1.2];
set(gca, 'tickdir', 'out', 'box', 'off', 'ytick',ytick);
set(gca, 'XTickLabel', {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'}, 'fontsize', 12);
legend('Age 55-62','Age 64-81');