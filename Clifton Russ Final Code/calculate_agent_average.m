function [vuln_agent_average] = calculate_agent_average(people, vuln_size )
% This function calculates the average scores for each of the
% vulnerabilities of the people/agents.
vuln_agent_average = zeros(1,vuln_size);


%This section extracts all the specific vulnerability scores into one
%matrix to be used in further calculations.
temp = toArray(people(:,3),vuln_size);

for i = 1: vuln_size
    vuln_agent_average(1,i) = mean(temp(:,i));
end

end