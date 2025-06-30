function [day_max] = calculate_daily_control_max(mc_count_day,control_size_per_state, a_size)
% This function takes the control_size_per_state (which represents the number
% of controls per state) and then multiplies it against the number of
% instances that state appeared in that day. For example, if there are 10
% controls associated with state 1, and an agent was at state 1 five times,
% then there were a total of 50 (five * ten) opportunities for an agent to
% committ an incident.

for i = 1: a_size % This one works
    day_max(i,:) = mc_count_day(i,:).* control_size_per_state;
end


end