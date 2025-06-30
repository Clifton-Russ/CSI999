function [by_agent_sum, by_agent_graph] = determine_by_agent(vuln_breach_total, a_size,type)

% This summarizes all the incidents by the person
by_agent_sum = zeros(a_size,1);
for i = 1: a_size
    by_agent_sum(i,1) = sum([vuln_breach_total{i,:}]);
end

%%
if type == 1
by_agent_graph = bar(by_agent_sum);
title("Total clicks by the person (" + a_size + " people)")
xlabel('Person ID')
ylabel('Clicks')
set(gcf, 'Name', 'By the Agent')
end
if type == 2
by_agent_graph = bar(by_agent_sum);
title("Total clicks by the person (" + a_size + " people)")
xlabel('Person ID')
ylabel('Breaches')
set(gcf, 'Name', 'By the Agent')
end
end