function s_figureS22_left

% Plot mean and standard deviation of the lateralization index of SLF I, II, and III volume in each age group by using exclusive ROIs. 
% This script aims to reproduce the left panel of Supplementary Figure 22 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/TractVolume_ExclusiveROI/

FileToLoad{1}='CH_tractvolume_exclusiveROI.mat';
FileToLoad{2}='ADO_tractvolume_exclusiveROI.mat';
FileToLoad{3}='ADU_tractvolume_exclusiveROI.mat';
FileToLoad{4}='SEN_tractvolume_exclusiveROI.mat';

for i = 1:4
    % Load data
    load(FileToLoad{i});
    
    % Compute lateralization index
    SLFI_LI = squeeze((tractvolume(4,:) - tractvolume(1,:))./(tractvolume(1,:) + tractvolume(4,:)))';
    SLFII_LI = squeeze((tractvolume(5,:) - tractvolume(2,:))./(tractvolume(2,:) + tractvolume(5,:)))';
    SLFIII_LI = squeeze((tractvolume(6,:) - tractvolume(3,:))./(tractvolume(3,:) + tractvolume(6,:)))';
    
    % Compute summary statistics of LI
    SLF_LI_mean(1,i) = mean(SLFI_LI);
    SLF_LI_mean(2,i) = mean(SLFII_LI);
    SLF_LI_mean(3,i) = mean(SLFIII_LI);
    SLF_LI_std(1,i) = std(SLFI_LI);
    SLF_LI_std(2,i) = std(SLFII_LI);
    SLF_LI_std(3,i) = std(SLFIII_LI);
    SLF_LI_ser(1,i) = SLF_LI_std(1,i)./sqrt(length(SLFI_LI));
    SLF_LI_ser(2,i) = SLF_LI_std(2,i)./sqrt(length(SLFII_LI));
    SLF_LI_ser(3,i) = SLF_LI_std(3,i)./sqrt(length(SLFIII_LI));
end

% Get Screen Size
screensize = get(0, 'ScreenSize');

groupnames = {'CH','ADO','ADU','SEN'};
for ng = 1:4
    subplot (4,1,ng)
    b = bar(SLF_LI_mean(:,ng));
    b.FaceColor = 'flat';
    b.CData(1,:) = [.16 .68 .9];
    b.CData(2,:) = [.07 .07 .71];
    b.CData(3,:) = [.76 0 .76];
    hold on
    er = errorbar(1:3,SLF_LI_mean(:,ng),SLF_LI_ser(:,ng));
    er.Color = [0 0 0];
    er.LineStyle = 'none';
    ylim([-0.5,0.5])
    view(90,90)
    set(gca,'tickdir','out','box','off');
    set(gca, 'XTickLabel', {'SLF I','SLF II', 'SLF III'}, 'fontsize', 12);
    title (groupnames(ng))
    pbaspect([3 4 1])
end
set(gcf, 'Position', [1 1 screensize(3)*0.2 screensize(4)*0.8])
