function [mc_count_agent] = determine_mc_count_agent(mc_count, days, actions_size,n)
% This function calculates all the mc_count for each agent for all days
mc_count_agent = zeros(1,actions_size);
for i = 1: days
    mc_count_agent = mc_count_agent + cell2mat(mc_count(n,i));
end
end