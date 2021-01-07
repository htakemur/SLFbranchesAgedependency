function f = nc_PlotModelFits(coefs,valName,fgNames,fgnums,color)
% Make figures from coeficient estimates (nc_ModelSelection)
%
% f = nc_PlotModelFits(coefs,valName,fgNames,fgnums,color)
%
% Inputs:
%
% coefs   - Structure containing model coefficient estimates (see
%           nc_ModelSelection)
% valName - The name of the qMR parameter (e.g., R1)
% fgNames - Cell array of fiber group names (in the order they are in the
%           AFQ structure)
% fgnums  - Vector of fiber group numbers. The plots will be in the order
%           denoted here. For example if fgnums(1) = 3, than the third
%           fiber group (Left CST) will be plotted first.
% color   - rgb values for each plot
%
% Copyright Jason D. Yeatman, August 2014. Original version of the code released with:
% Yeatman JD, Wandell BA & Mezer AM (2014). Lifespan maturation 
% and degeneration of human brain white matter. Nature Communications
% Github repository hosting the original version of the code: https://github.com/jyeatman/lifespan
%
% 2020.12.22 Hiromasa Takemura released a modified version of this code for
% reproducing the analysis of the following paper:
% Amemiya, K., Naito, E. & Takemura, H. (2021)
% Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.

% Open figure window
figure;

%% Plotting options

fgNames = fgNames(fgnums);
% Points to evaluate model
x0 = min(coefs(1).x):max(coefs(1).x);
% axis scaling
if strcmp(valName,'TV_map')
    yticks = [.15 .25  .35];
    ylims = [.13 .38];
    YLab = 'MTV'
    xtl = .01;
    mat = 'max';
elseif strcmp(valName, 'md')
    ylims = [.53 .85];
    yticks = [.6 .7 .8];
    YLab = 'ADC (\mum^2/ms)';
    xtl = .013;
    mat = 'min';
elseif strcmp(valName,'fa')
    ylims = [.3 .6];
    yticks = [.3 .45 .6];
    YLab = 'FA';
    xtl = .013;
    mat = 'max';
elseif strcmp(valName,'Res_FA')
    ylims = [-0.2 .2];
    yticks = [-0.2 0 .2];
    YLab = 'Residual FA';
    xtl = .013;
    mat = 'max';    
elseif strcmp(valName,'T1_map_lsq') || strcmp(valName,'T1_map_lsq_2DTI')
    ylims = [.8 1.4];
    yticks=[.8 1 1.2 1.4];
    YLab = 'T1 (seconds)';
    xtl = .03;
    mat = 'min';
elseif strcmp(valName,'Volume') || strcmp(valName,'Volume')
    ylims = [0 20000];
    yticks=[0 10000 20000];
    YLab = 'Volume (mm3)';
    xtl = .03;
    mat = 'min';    
 elseif strcmp(valName,'LI') || strcmp(valName,'Volume')
    ylims = [-0.5 0.5];
    yticks=[-0.5 0 0.5];
    YLab = 'LI';
    xtl = .03;
    mat = 'min';      
 elseif strcmp(valName,'LI_FA') || strcmp(valName,'Volume')
    ylims = [-0.1 0.1];
    yticks=[-0.1 0 0.1];
    YLab = 'LI';
    xtl = .006;
    mat = 'min';        
 elseif strcmp(valName,'LI_qR1') || strcmp(valName,'Volume')
    ylims = [-0.05 0.05];
    yticks=[-0.05 0 0.05];
    YLab = 'LI';
    xtl = .003;
    mat = 'min';     
elseif strcmp(valName,'R1_2DTI') || strcmp(valName,'R1')
    ylims = [.9 1.3];
    yticks=[.9 1.1 1.3];
    YLab = 'R1';
    xtl = .02;
    mat = 'max';
end
xticks = 8:10:78;
xlims = [min(x0)-1 max(x0)+1];
%% Loop over tracts and plot
pnum = 0;
for ii = fgnums
    % count
    pnum = pnum+1;
    % Open a plot
    axh(ii)=subplot(1,1,pnum);

    %axh(ii)=subplot(4,6,pnum);
    hold on;
    
