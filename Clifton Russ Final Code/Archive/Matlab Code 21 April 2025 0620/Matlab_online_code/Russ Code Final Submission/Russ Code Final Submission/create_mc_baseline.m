function [mc_baseline] = create_mc_baseline(actions_baseline)
mc = dtmc(actions_baseline); %creates markov chain from the actions baseline

%% Label State names
mc.StateNames = ["Emailing" "Web Browsing" "Text Messaging" "Phone Calling"];
%% Conduct simulation
mc_sum = sum(actions_baseline,2);% Calculates the total steps 
mc_steps = round(mean(mc_sum,1)); % determines the average steps a day

mc_baseline = simulate(mc, mc_steps);%simulates the steps for each day



end