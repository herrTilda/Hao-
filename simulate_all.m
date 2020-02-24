
function [sim_muscle,sim_adipose,sim_liver,sim_tot,sim_IRS] = simulate_all(time, model_name, params)

[model,paramsAll]=simInit(model_name,[]);%,exp(params));
%try
%sim_all=table(nan(height(experiments),length(simTimes)),'VariableNames',{'Measures'},'RowNames',experiments.Properties.RowNames);

   sim = model(time, [], paramsAll); 
   sim_muscle = sim.variablevalues(:,26)';
   sim_adipose = sim.variablevalues(:,25)';
   sim_liver = sim.variablevalues(:,18)';
   sim_tot = sim.variablevalues(:,end)';
   sim_IRS = sim.statevalues(:,22);
% catch error
%    disp(getReport(error))
%    [sim_muscle,sim_adipose,sim_liver,sim_tot,sim_IRS]=deal(1e50*ones(size(time))');
% end

end
