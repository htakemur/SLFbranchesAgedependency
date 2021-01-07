function s_figureS16
% Create bar plots comparing quantitative R1 (qR1) of SLF I/II/III between male and female participants.
% This script aims to reproduce Supplementary Figure 16 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/FAqR1_Main/

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

load(FileToLoad{1});
male = [1:3 6:9 14 16:17];
female = [4:5 10:13 15];

% Compute averaged qR1 from node 21 to node 80
for k = 1:6
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end

qr1_mean(:,1,1) = mean(qr1_plot(male,:),1);
qr1_std(:,1,1) = std(qr1_plot(male,:), 0, 1);
qr1_ser(:,1,1) = qr1_std(:,1,1)./sqrt(length(qr1_plot(male,:)));
qr1_mean(:,2,1) = mean(qr1_plot(female,:),1);
qr1_std(:,2,1) = std(qr1_plot(female,:), 0, 1);
qr1_ser(:,2,1) = qr1_std(:,2,1)./sqrt(length(qr1_plot(female,:)));

clear male female qr1_plot all_profile

load(FileToLoad{2});
male = [1:2 4:5 8 11:12 14 16 20];
female = [3 6:7 9:10 13 15 17:19];

for k = 1:6
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end

qr1_mean(:,1,2) = mean(qr1_plot(male,:),1);
qr1_std(:,1,2) = std(qr1_plot(male,:), 0, 1);
qr1_ser(:,1,2) = qr1_std(:,1,2)./sqrt(length(qr1_plot(male,:)));
qr1_mean(:,2,2) = mean(qr1_plot(female,:),1);
qr1_std(:,2,2) = std(qr1_plot(female,:), 0, 1);
qr1_ser(:,2,2) = qr1_std(:,2,2)./sqrt(length(qr1_plot(female,:)));

clear male female qr1_plot all_profile

load(FileToLoad{3});
male = [1:3 5 7 14 16 18 21:23];
female = [4 6 8:13 15 17 19:20];

for k = 1:6
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end

qr1_mean(:,1,3) = mean(qr1_plot(male,:),1);
qr1_std(:,1,3) = std(qr1_plot(male,:), 0, 1);
qr1_ser(:,1,3) = qr1_std(:,1,3)./sqrt(length(qr1_plot(male,:)));
qr1_mean(:,2,3) = mean(qr1_plot(female,:),1);
qr1_std(:,2,3) = std(qr1_plot(female,:), 0, 1);
qr1_ser(:,2,3) = qr1_std(:,2,3)./sqrt(length(qr1_plot(female,:)));

clear male female qr1_plot all_profile

load(FileToLoad{4});
male = [1:2 5 7 9 13 15 17:19];
female = [3:4 6 8 10:12 14 16 20:22];

for k = 1:6
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end

qr1_mean(:,1,4) = mean(qr1_plot(male,:),1);
qr1_std(:,1,4) = std(qr1_plot(male,:), 0, 1);
qr1_ser(:,1,4) = qr1_std(:,1,4)./sqrt(length(qr1_plot(male,:)));
qr1_mean(:,2,4) = mean(qr1_plot(female,:),1);
qr1_std(:,2,4) = std(qr1_plot(female,:), 0, 1);
qr1_ser(:,2,4) = qr1_std(:,2,4)./sqrt(length(qr1_plot(female,:)));

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

for ng = 1:6
    subplot (3,2,ng)
    h = bar(transpose(squeeze(qr1_mean(ordernum(ng),:,:))));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    h(2).FaceColor = [0.9725 0.9804 0.0510];
    hold on
    er = errorbar(transpose(squeeze(qr1_mean(ordernum(ng),:,:))), transpose(squeeze(qr1_ser(ordernum(ng),:,:))));
    er(1).Color = [1 0 0];
    er(1).LineStyle = 'none';
    er(1).XData = [0.86 1.86 2.86 3.86];
    er(2).Color = [1 0 0];
    er(2).LineStyle = 'none';
    er(2).XData = [1.14 2.14 3.14 4.14];
    ylim([1.0 1.2])
    ylabel('qR1');
    set(gca, 'tickdir', 'out', 'box', 'off');
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    if ng ==1
        legend('Male','Female');
    else
    end
    title(groupnames(ordernum(ng)))
end