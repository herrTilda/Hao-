
%function plot_stuff(DATA,model_name,params)

load('ferrannini_liver.mat'); % from Ferrannini et al 1985, 10.2337/diab.34.6.580

% load parameters
load(['p_',model_name,'_with_param_best.mat']);
sampledParams = sample_params(model_name,100);

% simulate all you want to look at
sim_time = [DATA.time(1):0.001:DATA.time(end)];
[sim_muscle,sim_adipose,sim_liver,sim_tot,sim_IRS] = simulate_all(sim_time, model_name, params);

% get max min for all acceptable simulations
[ymin_m,ymax_m,ymin_a,ymax_a]=get_maxmin(sim_time, model_name, squeeze(sampledParams(1,:,:)));

% nice colors
color=[   [0.8500, 0.3250, 0.0980], % muscle
            [0.9290, 0.6940, 0.1250], % adipose
            [101, 47, 28]            % liver
            ];

%% plot figure 6
figure()
clf
set(0,'DefaultLineLineWidth',2)

sgtitle(e,'Glucose uptake in')
xlabel('Time (Min)')
axis auto

% muscle
subplot(2,4,1);
errorbar(DATA.time,DATA.Muscle,DATA.SEM1,'.',color(1,1))
hold on
plot(sim_time,sim_muscle,'-',color(1,1))
ylabel('mg/kg/min');

hold on
hm=fill([sim_time fliplr(sim_time)], [ymax_a fliplr(ymin_a)],color(1,1));
set(hm,'EdgeColor','None');
hold off
alpha(.1)

% adipose
subplot(2,4,2);
errorbar(DATA.time,DATA.Adipose,DATA.SEM2,'.',color(2,1))
hold on
plot(sim_time,sim_adipose,'-',color(2,1));

hold on
ha=fill([sim_time fliplr(sim_time)], [ymax_a fliplr(ymin_a)],color(2,1));
set(ha,'EdgeColor','None');
hold off
alpha(.1)

% liver
subplot(2,4,3);
errorbar(ferrannini_liver(:,1),ferrannini_liver(:,2),ferrannini_liver(:,3),'.',color(3,1))
hold on
plot(sim_time,sim_liver,'-',color(3,1));

hold on
hl=fill([sim_time fliplr(sim_time)], [ymax_a fliplr(ymin_a)],color(3,1));
set(hl,'EdgeColor','None');
hold off
alpha(.1)

AUC = getAUC();

% bar plot
subplot(2,4,[4,5,6]);
bar(AUC,'FaceColor',color,'LineWidth',1.5);

%% Dallaman

figure();
clf
set(0,'DefaultLineLineWidth',2)

%% Multilevel figure
% organ level
% figure
% clf
% set(0,'DefaultLineLineWidth',2)
% errorbar(DATA.time,DATA.Adipose,DATA.SEM2,'.',color(2,1))
% hold on
% plot(sim_time,sim_adipose,'-',color(2,1));
% sgtitle(e,'Glucose uptake in adipose tissue')
% xlabel('Time (Min)')
% ylabel('mg/kg/min');
% 
% %cellular level
% load 'EXPDATA_IR'
% figure
% clf
% set(0,'DefaultLineLineWidth',2)
% errorbar(DATA.time,DATA.Adipose,DATA.SEM2,'.',color(2,1))
% hold on
% plot(sim_time,sim_IRS,'-',color(2,1));
% sgtitle(e,'Glucose uptake in adipose tissue')
% xlabel('Time (Min)')
% ylabel('mg/kg/min');


%% functions
function [AUC] = getAUC()

    AUC_m = trapz(DATA.time,DATA.Muscle);
    AUC_a = trapz(DATA.time,DATA.Adipose);
%     AUC_l = trapz(ferrannini_liver(:,1),ferrannini_liver(:,2));
    
    AUCsim_m = trapz(sim_time,sim_muscle);
    AUCsim_a = trapz(sim_time,sim_adipose);
%     AUCsim_l = trapz(sim_time,sim_liver);
%    AUCsim_tot = trapz(sim_time,sim_tot);
            
    AUC = table([AUC_m AUCsim_m ; AUC_a AUCsim_a],'VariableNames',{'AUC data','AUC simulation'},'RowNames',{'muscle', 'adipose'});%,'liver'});
    
end

%end





