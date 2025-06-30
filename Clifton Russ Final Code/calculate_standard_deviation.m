%% This runs determines the standard deviiation 
iterations = 30;
actions = 4;
std_sum = zeros(iterations, actions);

for i = 1: iterations
    std_sum(i,:) = standard_Deviation_Simulation();
end
%%

std_mean = mean(std_sum);
%std_mean = std_sum(:,1)';
%%
%std_final = std(std_mean);
%%
%std_mean = mean(std_sum(:,1));

std_final = std(std_mean);
%{
%% Group 1 information
std_group_1 = std_final;
std_group_1_mean = std_mean;
%% Group 2 information
std_group_2 = std_final;
std_group_2_mean = std_mean;
%% Group 3 information
std_group_3 = std_final;
std_group_3_mean = std_mean;
%% Group 4 information
std_group_4 = std_final;
std_group_4_mean = std_mean;
%% Group 5 information
std_group_5 = std_final;
std_group_5_mean = std_mean;
%% Individual Compliance information
std_group_IC_1 = std_final;
std_group_IC_mean_1 = std_mean;
%% Individual Compliance information
std_group_IC_2 = std_final;
std_group_IC_mean_2 = std_mean;
%}
%{
%% 50 agents
%std_group_50_agents = std_final;
%std_group_50_agents_mean = std_mean;

%% 100 agents
%std_group_100_agents = std_final;
%std_group_100_agents_mean = std_mean;

%% 150 agents
%std_group_150_agents = std_final;
%std_group_150_agents_mean = std_mean;
%% 200 agents
%std_group_200_agents = std_final;
%std_group_200_agents_mean = std_mean;
%% 250 agents
%std_group_250_agents = std_final;
%std_group_250_agents_mean = std_mean;
%}
%% Individual vs average

%%
%load("std_results.mat");
%%
save("std_results.mat")