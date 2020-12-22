function s_figure5A_lefthemisphere

% Perform multiple linear regression analysis on FA along the left SLF I, by excluding the variance of the FA along the SLF I and II. The plot the residual FA in each group as a bar plot. This script aims to reproduce the left panel of Figure 5A in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% This code has dependency on MATLAB Statistics and Machine Learning Toolbox.
%
% Hiromasa Takemura, NICT CiNet BIT

cd Data/FAqR1_Main/

% Path to the data file
FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

% Load data and average FA between nodes 21 and 80
load(FileToLoad{1});
for k = 1:6
    fa_plot(k,1:17) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age(1:17) = [9 7 9 8 8 8 6 9 8 9 9 8 9 9 8 9 9];

load(FileToLoad{2});
for k = 1:6
    fa_plot(k,18:37) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age(18:37) = [18 12 13 12 12 11 14 11 11 14 10 14 11 16 15 10 13 18 17 17];

load(FileToLoad{3});
for k = 1:6
    fa_plot(k,38:60) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age(38:60) = [31 29 39 24 21 29 31 28 20 21 20 32 21 24 32 24 43 44 50 47 47 40 50];

load(FileToLoad{4});
for k = 1:6
    fa_plot(k,61:82) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age(61:82) = [60 75 67 62 62 55 66 70 70 76 68 68 81 56 79 61 58 55 58 55 61 64];

% Fit the multiple linear regression to left SLF I by left SLF II and SLF III as explainatory variables
x(:,1) = transpose(fa_plot(2,:)); % Left SLF II
x(:,2) = transpose(fa_plot(3,:)); % Left SLF III

% Fit the multiple linear regression
mdl = fitlm(x,transpose(fa_plot(1,:)));

% Calculate FA of SLF I predicted by the model
for ik = 1:length(fa_plot)
    predict_l_slf1(ik) = mdl.Coefficients.Estimate(1) + mdl.Coefficients.Estimate(2)*x(ik,1) + mdl.Coefficients.Estimate(3)*x(ik,2);
end

% Measure residuals for left SLF 1
l_slf1_residual = fa_plot(1,:) - predict_l_slf1;

% Divide Left SLF I residual into age group for plots, and calculate mean and standard error
l_slf1_residual_group_mean(1) = mean(l_slf1_residual(1:17));
l_slf1_residual_group_mean(2) = mean(l_slf1_residual(18:37));
l_slf1_residual_group_mean(3) = mean(l_slf1_residual(38:60));
l_slf1_residual_group_mean(4) = mean(l_slf1_residual(61:82));
l_slf1_residual_group_ser(1) = std(l_slf1_residual(1:17),0,2)./sqrt(17);
l_slf1_residual_group_ser(2) = std(l_slf1_residual(18:37),0,2)./sqrt(20);
l_slf1_residual_group_ser(3) = std(l_slf1_residual(38:60),0,2)./sqrt(23);
l_slf1_residual_group_ser(4) = std(l_slf1_residual(61:82),0,2)./sqrt(22);

% Define Y ticks
ytick = [-0.05 0 0.05];%degree

% Plot results
h = bar(l_slf1_residual_group_mean);
hold on
er = errorbar(l_slf1_residual_group_mean,l_slf1_residual_group_ser);
er.Color = 'red';
er.LineStyle = 'none';
ylim([-0.05 0.05])
ylabel('Residual FA');
set(gca, 'tickdir', 'out', 'box', 'off', 'ytick',ytick);
set(gca, 'XTickLabel', {'CH','ADO','AD','EL'}, 'fontsize', 12);
