% This counts all the incidents that occured at each step
function [incident_count] = calculate_total2(incident,mc_baseline,action_size) 
    mc_size = size(mc_baseline,1);
    temp = 0;
    incident_count = zeros(1,action_size);

    for i = 1: mc_size
    
        if mc_baseline(i,1) == 1 
                temp = sum(incident{i,1});
                incident_count(1,1) = incident_count(1,1) + temp; 
        end
        
    
        if mc_baseline(i,1) == 2   
             temp = sum(incident{i,2});
             incident_count(1,2) = incident_count(1,2) + temp;
       end

        if mc_baseline(i,1) == 3   
             temp = sum(incident{i,3});
             incident_count(1,3) = incident_count(1,3) + temp;
       end
      
       if mc_baseline(i,1) == 4   
             temp = sum(incident{i,4});
             incident_count(1,4) = incident_count(1,4) + temp;
       end
    
     

    end 
        incident_sum = sum(incident_count);
    
end