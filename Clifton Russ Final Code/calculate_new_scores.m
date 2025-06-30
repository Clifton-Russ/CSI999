function [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 for P = 1: days/2
        for Q = 1: i_size
            temp = randi([0,1],1);
            if temp == 0
                new_min = sample_incident_score(1,Q)-(min*sample_incident_score(1,Q));
                new_max = sample_incident_score(1,Q)-(max*sample_incident_score(1,Q));
                i_scores(P,Q)= new_min + (new_max-new_min)*rand(1,1);
            else
                new_min = sample_incident_score(1,Q)+(min*sample_incident_score(1,Q));
                new_max = sample_incident_score(1,Q)+(max*sample_incident_score(1,Q));
                i_scores(P,Q)= new_min + (new_max-new_min)*rand(1,1);
            end
        end
    
end