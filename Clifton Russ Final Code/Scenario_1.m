%% Scenario 1: Trial 1 (Adjusting Agent Compliance)
% Activity 1 input: 
% This section demonstrates multiple observations of activity

a_size_total = 10;% Number of agents
days = 50; % Number of days
actions_size = 5; % Number of actions (steps)
incident_threshold = .038; 
agent_compliance_average = [.60, .65, .70, .75, .80, .85, .90, .95];
agent_compliance_size = size(agent_compliance_average,2);
observation_size = 1; %30;  
phish_report_rate = .60;
click_percent_step_mean = cell(observation_size, agent_compliance_size);
report_rate = cell (observation_size,agent_compliance_size);
markov = cell(a_size_total,agent_compliance_size);
scenario = "1a"; % This is the trigger to use the variables for Scenario 1a.
transition_matrix = cell(a_size_total, agent_compliance_size);
%% Scenario 1: Trial 1 (Multilple iterations of all the click rates)
% This section creates multiple observations of all of the activities. This
% uses 'create_suborganization2' which provides additional output variables
% that can be later used for Scenario 3. 

%In order to provide a graph that demonstrates changes in clickrates for
%each compliance score, this function takes in specific compliance average
%scores. This ensures that each agent has a compliance score within the
%expected compliance range, e.g. (60,70,80,90). Without this, agents would
%be free to have any score which makes it difficult to analyze the rates of
%change.
for i = 1:observation_size
    for j = 1:agent_compliance_size
        [click_percent_step_mean{i,j},report_rate{i,j}, markov{i,j}, transition_matrix{i,j}, e_thresholds_daily{i,j}, ...
            vuln_controls{i,j}, incident_input{i,j}, vuln_breach{i,j}, vuln_incident_total{i,j}] = ...
            create_suborganization2(a_size_total, days, agent_compliance_average(1,j), incident_threshold, phish_report_rate, scenario);
    end
end

  %% Scenario 1: Trial 1 (Reorganization of observations)

% This section reorganizes the data to create a cell data structure, where
% each entry represents click rates for each agent compliance score

agent_click = cell(1,agent_compliance_size);
temp2 = [];
for i = 1:observation_size
    for j = 1:agent_compliance_size
        temp = cell2mat(click_percent_step_mean(i,j));
        temp2 = [temp2;temp];     
    end
    agent_click{1,i} = temp2;
    temp2 = [];
end
%}
%% Scenario 1: Trial 1 (Activity 1 click rates)
% This section separates all the activity 1 click rates 
activity_1 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_1(:,i) = agent_click{1,i}(:,1);
end
%% Scenario 1: Trial 1 (Activity 2 click rates)
% This section separates all the activity 2 click rates 
activity_2 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_2(:,i) = agent_click{1,i}(:,2);
end
%% Scenario 1: Trial 1 (Activity 3 click rates)
% This section separates all the activity 3 click rates 
activity_3 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_3(:,i) = agent_click{1,i}(:,3);
end
%% Scenario 1: Trial 1 (Activity 4 click rates)
% This section separates all the activity 4 click rates 
activity_4 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_4(:,i) = agent_click{1,i}(:,4);
end
%% Scenario 1: Trial 1 (Graph Activity points)
click_size = size(agent_click,2);
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];

