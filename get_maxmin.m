function [ymin_m,ymax_m,ymin_a,ymax_a]=get_maxmin(sim_time, model_name, params)
    
    for k=1:size(params,2)
        
         [y_m,y_a] = simulate_model(sim_time, model_name, params(k,:)');

            if k == 1
             ymin_m=y_m;
             ymax_m=y_m;
             ymin_a=y_a;
             ymax_a=y_a;
            end

        ymin_m(ymin_a>y_m)=y_m(ymin_m>y_m);
        ymax_m(ymax_m<y_m)=y_m(ymax_m<y_m);
        
        ymin_a(ymin_a>y_a)=y_a(ymin_a>y_a);
        ymax_a(ymax_a<y_a)=y_a(ymax_a<y_a);

    end
    
end