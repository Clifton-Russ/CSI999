%%
% This function creates an agent with the corresponding attributes. These
% agents are considered "reasonable" where some agents might follow most 
% rules while some might not. However, these agents do not include
% malicious actors
%%
function [people] = create_agent2(start, stop,compliance_score,threat_size)
%start is the number from where the forloop starts in the event there is a
%need to add additional agents without overwriting previous agents' ID
% num 
people = cell(stop,3);

% This value is used to ensure that the agent threat is feasible to use
% against the safeguard compliance controls and yield the desired click
% rate.


for i = start: stop

    %In this iteration, agents are given a base compliance score to view
    %trend analysis


    people{i,1} = i; % assigns unique PID
    people{i,2} = compliance_score;  %assigns compliance score
    % determines the agent's threat score
    people{i,3} = determine_agent_threat2(people{i,2},threat_size);
  
end

end