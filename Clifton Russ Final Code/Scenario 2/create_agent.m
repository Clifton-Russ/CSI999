%%
% This function creates an agent with the corresponding attributes. These
% agents are considered "reasonable" where some agents might follow most 
% rules while some might not. However, these agents do not include
% malicious actors
%%
function [people] = create_agent(start, stop,vuln_size)
%start is the number from where the forloop starts in the event there is a
%need to add additional agents without overwriting previous agents' ID
% num 
people = cell(stop,3);

xmin=.6; % the compliance floor score
xmax=.95; % the compliance ceiling  score



for i = start: stop

    %this creates a random compliance score between the floor and ceiling
    %values
compliance_score = xmin + (xmax-xmin).*rand(1,1);

    people{i,1} = i; % assigns unique PID
    people{i,2} = compliance_score;  %assigns random compliance score
    % determines the agent's threat score
    people{i,3} = determine_agent_threat(people{i,2},vuln_size);
end

end