function [incident] = calculate_incident(agent_threat,days,i_scores)
%vuln1_output6 = zeros(days,1);
incident = zeros(days,size(i_scores,2));
for i = 1:days
    for j = 1:size(i_scores,2)
        if agent_threat > i_scores(i,j)
            incident(i,j) =1;
        end
    end
end
end