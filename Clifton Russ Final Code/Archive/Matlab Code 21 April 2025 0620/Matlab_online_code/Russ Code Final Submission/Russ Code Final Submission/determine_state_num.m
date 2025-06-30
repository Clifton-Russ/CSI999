function [actions] = determine_state_num(actions, min_max)
%This functions takes input of min_max which outlines the minimun
%and maximum ranges for an agent's actions. For example, if the percentage
%range for an agent to check email is 10 (min) and 20 (max), this means the
%agent will spend at least 10% of the time checking their email, not to
%exceed 20%. This function allows for overlap to ensure that each agent has
%sufficient transitions within a day and to offset the amount of daily
%actions.
%   
%%

% For any person, checking email is  between 10%
% and 50%
min_max(1,1)=.4;
min_max(2,1)=.8;
actions(1,1)= min_max(1,1) + (min_max(2,1)-min_max(1,1)).*rand(1,1);
%%
% For any person, web-surfing is between .5% to 20%
min_max(1,2)=.05;
min_max(2,2)=.2;
actions(1,2)= min_max(1,2) + (min_max(2,2)-min_max(1,2)).*rand(1,1);
%%
% For any agent, mobile phone is between 10% to 50%
min_max(1,3)= .1;
min_max(2,3)= .5;
actions(1,3)  = abs(min_max(1,3) + (min_max(2,3)-min_max(1,3)).*rand(1,1));
%%
% For any agent, Messenger is beetween 0.5% to 15%
min_max(1,4)= .05;
min_max(2,4)= .15; 
actions(1,4)= min_max(1,4) + (min_max(2,4)-min_max(1,4)).*rand(1,1);

%% transitions decimal to integer
actions = round(actions*100);

end