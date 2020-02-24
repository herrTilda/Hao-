
function [sim_muscle,sim_adipose] = simulate_model(time, model_name, params)

[model,paramsAll]=simInit(model_name,exp(params));

try
   [inits] = simulateSteadyState(time, model, paramsAll);
   sim = model(time, inits, paramsAll); 
   sim_muscle = sim.variablevalues(:,26)';
   sim_adipose = sim.variablevalues(:,25)';
catch error
%    disp(getReport(error))
   [sim_muscle,sim_adipose]=deal(inf*ones(size(time))');
end

end
