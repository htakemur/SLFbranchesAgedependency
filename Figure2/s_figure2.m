function s_figure2

% Plot mean and standard deviation of volumes of SLF I, II, and III in each age group. This script aims to reproduce Figure 2 in a following article:
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

% Load data and comppute mean/standard error
for i = 1:4
    load(FileToLoad{i});
    tractvolume_mean(:,i) = mean(tractvolume,2);
    tractvolume_std(:,i) = std(tractvolume, 0, 2);
    tractvolume_ser(:,i) = tractvolume_std(:,i)./sqrt(length(tractvolume));
    clear tractvolume
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];

% Plot results
for ng = 1:6;
    subplot (3,2,ng)
    h = bar(transpose(tractvolume_mean(ordernum(ng),:)));
    hold on
    er = errorbar(transpose(tractvolume_mean(ordernum(ng),:)),transpose(tractvolume_ser(ordernum(ng),:)));
    er.Color = 'red';
    er.LineStyle = 'none';
    ylim([0 20000])
    ylabel('Tract volume');
    set(gca, 'XTickLabel', {'CH','ADO','AD','SEN'}, 'fontsize', 12);
    title(groupnames(ordernum(ng)))
end
