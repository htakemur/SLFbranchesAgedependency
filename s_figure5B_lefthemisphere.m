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

cd Data/DatasetInfo/
load DatasetInformation.mat

cd ../FAqR1_Main/
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
age_plot(1:17) = age.CH;

load(FileToLoad{2});
for k = 1:6
    fa_plot(k,18:37) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age_plot(18:37) = age.ADO;

load(FileToLoad{3});
for k = 1:6
    fa_plot(k,38:60) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age_plot(38:60) = age.ADU;

load(FileToLoad{4});
for k = 1:6
    fa_plot(k,61:82) = transpose(squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1))));
end
age_plot(61:82) = age.SEN;

% Fit the multiple linear regression to left SLF I by left SLF II and SLF III as explainatory variables
x(:,1) = transpose(fa_plot(2,:)); % Left SLF II
x(:,2) = transpose(fa_plot(3,:)); % Left SLF III

% Fit the multiple linear regression
mdl = fitlm(x,transpose(fa_plot(1,:)));

% Rsquared of the model
mdl_r2 = mdl.Rsquared.Ordinary

% Calculate FA of SLF I predicted by the model
for ik = 1:length(fa_plot)
    predict_l_slf1(ik) = mdl.Coefficients.Estimate(1) + mdl.Coefficients.Estimate(2)*x(ik,1) + mdl.Coefficients.Estimate(3)*x(ik,2);
end

% Measure residuals for left SLF 1
l_slf1_residual = fa_plot(1,:) - predict_l_slf1;

% Fit Poisson curve
[sqErr,yhat,coef]=nc_FitAndEvaluateModels(transpose(l_slf1_residual),transpose(age_plot),'poisson',1,1000);

% Plot age dependency curve
f=nc_PlotModelFits(coef,'Res_FA',{'Left SLF I'},1,[.16 .68 .9]);