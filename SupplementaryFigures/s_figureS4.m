function s_figureS4

% Plot estimated tract volume of SLF I, II, and III volume in each age group, when we vary streamline density thresholds.
% This script aims to reproduce Supplementary Figure 4 in a following article:
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

for k = 1:4
    for i = 1:4
        load(FileToLoad{i});
        tractvolume_mean(:,i,k) = mean(tractvolume(:,:,k),2);
        tractvolume_std(:,i,k) = std(tractvolume(:,:,k), 0, 2);
        tractvolume_ser(:,i,k) = tractvolume_std(:,i,k)./sqrt(length(tractvolume));
        clear tractvolume
    end
end

groupnames = {'Left SLF I', 'Left SLF II', 'Left SLF III', 'Right SLF I', 'Right SLF II', 'Right SLF III'};
ordernum = [1 4 2 5 3 6];
for ng = 1:6
    subplot (3,2,ng)
    for kkj = 1:4
        tractvolume_mean_plot(kkj,:) = transpose(tractvolume_mean(ordernum(ng),:,kkj));
        tractvolume_ser_plot(kkj,:) = transpose(tractvolume_ser(ordernum(ng),:,kkj));
    end
    h = bar(transpose(tractvolume_mean_plot));
    h(1).FaceColor = [0.2078 0.1647 0.5255];
    h(2).FaceColor = [0.0235 0.6118 0.8118];
    h(3).FaceColor = [0.6471 0.7451 0.4157];
    h(4).FaceColor = [0.9725 0.9804 0.0510];   
    hold on
    er = errorbar(transpose(tractvolume_mean_plot),transpose(tractvolume_ser_plot));
    er(1).Color = [1 0 0];
    er(1).LineStyle = 'none';
    er(1).XData = [0.73 1.73 2.73 3.73];
    er(2).Color = [1 0 0];
    er(2).LineStyle = 'none';
    er(2).XData = [0.91 1.91 2.91 3.91];
    er(3).Color = [1 0 0];
    er(3).LineStyle = 'none';
    er(3).XData = [1.09 2.09 3.09 4.09];
    er(4).Color = [1 0 0];
    er(4).LineStyle = 'none';
    er(4).XData = [1.27 2.27 3.27 4.27];
    ylim([0 20000]);
    ylabel('Tract Volume (mm^3)');
    set(gca, 'XTickLabel', {'CH','ADO','ADU','SEN'}, 'fontsize', 12);
    title(groupnames(ordernum(ng)));
end