%% Determine compliance for each person and activity

% A user's compliance score is inversely related to their vulnerability
% score. A compliance score represents how compliant a user is with following
% rules. A higher compliance score means that the user is more likely
% compliant with all requirements. A threat score represents the 
% likelihood of a user doing an action that would result to an incident or
% breach. Therefore, the higher the compliance score, the lower the
% threat score. The compliance comes from the user variable 


function [agent_threat] = determine_agent_threat(compliance,vuln_size)

% For each compliance score, a random threat score is given within a range
% that is inversely related to the compliance.
agent_threat = zeros(1,vuln_size);
if compliance > .75  
    for i = 1:vuln_size
        xmin = 0;
        xmax = .4;
        agent_threat(1,i) = xmin + (xmax-xmin).*rand(1,1);
    end
end

if compliance >= .50 && compliance < .75
    for i = 1:vuln_size    
        xmin = .4;
        xmax = .60;
        agent_threat(1,i) = xmin + (xmax-xmin).*rand(1,1);
    end
end 

if compliance (1,1) <.5 
    for i = 1:vuln_size
        xmin = .6;
        xmax = .75;
        agent_threat(1,i) = xmin + (xmax-xmin).*rand(1,1);
    end
end
end