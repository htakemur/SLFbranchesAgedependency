function s_figureS10_left

% Plot the spatial profile of the laterality index (LI) of fractional anisotropy (FA) along SLF I, II, and III volume in each age group.
% This script aims to reproduce the left panel of Supplementary Figure 10 in a following article:
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
    load(FileToLoad{i});
    % Calculate FA in each node, averaged across participants in the group
    for k = 1:6
        fa_plot(:,i,k) = squeeze(mean(all_profile.fa(21:80,k,:),3));
    end
    % Calculate laterality index (LI)
    LI_plot(:,i,1) = (fa_plot(:,i,4) - fa_plot(:,i,1))./(fa_plot(:,i,4) + fa_plot(:,i,1));
    LI_plot(:,i,2) = (fa_plot(:,i,5) - fa_plot(:,i,2))./(fa_plot(:,i,5) + fa_plot(:,i,2));
    LI_plot(:,i,3) = (fa_plot(:,i,6) - fa_plot(:,i,3))./(fa_plot(:,i,6) + fa_plot(:,i,3));
end

groupnames = {'SLF I', 'SLF II', 'SLF III'};

% Plot spatial profile
for ng = 1:3
    subplot (3,1,ng)
    x = [1:1:60];
    h = plot(x, LI_plot(:,1,ng), x, LI_plot(:,2,ng), x, LI_plot(:,3,ng),x, LI_plot(:,4,ng));
    hold on
    ylim([-0.1,0.1])
    ylabel('LI');
    xlabel('Position');
    if ng ==1
        legend('CH','ADO','ADU','SEN');
    else
    end
    title(groupnames(ng))
end