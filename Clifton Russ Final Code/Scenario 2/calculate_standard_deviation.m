%% This runs determines the standard deviiation 
iterations = 30;
actions = 4;
reduction_sum = zeros(iterations, actions);
%increase_rate = [];
temp = cell(iterations, 1);

for i = 1: iterations
    [reduction_sum(i,:), temp{i,1}] = standard_Deviation_Simulation();
end
%% Convert increase rate to matrix
temp2 = [];
for i = 1: iterations
    temp2 = cell2mat(temp(i,1));
    increase_rate_sum = [increase_rate_sum; temp2];
end
%% Determine mean 
reduction_mean = zeros(1,actions);
increase_mean = zeros(1,actions);

for i = 1: iterations
    
    reduction_mean(1,i) = mean(reduction_sum(i,:));
    increase_mean(1,i) = mean(increase_rate_sum(:,i));
end
%% Determine STD
reduction_std = zeros(1,actions);
increase_std = zeros(1,actions);
for i = 1:actions
    reduction_std(1,i) = std(reduction_sum(:,i));
    increase_std(1,i) = std(increase_rate_sum(:,i));
end
%%
reduction_mean = mean(reduction_sum);
increase_mean = mean(increase_rate_sum);
%std_mean = std_sum(:,1)';
%%
reduction_std = std(reduction_mean);
increase_std = std(increase_mean);

%%
%save("std_results2.mat")