for i = 1:click_size
    plot(agent_comp',activity_1(:,i), "red");
    plot(agent_comp',activity_2(:,i), "blue");
    plot(agent_comp',activity_3(:,i), "green");
    plot(agent_comp',activity_4(:,i), "black");
    hold on
end
title("Agent Click Rate  (All Activities x30)")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Checking Email', 'Web-Surfing', 'Mobile Phone')
hold off
%% Scenario 1: Trial 2a (Sensitivity to Safeguard Compliance)
% This section changes the scenario value to "1b" which uses a different
% set of control compliance values. Secnario 1b changes 3 failing values to
% 3 low passing scores.
a_size_total = 10;
days = 50;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1b";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_Scenario1_Trial_2a = click_percent_step_mean;

%% Scenario 1: Trial 2b Sensitivity to Safeguard Compliance (0.0 to 0.24)
% This section changes the scenario value to "1b2" which uses a different
% set of control compliance values. Secnario 1b2 changes all environmental
% scores to be within the range of 0 to .24.

scenario = "1b2";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1b2
click_Scenario1_Trial_2b = click_percent_step_mean;
%% Scenario 1: Trial 2c Sensitivity to Safeguard Compliance (0.25 to 0.49)
% This section changes the scenario value to "1b3" which uses a different
% set of control compliance values. Secnario 1b2 changes all environmental
% scores to be within the range of .25 to .49.

scenario = "1b3";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1b3
click_Scenario1_Trial_2c = click_percent_step_mean;
%% Scenario 1: Trial 2d Sensitivity to Safeguard Compliance (0.50 to 0.79)
% This section changes the scenario value to "1b4" which uses a different
% set of control compliance values. Secnario 1b2 changes all environmental
% scores to be within the range of .50 to .79.

scenario = "1b4";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1b4
click_Scenario1_Trial_2d = click_percent_step_mean;
%% Scenario 1: Trial 2e Sensitivity to Safeguard Compliance (0.50 to 0.99)
% This section changes the scenario value to "1b5" which uses a different
% set of control compliance values. Secnario 1b2 changes all environmental
% scores to be within the range of .50 to .99.

scenario = "1b5";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1b5
click_Scenario1_Trial_2e = click_percent_step_mean;
%% Scenario 1: Trial 3 Sensitivity to Number of Agents
% This section compares the click rates for the various sizes of people
%% Scenario 1: Trial 3a Sensitivity to Number of Agents (50 people)
% This scenario tests the click rate for 50 people
a_size_total = 50;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_50_people = click_percent_step_mean;
%% Scenario 1: Trial 3b Sensitivity to Number of Agents (100 people)
% This scenario tests the click rate for 100 people

a_size_total = 100;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_100_people = click_percent_step_mean;
%% Scenario 1: Trial 3c Sensitivity to Number of Agents (150 people)
% This scenario tests the click rate for 150 people

a_size_total = 150;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_150_people = click_percent_step_mean;
%% Scenario 1: Trial 3d Sensitivity to Number of Agents (200 people)
% This scenario tests the click rate for 200 people

a_size_total = 200;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_200_people = click_percent_step_mean;
%% Scenario 1: Trial 3e Sensitivity to Number of Agents (250 people)
% This scenario tests the click rate for 250 people

a_size_total = 250;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_250_people = click_percent_step_mean;
%% Scenario 1: Trial 4a Individual vs Average Agent Score (Average score -70%)
% This calculates the clickrate that represents an organization's 
% assessment of the organization risk without having specific risk files on
% each individual. This one uses the default click rate of .7.

a_size_total = 50;
days = 50;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";


[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using one predefined clickrate (70%)
group_compliance_70 = click_percent_step_mean;
%% Scenario 1: Trial 4b :Individual vs Average Agent scores (Individual Scores)

%This calculates the clickrate from taking individual scores. This 
% represents the knowledge of individual risk scores.
a_size_total = 50;
days = 50;
incident_threshold = .038;
phish_report_rate = .65;

scenario = "1d";
%agent_compliance_average = .7;
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using the mean of individual scores 
individual_compliance = click_percent_step_mean;

%% Scenario 1 : Trial 4c :Individual vs Average Agent scores (Mean of Individual Scores)

%This calculates the clickrate from taking individual scores. This 
% represents the knowledge of individual risk scores.
a_size_total = 50;
days = 50;
incident_threshold = .038;
phish_report_rate = .65;

scenario = "1d2";

[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days,[], incident_threshold, phish_report_rate, scenario);


% This saves the clickrate for using the mean of individual scores 
individual_compliance_mean = click_percent_step_mean;

%% Scenario 1 : Trial 4d (Average Agent Score - 80%)
% This calculates the clickrate that represents an organization's 
% assessment of the organization risk without having specific risk files on
% each individual. This one uses the defualt click rate of .8.

a_size_total = 50;
days = 50;
agent_compliance_average = .8;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";


[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using one predefined clickrate (80) 
group_compliance_80 = click_percent_step_mean;
%% %% Scenario 1 : Trial 4e (Average Agent Score - 60%)
% This calculates the clickrate that represents an organization's 
% assessment of the organization risk without having specific risk files on
% each individual. This one uses the defualt click rate of .6.

a_size_total = 50;
days = 50;
agent_compliance_average = .6;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";


[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using one predefined clickrate (60%)
group_compliance_60 = click_percent_step_mean;
%% Scenario 1: Trial 4 Results
group_compliance_60
group_compliance_70
group_compliance_80
individual_compliance
individual_compliance_mean

disp("Each column represents the click rate at a particular activity.")
disp("This demonstrates that it is possible to estimate the compliance " + ...
    "without knowing the specific individual scores");
