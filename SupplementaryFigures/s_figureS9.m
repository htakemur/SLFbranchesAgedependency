function s_figureS9

% Plot mean and standard deviation of the lateralization index of SLF I, II, and III volume in each age group, when we vary streamline density thresholds.
% This script aims to reproduce Supplementary Figure 9 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/TractVolume_variedthreshold/

FileToLoad{1}='CH_tractvolume_variedthreshold.mat';
FileToLoad{2}='ADO_tractvolume_variedthreshold.mat';
FileToLoad{3}='ADU_tractvolume_variedthreshold.mat';
FileToLoad{4}='SEN_tractvolume_variedthreshold.mat';

for kk = 1:4
    for i = 1:4
        load(FileToLoad{i});
        
        % Compute lateralization index
        SLFI_LI = squeeze((tractvolume(4,:,kk) - tractvolume(1,:,kk))./(tractvolume(1,:,kk) + tractvolume(4,:,kk)))';
        SLFII_LI = squeeze((tractvolume(5,:,kk) - tractvolume(2,:,kk))./(tractvolume(2,:,kk) + tractvolume(5,:,kk)))';
        SLFIII_LI = squeeze((tractvolume(6,:,kk) - tractvolume(3,:,kk))./(tractvolume(3,:,kk) + tractvolume(6,:,kk)))';
        
        % Compute summary statistics of LI
        SLF_LI_mean(1,i,kk) = mean(SLFI_LI);
        SLF_LI_mean(2,i,kk) = mean(SLFII_LI);
        SLF_LI_mean(3,i,kk) = mean(SLFIII_LI);
        SLF_LI_std(1,i,kk) = std(SLFI_LI);
        SLF_LI_std(2,i,kk) = std(SLFII_LI);
        SLF_LI_std(3,i,kk) = std(SLFIII_LI);
        SLF_LI_ser(1,i,kk) = SLF_LI_std(1,i,kk)./sqrt(length(SLFI_LI));
        SLF_LI_ser(2,i,kk) = SLF_LI_std(2,i,kk)./sqrt(length(SLFII_LI));
        SLF_LI_ser(3,i,kk) = SLF_LI_std(3,i,kk)./sqrt(length(SLFIII_LI));
    end
end

% Get Screen Size
screensize = get(0, 'ScreenSize');

groupnames = {'CH','ADO','AD','SEN'};
for ng = 1:4
    subplot (4,1,ng)
    for kkj = 1:4
        SLF_LI_mean_plot(kkj,:) = transpose(SLF_LI_mean(:,ng,kkj));
        SLF_LI_ser_plot(kkj,:) = transpose(SLF_LI_ser(:,ng,kkj));
    end
    h = bar(transpose(SLF_LI_mean_plot));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    h(2).FaceColor = [0.0235 0.6118 0.8118];
    h(3).FaceColor = [0.6471 0.7451 0.4157];
    h(4).FaceColor = [0.9725 0.9804 0.0510];
    hold on
    er = errorbar(transpose(SLF_LI_mean_plot),transpose(SLF_LI_ser_plot));
    er(1).Color = [0 0 0];
    er(1).LineStyle = 'none';
    er(1).XData = [0.73 1.73 2.73];
    er(2).Color = [0 0 0];
    er(2).LineStyle = 'none';
    er(2).XData = [0.91 1.91 2.91];
    er(3).Color = [0 0 0];
    er(3).LineStyle = 'none';
    er(3).XData = [1.09 2.09 3.09];
    er(4).Color = [0 0 0];
    er(4).LineStyle = 'none';
    er(4).XData = [1.27 2.27 3.27];
    ylim([-0.5,0.5]);
    view(90,90);
    set(gca,'tickdir','out','box','off');
    set(gca, 'XTickLabel', {'SLF I','SLF II', 'SLF III'}, 'fontsize', 12);
    title (groupnames(ng));
    pbaspect([3 4 1]);
end
set(gcf, 'Position', [1 1 screensize(3)*0.2 screensize(4)*0.8]);