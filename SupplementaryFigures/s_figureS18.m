function s_figureS18
% Plot Dice Coefficient of the spatial overlap between SLF I/II and II/III.
% This script aims to reproduce Supplementary Figure 18 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

%% Load Dice Coefficient in the main analysis
cd ../Data/TractVolume_Dice/

FileToLoad{1}='CH_tractvolume_Dice_main.mat';
FileToLoad{2}='ADO_tractvolume_Dice_main.mat';
FileToLoad{3}='ADU_tractvolume_Dice_main.mat';
FileToLoad{4}='SEN_tractvolume_Dice_main.mat';

% Load data and compute summary statistics
for i = 1:4
    load(FileToLoad{i});
    tractvolume_mean_def(:,i) = mean(dice_tractoverlap,2);
    tractvolume_std_def(:,i) = std(dice_tractoverlap, 0, 2);
    tractvolume_ser_def(:,i) = tractvolume_std_def(:,i)./sqrt(length(dice_tractoverlap));
    clear dice_tractoverlap
end

%% Load Dice Coefficient in exclusive ROI analysis
FileToLoad{1}='CH_tractvolume_Dice_exclusiveROI.mat';
FileToLoad{2}='ADO_tractvolume_Dice_exclusiveROI.mat';
FileToLoad{3}='ADU_tractvolume_Dice_exclusiveROI.mat';
FileToLoad{4}='SEN_tractvolume_Dice_exclusiveROI.mat';

% Load data and compute summary statistics
for i = 1:4
    load(FileToLoad{i});
    tractvolume_mean_ex(:,i) = mean(dice_tractoverlap,2);
    tractvolume_std_ex(:,i) = std(dice_tractoverlap, 0, 2);
    tractvolume_ser_ex(:,i) = tractvolume_std_ex(:,i)./sqrt(length(dice_tractoverlap));
    clear dice_tractoverlap
end

%% Plot Dice Coefficient
groupnames = {'Left SLF I/II', 'Left SLF II/III', 'Left SLF I/III', 'Right SLF I/II', 'Right SLF II/III', 'Right SLF I/III'};
ordernum = [1 4 2 5];
for ng = 1:4
    subplot (2,2,ng);
    
    tractvolume_mean(1,:) = tractvolume_mean_def(ordernum(ng),:);
    tractvolume_mean(2,:) = tractvolume_mean_ex(ordernum(ng),:);
    tractvolume_ser(1,:) = tractvolume_ser_def(ordernum(ng),:);
    tractvolume_ser(2,:) = tractvolume_ser_ex(ordernum(ng),:);
    
    h = bar(transpose(tractvolume_mean));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    h(2).FaceColor = [0.9725 0.9804 0.0510];
    hold on
    er = errorbar(transpose(tractvolume_mean),transpose(tractvolume_ser));
    er(1).Color = [1 0 0];
    er(1).LineStyle = 'none';
    er(1).XData = [0.855 1.855 2.855 3.855];
    er(2).Color = [1 0 0];
    er(2).LineStyle = 'none';
    er(2).XData = [1.145 2.145 3.145 4.145];
    ylim([0 0.4]);
    yticks([0 0.2 0.4]);
    ylabel('Dice Coefficient');
    set(gca, 'tickdir', 'out', 'box', 'off');
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    if ng ==1
        legend('Main analysis','Exclusive ROIs');
    else
    end
    title(groupnames(ordernum(ng)));
end