function s_figureS13_right

% Plot mean and standard deviation of the lateralization index of SLF I, II, and III qR1 in each age group, by only including right-handed participants. 
% This script aims to reproduce the right panel of Supplemenary Figure 13 in a following article:
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

for i = 1:4
    % Load data
    load(FileToLoad{i});
     % Select right-handed participants
    switch i
        case 1
            RH_subj = [1:15 17];
        case 2
            RH_subj = [1:2 4 7:11 13:20];
        case 3
            RH_subj = [5:7 9:11 13:17 19:22];
        case 4
            RH_subj = [1:11 13:17 19:21];
    end       
    
    % Compute qR1 averaged from node 21 to node 80
    for k = 1:6
        qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,RH_subj),1)));
    end
    
    % Compute lateralization index
    SLFI_LI = squeeze(((qr1_plot(:,4) - qr1_plot(:,1))./(qr1_plot(:,4) + qr1_plot(:,1))));
    SLFII_LI = squeeze(((qr1_plot(:,5) - qr1_plot(:,2))./(qr1_plot(:,5) + qr1_plot(:,2))));
    SLFIII_LI = squeeze(((qr1_plot(:,6) - qr1_plot(:,3))./(qr1_plot(:,6) + qr1_plot(:,3))));

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
    
    clear qr1_plot
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
    ylim([-0.05,0.05])
    view(90,90)
    set(gca,'tickdir','out','box','off');
    set(gca, 'XTickLabel', {'SLF I','SLF II', 'SLF III'}, 'fontsize', 12);
    title (groupnames(ng))
    pbaspect([3 4 1])
end
set(gcf, 'Position', [1 1 screensize(3)*0.2 screensize(4)*0.8])
