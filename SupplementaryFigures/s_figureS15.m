function s_figureS15
% Create bar plots comparing fractional anisotropy (FA) of SLF I/II/III between male and female participants.
% This script aims to reproduce Supplementary Figure 15 and Supplementary Table 2 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/DatasetInfo/
load DatasetInformation.mat

cd ../FAqR1_Main/

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

load(FileToLoad{1});
male = find(sex.CH == 1);
female = find(sex.CH == 2);

% Calculate FA averaged from node 21 to node 80
for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
end

fa_mean(:,1,1) = mean(fa_plot(male,:),1);
fa_std(:,1,1) = std(fa_plot(male,:), 0, 1);
fa_ser(:,1,1) = fa_std(:,1,1)./sqrt(length(fa_plot(male,:)));
fa_mean(:,2,1) = mean(fa_plot(female,:),1);
fa_std(:,2,1) = std(fa_plot(female,:), 0, 1);
fa_ser(:,2,1) = fa_std(:,2,1)./sqrt(length(fa_plot(female,:)));

% Perform two-sample t-test
for i = 1:6
[~,p(i,1),~,stats{i,1}] = ttest2(fa_plot(male,i), fa_plot(female,i));
end

clear male female fa_plot all_profile

load(FileToLoad{2});
male = find(sex.ADO == 1);
female = find(sex.ADO == 2);

for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
end

fa_mean(:,1,2) = mean(fa_plot(male,:),1);
fa_std(:,1,2) = std(fa_plot(male,:), 0, 1);
fa_ser(:,1,2) = fa_std(:,1,2)./sqrt(length(fa_plot(male,:)));
fa_mean(:,2,2) = mean(fa_plot(female,:),1);
fa_std(:,2,2) = std(fa_plot(female,:), 0, 1);
fa_ser(:,2,2) = fa_std(:,2,2)./sqrt(length(fa_plot(female,:)));

% Perform two-sample t-test
for i = 1:6
[~,p(i,2),~,stats{i,2}] = ttest2(fa_plot(male,i), fa_plot(female,i));
end

clear male female fa_plot all_profile

load(FileToLoad{3});
male = find(sex.ADU == 1);
female = find(sex.ADU == 2);

for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
end

fa_mean(:,1,3) = mean(fa_plot(male,:),1);
fa_std(:,1,3) = std(fa_plot(male,:), 0, 1);
fa_ser(:,1,3) = fa_std(:,1,3)./sqrt(length(fa_plot(male,:)));
fa_mean(:,2,3) = mean(fa_plot(female,:),1);
fa_std(:,2,3) = std(fa_plot(female,:), 0, 1);
fa_ser(:,2,3) = fa_std(:,2,3)./sqrt(length(fa_plot(female,:)));

% Perform two-sample t-test
for i = 1:6
[~,p(i,3),~,stats{i,3}] = ttest2(fa_plot(male,i), fa_plot(female,i));
end

clear male female fa_plot all_profile

load(FileToLoad{4});
male = find(sex.SEN == 1);
female = find(sex.SEN == 2);

for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
end

fa_mean(:,1,4) = mean(fa_plot(male,:),1);
fa_std(:,1,4) = std(fa_plot(male,:), 0, 1);
fa_ser(:,1,4) = fa_std(:,1,4)./sqrt(length(fa_plot(male,:)));
fa_mean(:,2,4) = mean(fa_plot(female,:),1);
fa_std(:,2,4) = std(fa_plot(female,:), 0, 1);
fa_ser(:,2,4) = fa_std(:,2,4)./sqrt(length(fa_plot(female,:)));

% Perform two-sample t-test
for i = 1:6
[~,p(i,4),~,stats{i,4}] = ttest2(fa_plot(male,i), fa_plot(female,i));
end

% Summarize t-statistics
for kk = 1:6
    for jj = 1:4
      tvalue(kk,jj) = stats{kk,jj}.tstat;     
    end
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

for ng = 1:6
    subplot (3,2,ng);
    h = bar(transpose(squeeze(fa_mean(ordernum(ng),:,:))));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    h(2).FaceColor = [0.9725 0.9804 0.0510];
    hold on
    er = errorbar(transpose(squeeze(fa_mean(ordernum(ng),:,:))), transpose(squeeze(fa_ser(ordernum(ng),:,:))));
    er(1).Color = [1 0 0];
    er(1).LineStyle = 'none';
    er(1).XData = [0.86 1.86 2.86 3.86];
    er(2).Color = [1 0 0];
    er(2).LineStyle = 'none';
    er(2).XData = [1.14 2.14 3.14 4.14];
    ylim([0.35 0.55]);
    ylabel('FA');
    yticks([0.35 0.45 0.55]);
    set(gca, 'tickdir', 'out', 'box', 'off');
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    if ng ==1
        legend('Male','Female');
    else
    end
    title(groupnames(ordernum(ng)));
end