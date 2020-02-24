%function [] =  EstimateParameters(worker)
% s=rng('shuffle'); %do not note remove this line
% s=rng(s.Seed+worker); %do not note remove this line

% Add whatever paths/toolboxes you need.
addpath(genpath('../MATLAB/IQMtools/'))
addpath('../MATLAB')
addpath('./Models')
addpath('./data')

% initial stuff

load 'Data_all'
model_name='M4_final';
% load 'p_M4_with_param_best'
[~,paramsAll]=simInit(model_name,[]);
% optParam=log(optParam');
nparams=length(paramsAll);

%% optimera

options_ps=optimoptions(@particleswarm, 'Display','iter');%,'HybridFcn',@fmincon);
options_s=optimoptions(@simulannealbnd, 'Display','iter');
lb = repmat(log(1e-5),1,nparams);
ub = repmat(log(1e5),1,nparams);

fid = fopen([model_name,'_all_good_parameters.csv'],'a');

costfunc = @(p) cost_fun(DATA, model_name, p,fid);

[optParam_ps, min_val_ps] = particleswarm(costfunc, nparams, lb, ub, options_ps);
[optParam, min_val] = simulannealbnd(costfunc,optParam_ps, lb, ub, options_s);
[minfun]=costfunc(optParam); 
fclose(fid);

% Save the results
save(['p_' model_name '_' datestr(now, 'yymmdd-HHMMSS')],'optParam'); %,[worker]);

% if minfun<chi2inv(0.95,)
%     SaveFile(sprintf('%s/opt(%.2f), %s.mat',folder, minfun,  datestr(now,'yymmdd-HHMMSS')),optParam,'optParam');
% end

%% plot
plot_stuff(DATA,model_name,optParam);

%end
