function s_figure4

% Plot the age-dependency Poission curve for fractional anistropy (FA) along SLF I, II, and III. This script aims to reproduce Figure 4 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% This codes use functions derived from this repository (by Jason Yeatman): https://github.com/jyeatman/lifespan
%
% Hiromasa Takemura, NICT CiNet BIT

cd Data/DatasetInfo/
load DatasetInformation.mat

cd ../FAqR1_Main/

% Add path to Yeatman Lifespan code
addpath(genpath('../../Codes_YeatmanLifespanrepository'));

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

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

for k=1:6
    [sqErr{k},yhat{k},coef{k}]=nc_FitAndEvaluateModels(transpose(fa_plot(k,:)),transpose(age_plot),'poisson',1,1000);
    switch k
        case 1
            f=nc_PlotModelFits(coef{k},'fa',{'Left SLF I'},1,[.16 .68 .9]);
        case 2
            f=nc_PlotModelFits(coef{k},'fa',{'Left SLF II'},1,[.07 .07 .71]);
        case 3
            f=nc_PlotModelFits(coef{k},'fa',{'Left SLF III'},1,[.76 0 .76]);
        case 4
            f=nc_PlotModelFits(coef{k},'fa',{'Right SLF I'},1,[.16 .68 .9]);
        case 5
            f=nc_PlotModelFits(coef{k},'fa',{'Right SLF II'},1,[.07 .07 .71]);
        case 6
            f=nc_PlotModelFits(coef{k},'fa',{'Right SLF III'},1,[.76 0 .76]);
    end
end