function [mc_count] = determine_mc_count(actions_size, mc_baseline)
% This method determines the amount of times an action/step is conducted
% for a particular day.

mc_count = zeros(1,actions_size);

for i = 1:actions_size
    mc_count(1,i) = nnz(mc_baseline{1,1} == i);
end


end