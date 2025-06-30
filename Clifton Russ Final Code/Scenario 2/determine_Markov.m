function [markov, mc_steps, mc_sim] = determine_Markov(action_counter)

% listed states: walking/talking (offline [1]), work (online/offline [2]), 
% email (online [3]),internet surfing (online[4])


%% Create 5 x5 Markov chain
% After the initial random run of actions, 4 additional runs will take
% place with values +/- 10% of the initial run. Collectively, this will
% create the square matrix necessry for Markov Chain. 
agent_actions = zeros(5,5);
agent_actions(1,:) = action_counter;



for i = 1:5
    for j = 2:5
        min = action_counter(1,i)-(.1*action_counter(1,i));
        max = action_counter(1,i)+(.1*action_counter(1,i));
        agent_actions(j,i) = round(min + (max-min).*rand(1,1));
         
    end
end

%%
markov = dtmc(agent_actions); %creates markov chain from random matrix
%%  markov chain percentages

%markov_percentages = markov.actions;
 
%% Label State names
markov.StateNames = ["Working" "Walking" "Emailing" "Web Browsing" "other"];

%% view

figure;
graphplot(markov, 'ColorEdges', true);

%%
% the overall steps is determined by taking the average of all the actions
mc_steps = round(sum(mean(agent_actions))); 
%mc_steps = 10;
%mc_sim = simulate(markov, mc_steps);
x0 = [0,1,0,0,0];
mc_sim = simulate(markov, mc_steps, 'X0',x0);

%%
figure;
simplot(markov,mc_sim);
set(gca,'YTickLabel',[]);
end