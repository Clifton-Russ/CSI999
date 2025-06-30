%% Determine compliance for each person and activity

% A user's compliance score is inversely related to their vulnerability
% score. A compliance score represents how compliant a user is with following
% rules. A higher compliance score means that the user is more likely
% compliant with all requirements. A threat score represents the 
% likelihood of a user doing an action that would result to an incident or
% breach. Therefore, the higher the compliance score, the lower the
% threat score. The compliance comes from the user variable 


function [agent_threat] = determine_agent_threat2(compliance, threat_size)

% This determines the agent threat score by subtracting the compliance
% value from "1". Then a random (uniform distribution) weight is either
% added or subtracted to the threat. This creates different values for each
% activity.

agent_threat = zeros(1,threat_size);



for i = 1: threat_size
    xmin = .01;
    xmax = .05;
    temp = randi([0 1],1,1);
    weight = xmin + (xmax-xmin).*rand(1,1);
    
    if temp == 0
        agent_threat(1,i) = (1-compliance) + weight;
    else
        agent_threat(1,i) = (1-compliance) - weight;
    end

    %}
end