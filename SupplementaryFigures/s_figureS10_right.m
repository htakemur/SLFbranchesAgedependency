function s_figureS10_right

% Plot the spatial profile of the laterality index (LI) of quantitative R1 (qR1) along SLF I, II, and III in each age group.
% This script aims to reproduce the right panel of Supplementary Figure 10 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021) Age dependency and lateralization in the 
% three branches of the human superior longitudinal fasciculus. Cortex, 139, 116-133.
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/FAqR1_Main/

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

for i = 1:4
    load(FileToLoad{i});
    % Calculate qR1 in each node, averaged across participants in the group
    for k = 1:6
        qr1_plot(:,i,k) = 1./squeeze(mean(all_profile.qt1(21:80,k,:),3));
    end
    % Calculate laterality index (LI)
    LI_plot(:,i,1) = (qr1_plot(:,i,4) - qr1_plot(:,i,1))./(qr1_plot(:,i,4) + qr1_plot(:,i,1));
    LI_plot(:,i,2) = (qr1_plot(:,i,5) - qr1_plot(:,i,2))./(qr1_plot(:,i,5) + qr1_plot(:,i,2));
    LI_plot(:,i,3) = (qr1_plot(:,i,6) - qr1_plot(:,i,3))./(qr1_plot(:,i,6) + qr1_plot(:,i,3));
end

groupnames = {'SLF I', 'SLF II', 'SLF III'};

% Plot spatial profile
for ng = 1:3
    subplot (3,1,ng);
    x = [1:1:60];
    h = plot(x, LI_plot(:,1,ng), x, LI_plot(:,2,ng), x, LI_plot(:,3,ng),x, LI_plot(:,4,ng));
    hold on
    ylim([-0.05,0.05]);
    ylabel('LI');
    xlabel('Position');
    if ng ==1
        legend('CH','ADO','ADU','SEN');
    else
    end
    title(groupnames(ng));
end