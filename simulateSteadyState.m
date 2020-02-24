function [inits] = simulateSteadyState(time, model, paramsAll)

try
   sim = model(time, [], paramsAll); 
   inits = sim.statevalues(1,:);
catch error
%    disp(getReport(error))
   inits=[];
end


end
