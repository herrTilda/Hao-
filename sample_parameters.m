
function [sampled_parameters] = sample_parameters(allParameters,nsets)

np=size(allParameters,2)-1;
sets=floor(linspace(1,size(allParameters,1),nsets));
sampled_parameters=NaN(nsets,np);

    for k = 1:np
        allParameters=sortrows(allParameters,(np+1));
        sampled_parameters(:,k)=allParameters(sets,k);
    end
end
