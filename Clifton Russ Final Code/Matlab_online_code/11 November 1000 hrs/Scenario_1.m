%% Scenario 1a Adjusting Agent Compliance
% Activity 1 input: 
% This section demonstrates multiple observations of activity

a_size_total = 10;% Number of agents
days = 50; % Number of days
actions_size = 4; % Number of actions (steps)
incident_threshold = .038; 
agent_compliance_average = [.60, .65, .70, .75, .80, .85, .90, .95];
agent_compliance_size = size(agent_compliance_average,2);
observation_size = 1; %20; % runs the simulation additional times 
phish_report_rate = .60; % for reference
click_percent_step_mean = cell(observation_size, agent_compliance_size);
report_rate = cell (observation_size,agent_compliance_size);

scenario = "1a"; % This is the trigger to use the variables for Scenario 1a.

%% Scenario 1a: Multilple iterations of all the click rates
% This section creates multiple observations of all of the activities
for i = 1:observation_size
    for j = 1:agent_compliance_size
        [click_percent_step_mean{i,j},report_rate{i,j}, ~, click_percent_daily_input] = ...
            create_suborganization(a_size_total, days, agent_compliance_average(1,j), incident_threshold, phish_report_rate, scenario);
    end
end

   %% Scenario 1a: Reorganization of observations

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
%% Scenario 1a: Activity1 click rates
% This section separates all the activity 1 click rates 
activity_1 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_1(:,i) = agent_click{1,i}(:,1);
end
%% Scenario 1a: Activity2 click rates
% This section separates all the activity 1 click rates 
activity_2 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_2(:,i) = agent_click{1,i}(:,2);
end
%% Scenario 1a: Activity3 click rates
% This section separates all the activity 1 click rates 
activity_3 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_3(:,i) = agent_click{1,i}(:,3);
end
%% Scenario 1a: Activity4 click rates
% This section separates all the activity 1 click rates 
activity_4 =zeros(agent_compliance_size,observation_size);
for i = 1:observation_size
    activity_4(:,i) = agent_click{1,i}(:,4);
end
%% Scenario 1a: Graph Activity points
click_size = size(agent_click,2);
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];

for i = 1: click_size
    plot(agent_comp',activity_1(i,1), "red");
    plot(agent_comp',activity_2(i,1), "blue");
    plot(agent_comp',activity_3(i,1), "green");
    plot(agent_comp',activity_4(i,1), "black");
    hold on
end

%{
for i = 1: click_size
    plot(agent_comp',activity_1(:,i), "red");
    plot(agent_comp',activity_2(:,i), "blue");
    plot(agent_comp',activity_3(:,i), "green");
    plot(agent_comp',activity_4(:,i), "black");
    hold on
end
%}

title("Agent Click Rate  (All Activities x20)")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Checking Email', 'Web-Surfing', 'Mobile Phone')

hold off
%% Scenario 1a2: Graph Activity points (daily)


days_axis = 1:days;
    for i = 1: days
        for j = 1: actions_size
            plot(days_axis,click_percent_daily_input(:,j));
            hold on
        end
    end
    title("Daily Click Rate  (" + actions_size + " steps)")
    xlabel('Day')
    ylabel('Click Rate Percentage')
    set(gcf, 'Name', 'By the Day click Rate')
    legend('Checking Email','Web-Surfing','Mobile Phone','Messenger')
    hold off


%% Scenario 1b Adjust Specific Environment Controls
% This calculates the the click rate with the default information below
a_size_total = 10;
days = 50;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_1a = click_percent_step_mean;
%% Scenario 1b Adjust Activity 1
% This section changes the scenario value to "1b" which uses a different
% set of control compliance values. Secnario 1b changes 3 failing values to
% 3 low passing scores.

scenario = "1b";
[click_percent_step_mean,~, ~,~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1b
click_1b = click_percent_step_mean;

%% Scenario 1b2
[~,click_percent_step] = ... 
    determine_daily_click_rate (a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

%% Scenarion 1c: Increase the size of the organziation
% This section compares the click rates for the various sizes of people
%% Scenario 1c: 50 people
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
click_1c_50 = click_percent_step_mean;
%% Scenario 1c: 100 people
% This scenario tests the click rate for 100 people

a_size_total = 100;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_1c_100 = click_percent_step_mean;
%% Scenario 1c: 150 people
% This scenario tests the click rate for 100 people

a_size_total = 150;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_1c_150 = click_percent_step_mean;
%% Scenario 1c: 200 people
% This scenario tests the click rate for 100 people

a_size_total = 200;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_1c_200 = click_percent_step_mean;
%% Scenario 1c: 250 people
% This scenario tests the click rate for 100 people

a_size_total = 250;
days = 25;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the click rate for scenario 1a with the default scores.
click_1c_250 = click_percent_step_mean;
%% Scenario 1d:Group score (70%)

a_size_total = 50;
days = 50;
agent_compliance_average = .7;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";

% This calculates the clickrate that represents an organization's 
% assessment of the organization risk without having specific risk files on
% each individual. This one uses the defualt click rate of .7.
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using one predefined clickrate (70%)
group_compliance_70 = click_percent_step_mean;
%% Scenario 1d:Individual vs Group scores (Mean of individual scores)

%This calculates the clickrate from taking individual scores. This 
% represents the knowledge of individual risk scores.
a_size_total = 50;
days = 50;
incident_threshold = .038;
phish_report_rate = .65;

scenario = "1d";

[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using the mean of individual scores 
individual_compliance_mean = click_percent_step_mean;

%% Scenario 1d2:Individual vs Group scores (individual scores)

%This calculates the clickrate from taking individual scores. This 
% represents the knowledge of individual risk scores.
a_size_total = 50;
days = 50;
incident_threshold = .038;
phish_report_rate = .65;

scenario = "1d2";

[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, [], incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using the mean of individual scores 
individual_compliance = click_percent_step_mean;



%% Scenario 1d:Group score (80%)

a_size_total = 50;
days = 50;
agent_compliance_average = .8;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";

% This calculates the clickrate that represents an organization's 
% assessment of the organization risk without having specific risk files on
% each individual. This one uses the defualt click rate of .8.
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using one predefined clickrate (80) 
group_compliance_80 = click_percent_step_mean;
%% Scenario 1d:Group score (60%)

a_size_total = 50;
days = 50;
agent_compliance_average = .6;
incident_threshold = .038;
phish_report_rate = .65;
scenario = "1a";

% This calculates the clickrate that represents an organization's 
% assessment of the organization risk without having specific risk files on
% each individual. This one uses the defualt click rate of .6.
[click_percent_step_mean,~, ~, ~] = ... 
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate, scenario);

% This saves the clickrate for using one predefined clickrate (60%)
group_compliance_60 = click_percent_step_mean;
%% Scenario 1d Results
group_compliance_60
group_compliance_70
group_compliance_80
individual_compliance
individual_compliance_mean

disp("Each column represents the click rate at a particular activity.")
disp("This demonstrates that it is possible to estimate the compliance " + ...
    "without knowing the specific individual scores");
