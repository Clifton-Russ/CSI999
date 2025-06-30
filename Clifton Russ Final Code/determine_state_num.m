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
% and 28%
min_max(1,1)= .20;%.10;
min_max(2,1)= .28;
actions(1,1)= min_max(1,1) + (min_max(2,1)-min_max(1,1)).*rand(1,1);
%%
% For any person, web-surfing is between 5% to 10%

min_max(1,2)= .10; %.05;
min_max(2,2)=.20; %.1;
actions(1,2)= min_max(1,2) + (min_max(2,2)-min_max(1,2)).*rand(1,1);
%%
% For any agent, mobile phone is between 10% to 33% at 10 minute intervals
min_max(1,3)= .20;%.10;
min_max(2,3)= .33;
actions(1,3)  = abs(min_max(1,3) + (min_max(2,3)-min_max(1,3)).*rand(1,1));
%%
% For any agent, Messenger is beetween 10% to 25%
min_max(1,4)= .20;%.10;
min_max(2,4)= .25; 
actions(1,4)= min_max(1,4) + (min_max(2,4)-min_max(1,4)).*rand(1,1);

%%
% For any agent, non phishing activities is between 10% to 65%

min_max(1,5)= .10; %.10;
min_max(2,5)= (1 - (actions(1,1) + actions(1,2) + actions(1,3) + actions(1,4)))*2.5;
%if min_max(2,5) < .1
    %min_max(2,5) = .1;
actions(1,5)= min_max(1,5) + (min_max(2,5)-min_max(1,5)).*rand(1,1);


%% transitions decimal to integer
actions = round(actions*100);
%}

end