function [mc_baseline, mc] = create_mc_baseline(transition_matrix)
mc = dtmc(transition_matrix); %creates markov chain from the actions baseline

%% Label State names
mc.StateNames = ["Email" "Web Browsing" "Mobile Phone" "Messenger App" "Other"]; 
%% Conduct simulation
%mc_sum = sum(transition_matrix,2);% Calculates the total steps 
%mc_steps = round(mean(mc_sum,1)); % determines the average steps a day

% When using this the transition matrix, the average will yield 100 as each
% row sums to 100%. 
mc_steps = 100; 

mc_baseline = simulate(mc, mc_steps);%simulates the steps for each day



end