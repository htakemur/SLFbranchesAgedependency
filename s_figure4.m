function s_figure4

% Plot the age-dependency Poission curve for fractional anistropy (FA) along SLF I, II, and III. This script aims to reproduce Figure 4 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% This codes use functions derived from this repository (by Jason Yeatman): https://github.com/jyeatman/lifespan
%
% Hiromasa Takemura, NICT CiNet BIT

cd Data/FAqR1_Main/

addpath(genpath('../Codes_YeatmanLifespanrepository'));

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

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

for k=1:6
    [sqErr{k},yhat{k},coef{k}]=nc_FitAndEvaluateModels(transpose(fa_plot(k,:)),transpose(age),'poisson',1,1000);
    switch k
        case 1,
            f=nc_PlotModelFits(coef{k},'fa',{'Left SLF I'},1,[.16 .68 .9]);
        case 2,
            f=nc_PlotModelFits(coef{k},'fa',{'Left SLF II'},1,[.07 .07 .71]);
        case 3,
            f=nc_PlotModelFits(coef{k},'fa',{'Left SLF III'},1,[.76 0 .76]);
        case 4,
            f=nc_PlotModelFits(coef{k},'fa',{'Right SLF I'},1,[.16 .68 .9]);
        case 5,
            f=nc_PlotModelFits(coef{k},'fa',{'Right SLF II'},1,[.07 .07 .71]);
        case 6,
            f=nc_PlotModelFits(coef{k},'fa',{'Right SLF III'},1,[.76 0 .76]);
    end
end

