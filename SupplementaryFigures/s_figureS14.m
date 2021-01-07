function s_figureS14
% Create bar plots comparing tract volume of SLF I/II/III between male and female participants.
% This script aims to reproduce Supplementary Figure 14 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/TractVolume_Main/

FileToLoad{1}='CH_tractvolume_main.mat';
FileToLoad{2}='ADO_tractvolume_main.mat';
FileToLoad{3}='ADU_tractvolume_main.mat';
FileToLoad{4}='SEN_tractvolume_main.mat';

load(FileToLoad{1});
male = [1:3 6:9 14 16:17];
female = [4:5 10:13 15];

% Compute summary statistics for male and female groups
tractvolume_mean(:,1,1) = mean(tractvolume(:, male),2);
tractvolume_std(:,1,1) = std(tractvolume(:, male), 0, 2);
tractvolume_ser(:,1,1) = tractvolume_std(:,1,1)./sqrt(length(tractvolume(:, male)));
tractvolume_mean(:,2,1) = mean(tractvolume(:, female),2);
tractvolume_std(:,2,1) = std(tractvolume(:, female), 0, 2);
tractvolume_ser(:,2,1) = tractvolume_std(:,2,1)./sqrt(length(tractvolume(:, female)));

clear male female

load(FileToLoad{2});
male = [1:2 4:5 8 11:12 14 16 20];
female = [3 6:7 9:10 13 15 17:19];

tractvolume_mean(:,1,2) = mean(tractvolume(:, male),2);
tractvolume_std(:,1,2) = std(tractvolume(:, male), 0, 2);
tractvolume_ser(:,1,2) = tractvolume_std(:,1,2)./sqrt(length(tractvolume(:, male)));
tractvolume_mean(:,2,2) = mean(tractvolume(:, female),2);
tractvolume_std(:,2,2) = std(tractvolume(:, female), 0, 2);
tractvolume_ser(:,2,2) = tractvolume_std(:,2,2)./sqrt(length(tractvolume(:, female)));

clear male female

load(FileToLoad{3});
male = [1:3 5 7 14 16 18 21:23];
female = [4 6 8:13 15 17 19:20];

tractvolume_mean(:,1,3) = mean(tractvolume(:, male),2);
tractvolume_std(:,1,3) = std(tractvolume(:, male), 0, 2);
tractvolume_ser(:,1,3) = tractvolume_std(:,1,3)./sqrt(length(tractvolume(:, male)));
tractvolume_mean(:,2,3) = mean(tractvolume(:, female),2);
tractvolume_std(:,2,3) = std(tractvolume(:, female), 0, 2);
tractvolume_ser(:,2,3) = tractvolume_std(:,2,3)./sqrt(length(tractvolume(:, female)));

clear male female

load(FileToLoad{4});
male = [1:2 5 7 9 13 15 17:19];
female = [3:4 6 8 10:12 14 16 20:22];

tractvolume_mean(:,1,4) = mean(tractvolume(:, male),2);
tractvolume_std(:,1,4) = std(tractvolume(:, male), 0, 2);
tractvolume_ser(:,1,4) = tractvolume_std(:,1,4)./sqrt(length(tractvolume(:, male)));
tractvolume_mean(:,2,4) = mean(tractvolume(:, female),2);
tractvolume_std(:,2,4) = std(tractvolume(:, female), 0, 2);
tractvolume_ser(:,2,4) = tractvolume_std(:,2,4)./sqrt(length(tractvolume(:, female)));

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

for ng = 1:6
    subplot (3,2,ng)
    h = bar(transpose(squeeze(tractvolume_mean(ordernum(ng),:,:))));
    hold on
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    h(2).FaceColor = [0.9725 0.9804 0.0510];
    er = errorbar(transpose(squeeze(tractvolume_mean(ordernum(ng),:,:))), transpose(squeeze(tractvolume_ser(ordernum(ng),:,:))));
    er(1).Color = [0 0 0];
    er(1).LineStyle = 'none';
    er(1).XData = [0.86 1.86 2.86 3.86];
    er(2).Color = [0 0 0];
    er(2).LineStyle = 'none';
    er(2).XData = [1.14 2.14 3.14 4.14];
    ylim([0 20000]);
    ylabel('Tract volume (mm^3)');
    ytick = [0 10000 20000];
    set(gca, 'tickdir', 'out', 'box', 'off', 'ytick',ytick);
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    if ng ==1
        legend('Male','Female');
    else
    end
    title(groupnames(ordernum(ng)))
end