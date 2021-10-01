function s_figureS12
% Create scatter plots comparing quantitative R1 (qR1) along SLF I/II/III between left and right hemispheres.
% This script aims to reproduce Supplementary Figure 12 in a following article:
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

color{1} = [0, 0.4470, 0.7410];
color{2} = [0.8500, 0.3250, 0.0980];
color{3} = [0.9290, 0.6940, 0.1250];
color{4} = [0.4940, 0.1840, 0.5560];

for i=1:4
    load(FileToLoad{i});
    % Calculate averaged qR1 between node 21 and 80
    for k = 1:6
        qr1_plot(k,:) = 1./squeeze(mean(all_profile.qt1(21:80,k,:),1));
    end
    
    % Set the limit of scattter plot
    h1.xlim(1) = 0.9; % X axis, the minimum limit
    h1.xlim(2) = 1.3; % X axis, the maximum limit
    h1.ylim(1) = 0.9; % Y axis, the minimum limit
    h1.ylim(2) = 1.3; % Y axis, the maximum limit
    
    % Set tick label
    xtick = [0.9 1.1 1.3];
    ytick = [0.9 1.1 1.3];
    
    scatter(qr1_plot(1,:),qr1_plot(4,:),40,color{i},'filled');
    
    x = linspace(0.9,1.3);
    y = linspace(0.9,1.3);
    hold on
    clear qr1_plot
    
end
line(x,y,'Color','k');
xlabel('Left SLF I qR1');
ylabel('Right SLF I qR1');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);

figure(2)
for i=1:4
    load(FileToLoad{i});
    for k = 1:6
        qr1_plot(k,:) = 1./squeeze(mean(all_profile.qt1(21:80,k,:),1));
    end
    
    % Set the limit of scattter plot
    h1.xlim(1) = 0.9; % X axis, the minimum limit
    h1.xlim(2) = 1.3; % X axis, the maximum limit
    h1.ylim(1) = 0.9; % Y axis, the minimum limit
    h1.ylim(2) = 1.3; % Y axis, the maximum limit
    
    % Set tick label
    xtick = [0.9 1.1 1.3];
    ytick = [0.9 1.1 1.3];
    
    scatter(qr1_plot(2,:),qr1_plot(5,:),40,color{i},'filled');
    
    x = linspace(0.9, 1.3);
    y = linspace(0.9, 1.3);
    hold on
    clear qr1_plot
end
line(x,y,'Color','k');
xlabel('Left SLF II qR1');
ylabel('Right SLF II qR1');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);

figure(3)
for i=1:4
    load(FileToLoad{i});
    for k = 1:6
        qr1_plot(k,:) = 1./squeeze(mean(all_profile.qt1(21:80,k,:),1));
    end
    
    % Set the limit of scattter plot
    h1.xlim(1) = 0.9; % X axis, the minimum limit
    h1.xlim(2) = 1.3; % X axis, the maximum limit
    h1.ylim(1) = 0.9; % Y axis, the minimum limit
    h1.ylim(2) = 1.3; % Y axis, the maximum limit
    
    % Set tick label
    xtick = [0.9 1.1 1.3];
    ytick = [0.9 1.1 1.3];
    
    scatter(qr1_plot(3,:),qr1_plot(6,:),40,color{i},'filled');
    
    x = linspace(0.9,1.3);
    y = linspace(0.9,1.3);
    hold on
    clear qr1_plot
end
line(x,y,'Color','k');
xlabel('Left SLF III qR1');
ylabel('Right SLF III qR1');
axis square
set(gca, 'tickdir', 'out', 'box', 'off', 'xlim', h1.xlim,'xtick',xtick, 'ylim', h1.ylim,'ytick',ytick);
