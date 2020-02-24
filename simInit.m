
function [model,paramsAll]=simInit(model_name,paramsOpt)

% make model
model=str2func(model_name);

% which parameters to optimize
[~,paramsAll]=IQMparameters(model); 
if ~isempty(paramsOpt)
paramsAll=paramsOpt;
end

end
