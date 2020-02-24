
function cost = cost_fun(DATA,model_name,params,fid)

limit=chi2inv(0.95,length(DATA.Muscle));

[sim_muscle, sim_adipose]=simulate_model(DATA.time,model_name,params);
cost1 = nansum((((DATA.Muscle'-sim_muscle).^2)./(DATA.SEM1.^2)')); % MTGU
cost2 = nansum((((DATA.Adipose'-sim_adipose).^2)./(DATA.SEM2.^2)'));% ATGU

cost = cost1+cost2;

if cost< limit && nargin==4
 fprintf(fid, [sprintf('%.52f, ',exp(params)) sprintf('%.52f\n',cost)]); % 
end

end
