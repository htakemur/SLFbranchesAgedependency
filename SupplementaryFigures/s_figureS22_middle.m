function s_figureS22_middle

% Plot mean and standard deviation of the lateralization index of SLF I, II, and III FA in each age group, by using exclusive ROIs. 
% This script aims to reproduce the middle panel of Supplementary Figure 22 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/FAqR1_ExclusiveROI/

FileToLoad{1}='CH_FAqR1_exclusiveROI.mat';
FileToLoad{2}='ADO_FAqR1_exclusiveROI.mat';
FileToLoad{3}='ADU_FAqR1_exclusiveROI.mat';
FileToLoad{4}='SEN_FAqR1_exclusiveROI.mat';

for i = 1:4
    % Load data
    load(FileToLoad{i});
    
    % Compute FA averaged from node 21 to node 80
    for k = 1:6
        fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
    end
    
    % Compute lateralization index
    SLFI_LI = squeeze(((fa_plot(:,4) - fa_plot(:,1))./(fa_plot(:,4) + fa_plot(:,1))));
    SLFII_LI = squeeze(((fa_plot(:,5) - fa_plot(:,2))./(fa_plot(:,5) + fa_plot(:,2))));
    SLFIII_LI = squeeze(((fa_plot(:,6) - fa_plot(:,3))./(fa_plot(:,6) + fa_plot(:,3))));

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
    clear fa_plot
end

% Get Screen Size
screensize = get(0, 'ScreenSize');

groupnames = {'CH','ADO','ADU','SEN'};
for ng = 1:4
    subplot (4,1,ng);
    b = bar(SLF_LI_mean(:,ng));
    b.FaceColor = 'flat';
    b.CData(1,:) = [.16 .68 .9];
    b.CData(2,:) = [.07 .07 .71];
    b.CData(3,:) = [.76 0 .76];
    hold on
    er = errorbar(1:3,SLF_LI_mean(:,ng),SLF_LI_ser(:,ng));
    er.Color = [0 0 0];
    er.LineStyle = 'none';
    ylim([-0.1,0.1]);
    view(90,90);
    set(gca,'tickdir','out','box','off');
    set(gca, 'XTickLabel', {'SLF I','SLF II', 'SLF III'}, 'fontsize', 12);
    title (groupnames(ng));
    pbaspect([3 4 1]);
end
set(gcf, 'Position', [1 1 screensize(3)*0.2 screensize(4)*0.8]);