%     % plot the data
%     plot(coefs(ii).x, coefs(ii).y, 'o','color',[0 0 0],'markerfacecolor',color(pnum,:),'markersize',6);
    
    % compute model prediction
    switch(coefs(ii).name)
        case {'lowess' 'lowess21' 'lowess22'}
            yhat = coefs(ii).full(:,2);
            x0   = coefs(ii).full(:,1)';
            bootCI = coefs(ii).boot;
            v95 = [nan nan];
        case {'piecewise' 'piecewise2' 'piecewisenoflat'}
            yhat = piecewiseEval(coefs(ii).full,x0);
            % Calculate confidence intervals for each bootstrap iteration
            for kk = 1:size(coefs(ii).boot,1)
                bootCI(kk,:) = piecewiseEval(coefs(ii).boot(kk,:),x0);
            end
            v95 = [nan nan];
        case {'quadratic'}
             yhat = polyval(coefs(ii).full,x0);
            % Calculate confidence intervals for each bootstrap iteration
            for kk = 1:size(coefs(ii).boot,1)
                bootCI(kk,:) = polyval(coefs(ii).boot(kk,:),x0);
                % and confidence interval for vertex
                vCI(kk) = -(coefs(ii).boot(kk,2)./(2*coefs(ii).boot(kk,1)));
            end
            v95 = prctile(vCI,[2.5 97.5]);
        case {'poisson'}
            yhat = evalPoissonCurve(coefs(ii).full,x0);
            % Calculate confidence intervals for each bootstrap iteration
            for kk = 1:size(coefs(ii).boot,1)
                bootCI(kk,:) = evalPoissonCurve(coefs(ii).boot(kk,:),x0);
                % and confidence interval for vertex
                vCI(kk) = 1./coefs(ii).boot(kk,2);
            end
            v95 = prctile(vCI,[2.5 97.5]);
    end
    
    % Compute the 95% confidence intervals on the fits
    p95(:,:,ii) = prctile(bootCI,[2.5 97.5]);
    % Plot the 95% confidence interval
    fill([x0 fliplr(x0)],[p95(1,:,ii) fliplr(p95(2,:,ii))],color(pnum,:),'facealpha',.5,'edgealpha',0);
    % Plot the model fit
    plot(x0,yhat, 'color',color(pnum,:),'linewidth',2);
    xlabel('Age','fontname','times','fontsize',14);
  
    set(gca,'xtick',xticks)

%     if ismember(pnum,19:24)
%         xlabel('Age','fontname','times','fontsize',14);
%         set(gca,'xtick',xticks);
%     else
%         set(gca,'xtick',xticks,'xticklabel',[]);
%     end
    if ismember(pnum,1:6:24)
        ylabel(YLab,'fontname','times','fontsize',14);
        set(gca,'ytick',yticks)
    else
        set(gca,'ytick',yticks,'yticklabel',[]);
    end
    axis([xlims ylims]);
    % add a title
    if strcmp(mat,'max')
        th = text((xlims(2)-xlims(1))./2 + xlims(1),min(ylims).*1.1,fgNames{pnum},...
            'fontsize',12,'fontname','times','HorizontalAlignment','center');
    elseif strcmp(mat,'min')
        th = text((xlims(2)-xlims(1))./2 + xlims(1),max(ylims).*.97,fgNames{pnum},...
            'fontsize',12,'fontname','times','HorizontalAlignment','center');
    end

    
    %% Redraw the axes because matlab has a bug with opengl
    plot([xlims(1)+.01 xlims(1)+.01 xlims(2)],[ylims(2) ylims(1)+.0001 ylims(1)+.0001],'-k');
    % add x-ticks
    for tk = 1:length(xticks)
        plot([xticks(tk) xticks(tk)],[ylims(1) ylims(1)+xtl],'-k');
    end
    % add y-ticks
    for tk = 1:length(yticks)
        plot([xlims(1) xlims(1)+2],[yticks(tk) yticks(tk)],'-k');
    end
    
    %% Draw the confidence interval around the vertex
    plot(v95,repmat(min(ylims).*1.05,1,2),'linewidth',3,'color',color(pnum,:));
    plot(repmat(v95(1),1,2),[min(ylims).*1.03 min(ylims).*1.07],'linewidth',2,'color',color(pnum,:));
    plot(repmat(v95(2),1,2),[min(ylims).*1.03 min(ylims).*1.07],'linewidth',2,'color',color(pnum,:));
    
   %% plot the data
    plot(coefs(ii).x, coefs(ii).y, 'o','color',[0 0 0],'markerfacecolor',color(pnum,:),'markersize',6);


end

for ii = fgnums
    % Get the position of each subplot
    p = get(axh(ii),'position');
    % Add this much
    pnew = [0 0 .03 .05];
    p = p+pnew;
    set(axh(ii),'position',p);
end
%% Set figure properties
f(1)=gcf;
set(gcf,'inverthardcopy','off','color',[1 1 1]);

