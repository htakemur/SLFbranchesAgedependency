function s_figureS17
% Create a scatter plot comparing laterality index (LI) of SLF III volume and SLF III fractional anisotropy (FA).
% This script aims to reproduce Supplementary Figure 17 and Supplementary Table 3 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% Hiromasa Takemura, NICT CiNet BIT

%% Load data and compute LI of tract volume
cd ../Data/TractVolume_Main/

FileToLoad{1}='CH_tractvolume_main.mat';
FileToLoad{2}='ADO_tractvolume_main.mat';
FileToLoad{3}='ADU_tractvolume_main.mat';
FileToLoad{4}='SEN_tractvolume_main.mat';

for i = 1:4
    load(FileToLoad{i});
    
    % Compute lateralization index of SLF III volume in each group
    V_SLFIII_LItemp{i} = squeeze((tractvolume(6,:) - tractvolume(3,:))./(tractvolume(3,:) + tractvolume(6,:)))';
end

volume_SLFIII_LI(1:17) = V_SLFIII_LItemp{1};
volume_SLFIII_LI(18:37) = V_SLFIII_LItemp{2};
volume_SLFIII_LI(38:60) = V_SLFIII_LItemp{3};
volume_SLFIII_LI(61:82) = V_SLFIII_LItemp{4};

%% Load data and compute LI of FA
cd ../FAqR1_Main/

FileToLoad{1}='CH_FAqR1_main.mat';
FileToLoad{2}='ADO_FAqR1_main.mat';
FileToLoad{3}='ADU_FAqR1_main.mat';
FileToLoad{4}='SEN_FAqR1_main.mat';

load(FileToLoad{1});
for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end
FA_SLFII_LI(1:17) = squeeze(((fa_plot(:,5) - fa_plot(:,2))./(fa_plot(:,5) + fa_plot(:,2))));
FA_SLFIII_LI(1:17) = squeeze(((fa_plot(:,6) - fa_plot(:,3))./(fa_plot(:,6) + fa_plot(:,3))));
qR1_SLFI_LI(1:17) = squeeze(((qr1_plot(:,4) - qr1_plot(:,1))./(qr1_plot(:,4) + qr1_plot(:,1))));
clear fa_plot qr1_plot

load(FileToLoad{2});
for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end
FA_SLFII_LI(18:37) = squeeze(((fa_plot(:,5) - fa_plot(:,2))./(fa_plot(:,5) + fa_plot(:,2))));
FA_SLFIII_LI(18:37) = squeeze(((fa_plot(:,6) - fa_plot(:,3))./(fa_plot(:,6) + fa_plot(:,3))));
qR1_SLFI_LI(18:37) = squeeze(((qr1_plot(:,4) - qr1_plot(:,1))./(qr1_plot(:,4) + qr1_plot(:,1))));
clear fa_plot qr1_plot

load(FileToLoad{3});
for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end
FA_SLFII_LI(38:60) = squeeze(((fa_plot(:,5) - fa_plot(:,2))./(fa_plot(:,5) + fa_plot(:,2))));
FA_SLFIII_LI(38:60) = squeeze(((fa_plot(:,6) - fa_plot(:,3))./(fa_plot(:,6) + fa_plot(:,3))));
qR1_SLFI_LI(38:60) = squeeze(((qr1_plot(:,4) - qr1_plot(:,1))./(qr1_plot(:,4) + qr1_plot(:,1))));
clear fa_plot qr1_plot

load(FileToLoad{4});
for k = 1:6
    fa_plot(:,k) = squeeze(squeeze(mean(all_profile.fa(21:80,k,:),1)));
    qr1_plot(:,k) = 1./squeeze(squeeze(mean(all_profile.qt1(21:80,k,:),1)));
end
FA_SLFII_LI(61:82) = squeeze(((fa_plot(:,5) - fa_plot(:,2))./(fa_plot(:,5) + fa_plot(:,2))));
FA_SLFIII_LI(61:82) = squeeze(((fa_plot(:,6) - fa_plot(:,3))./(fa_plot(:,6) + fa_plot(:,3))));
qR1_SLFI_LI(61:82) = squeeze(((qr1_plot(:,4) - qr1_plot(:,1))./(qr1_plot(:,4) + qr1_plot(:,1))));
clear fa_plot qr1_plot

%% Calculate correlation (replicating Supplementary Table 3)
[r(1,1),p(1,1)] = corr(transpose(volume_SLFIII_LI), transpose(FA_SLFII_LI));
[r(1,2),p(1,2)] = corr(transpose(volume_SLFIII_LI), transpose(FA_SLFIII_LI));
[r(1,3),p(1,3)] = corr(transpose(volume_SLFIII_LI), transpose(qR1_SLFI_LI));
[r(2,2),p(2,2)] = corr(transpose(FA_SLFII_LI), transpose(FA_SLFIII_LI));
[r(2,3),p(2,3)] = corr(transpose(FA_SLFII_LI), transpose(qR1_SLFI_LI));
[r(3,3),p(3,3)] = corr(transpose(FA_SLFIII_LI), transpose(qR1_SLFI_LI));

%% Create a scatter plot
color{1} = [0, 0.4470, 0.7410];
color{2} = [0.8500, 0.3250, 0.0980];
color{3} = [0.9290, 0.6940, 0.1250];
color{4} = [0.4940, 0.1840, 0.5560];

% Set the limit of scattter plot
h1.xlim(1) = -0.5; % X axis, the minimum limit
h1.xlim(2) = 0.5; % X axis, the maximum limit
h1.ylim(1) = -0.2; % Y axis, the minimum limit
h1.ylim(2) = 0.2; % Y axis, the maximum limit

% Set tick label
xtick = [-0.5 0 0.5];
ytick = [-0.2 0 0.2];

scatter(volume_SLFIII_LI(1:17),FA_SLFIII_LI(1:17),40,color{1},'filled');
hold on
scatter(volume_SLFIII_LI(18:37),FA_SLFIII_LI(18:37),40,color{2},'filled');
hold on
scatter(volume_SLFIII_LI(38:60),FA_SLFIII_LI(38:60),40,color{3},'filled');
hold on
scatter(volume_SLFIII_LI(61:82),FA_SLFIII_LI(61:82),40,color{4},'filled');
hold on

xlabel('SLF III tract volume LI');
ylabel('SLF III FA LI');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);