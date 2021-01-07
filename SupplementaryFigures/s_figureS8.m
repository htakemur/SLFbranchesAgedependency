function s_figureS8

% Create the scatter plot comparing SLF I/II/III tract volume between left and right hemispheres.
% This script aims to reproduce Supplementary Figure 8 in a following article:
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% This codes use functions derived from this repository (by Jason Yeatman): https://github.com/jyeatman/lifespan
%
% Hiromasa Takemura, NICT CiNet BIT

cd ../Data/TractVolume_Main/

FileToLoad{1}='CH_tractvolume_main.mat';
FileToLoad{2}='ADO_tractvolume_main.mat';
FileToLoad{3}='ADU_tractvolume_main.mat';
FileToLoad{4}='SEN_tractvolume_main.mat';

color{1} = [0, 0.4470, 0.7410];
color{2} = [0.8500, 0.3250, 0.0980];
color{3} = [0.9290, 0.6940, 0.1250];
color{4} = [0.4940, 0.1840, 0.5560];

for i=1:4
    load(FileToLoad{i});
    
    % Set the limit of scattter plot
    h1.xlim(1) = 0; % X axis, the minimum limit
    h1.xlim(2) = 20000; % X axis, the maximum limit
    h1.ylim(1) = 00; % Y axis, the minimum limit
    h1.ylim(2) = 20000; % Y axis, the maximum limit
    
    % Set tick label
    xtick = [0 10000 20000];
    ytick = [0 10000 20000];
    
    scatter(tractvolume(1,:),tractvolume(4,:),40,color{i},'filled');
    
    x = linspace(0,20000);
    y = linspace(0,20000);
    hold on
end
line(x,y,'Color','k');
xlabel('Left SLF I tract volume (mm^3)');
ylabel('Right SLF I tract volume (mm^3)');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);

figure(2)
for i=1:4
    load(FileToLoad{i});
    % Set the limit of scattter plot
    h1.xlim(1) = 0; % X axis, the minimum limit
    h1.xlim(2) = 20000; % X axis, the maximum limit
    h1.ylim(1) = 00; % Y axis, the minimum limit
    h1.ylim(2) = 20000; % Y axis, the maximum limit
    
    % Set tick label
    xtick = [0 10000 20000];
    ytick = [0 10000 20000];
    
    scatter(tractvolume(2,:),tractvolume(5,:),40,color{i},'filled');
    
    x = linspace(0,20000);
    y = linspace(0,20000);
    hold on
end
line(x,y,'Color','k');
xlabel('Left SLF II tract volume (mm^3)');
ylabel('Right SLF II tract volume (mm^3)');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);

figure(3)
for i=1:4
    load(FileToLoad{i});
    % Set the limit of scattter plot
    h1.xlim(1) = 0; % X axis, the minimum limit
    h1.xlim(2) = 20000; % X axis, the maximum limit
    h1.ylim(1) = 00; % Y axis, the minimum limit
    h1.ylim(2) = 20000; % Y axis, the maximum limit
    
    % Set tick label
    xtick = [0 10000 20000];
    ytick = [0 10000 20000];
    
    scatter(tractvolume(3,:),tractvolume(6,:),40,color{i},'filled');
    
    x = linspace(0,20000);
    y = linspace(0,20000);
    hold on
end
line(x,y,'Color','k');
xlabel('Left SLF III tract volume (mm^3)');
ylabel('Right SLF III tract volume (mm^3)');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);
