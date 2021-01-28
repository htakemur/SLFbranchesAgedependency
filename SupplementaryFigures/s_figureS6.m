function s_figureS6

% Plot the spatial profile of quantitative R1 (qR1) along SLF I, II, and III volume in each age group.
% This script aims to reproduce Supplementary Figure 6 in a following article:
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
    for k = 1:6
        qr1_plot(:,i,k) = 1./squeeze(mean(all_profile.qt1(21:80,k,:),3));
    end
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

for ng = 1:6
    subplot (3,2,ng);
    x = [1:1:60];
    h = plot(x, qr1_plot(:,1,ordernum(ng)), x, qr1_plot(:,2,ordernum(ng)), x, qr1_plot(:,3,ordernum(ng)), x, qr1_plot(:,4,ordernum(ng)));
    hold on
    ylim([0.9 1.2])
    ylabel('qR1');
    if ng ==1
        legend('CH','ADO','ADU','SEN');
    else
    end
    title(groupnames(ordernum(ng)));
end