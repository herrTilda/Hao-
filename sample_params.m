
function [sampledParams] = sample_params(model_name,nsets)

% load params
allParameters = dlmread([model_name,'_all_good_parameters.csv']);

% allocation
np=size(allParameters,2)-1;
sets=floor(linspace(1,size(allParameters,1),nsets));
sampledParams=nan(nsets,np);

% sample
    for k = 1:np
        allParameters=sortrows(allParameters,(np+1));
        sampledParams(:,k)=allParameters(sets,k);
    end

end
