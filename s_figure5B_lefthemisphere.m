function s_figure5B_lefthemisphere

% Perform multiple linear regression analysis on FA along the left SLF I, by excluding the variance of the FA along the SLF I and II, and then plot the age-dependency curve of residual FA. This script aims to reproduce the left panel of Figure 5B in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% This codes use functions derived from this repository (by Jason Yeatman): https://github.com/jyeatman/lifespan
%
% This code has dependency on MATLAB Statistics and Machine Learning Toolbox.
%
% Hiromasa Takemura, NICT CiNet BIT

cd Data/FAqR1_Main/
addpath(genpath('../../Codes_YeatmanLifespanrepository'));

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

% Age of participants
age(1:17) = [9 7 9 8 8 8 6 9 8 9 9 8 9 9 8 9 9];
age(18:37) = [18 12 13 12 12 11 14 11 11 14 10 14 11 16 15 10 13 18 17 17];
age(38:60) = [31 29 39 24 21 29 31 28 20 21 20 32 21 24 32 24 43 44 50 47 47 40 50];
age(61:82) = [60 75 67 62 62 55 66 70 70 76 68 68 81 56 79 61 58 55 58 55 61 64];

groupnames = {'Left SLF I'};


% Fit Poisson curve
[sqErr,yhat,coef]=nc_FitAndEvaluateModels(transpose(l_slf1_residual),transpose(age),'poisson',1,1000);

% Plot age dependency curve
f=nc_PlotModelFits(coef,'Res_FA',{'Left SLF I'},1,[.16 .68 .9]);



