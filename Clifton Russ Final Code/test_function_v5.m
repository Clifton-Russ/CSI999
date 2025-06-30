%%
a_size_total = 10;% Number of agents
days = 50; % Number of days
actions_size = 5; % Number of actions (steps)
incident_threshold = .038; 
agent_compliance_average = [.60, .65, .70, .75, .80, .85, .90, .95];
agent_compliance_size = size(agent_compliance_average,2);
observation_size = 30; %30;
phish_report_rate = .60;
click_percent_step_mean = cell(observation_size, agent_compliance_size);
report_rate = cell (observation_size,agent_compliance_size);
markov = cell(a_size_total,agent_compliance_size);
%mc_baseline = cell(a_size_total, agent_compliance_size);
scenario = "1a"; % This is the trigger to use the variables for Scenario 1a.
%scenario = "1d2";
safeguard_controls = "SC_1";
%safeguard_controls = "SC_2";
%safeguard_controls = "SC_3";
%safeguard_controls = "SC_4";
%safeguard_controls = "SC_5";
%safeguard_controls = "SC_6";
transition_matrix = cell(a_size_total, agent_compliance_size);
%%
% This function creates an organization with agents, compliance scores
% incidents and click rate. This function is used in various ways, so some
% of the attributes are not always used.


% The vuln_size represents the number of vulnerability types being
% assessed. In this instance, the model is only assessing controls related
% to phishing. Therefore, the vuln_size is only 1. If the model were to
% also assess controls for another vulnerability, i.e., "unauthorized
% access", the vuln_size would be 2. There would be a separate set of
% controls specifically for "unauthorized access" to include any
% overlapping controls.
vuln_size = 1; 
threat_size = 4;
people = create_agent(1,a_size_total,threat_size);
%people = create_agent2(1,a_size_total,agent_compliance_average(1,3),threat_size);

%% Taking the mean of agents' overall compliance
%This is done to simulate assessing an organization's compliance. In
%practice, people do not come with compliance scores. While it is possible
%to create a risk profile based on historical information, the more
%practical solution is to assess the organization as a whole with any
%exceptions.

if scenario =="1d2"
    actions_size = threat_size +1;
    for i = 1:a_size_total
        temp(i,:) = people{i,3}(1,:);
    end

agent_compliance_threat = mean(temp,1);

end

%agent_compliance_threat = [ .5, .5, .5, .5];
%% This determines which e_threshold data to use based on the current state

a_size = size(people,1); % This counts the number of agents

% This creates the data structure for the Markov Chain used to determine
% the steps for each agent
mc_baseline = cell(a_size, days);
markov = cell(a_size, days);
% This creates the data structure for the control compliance scores. The
% word "daily" represents the daily change of control compliance. The
% letter "e" is short for environment. The thresholds represent how
% each control is assessed. The more compliant the control, the higher the
% score.
e_thresholds_daily = cell(1,days); 

% This creates the data structure to hold the values (1 or 0) for each
% agent as it conducts each action. Only certain
% controls are applicable at each activity. In this instant, there are only
% four actions. When an agent conducts an activity, there is a
% comparison between the agent's compliance score and each of the
% environment control compliance scores. If the agent's score is higher
% than the environment score, the value is "1". If the control compliance
% score is higher, the value is "0". "0" represents that the control
% compliance is greater than the threat from the agent and there is no
% incident. "1" represents that the agent's threat is greater than the
% control's protection and there is a risk for an incident.


%%  Creates the baseline for the actions for each agent
% This double for loop traverses through each agent in each day.
for i = 1:a_size
    for j = 1: days


%% Creates the baseline for the actions for each agent

        %Tests Determine state num
        % This section tests the function to determine the amount of states that
        % an agent transitions through in a single day.
        % Each action represents a particular state that an agent will be in during
        % the work day. In this instance, there will only be four different
        % actions: 1. Checking email. 2. Web-Surfing 3. Mobile Phone 4.
        % Messenger The dimensions for "actions" will depend on the number
        % compliance of predefined actions that an agent can take.
        actions = zeros(1,5);
        actions_size = size(actions,2);


        %min_max represents minimum and maximum values of a range that an agent
        %will spend a percentage of their time doing a particular action in a
        %single day. 
        min_max = zeros (2,actions_size);

        % This section determines the initial amount of actions an agent has in one
        % day
        actions_initial = determine_state_num(actions,min_max);

        %% Determine initial transition Matrix

        [~, transition_matrix] = create_adjusted_baseline(actions_initial);
%% Normalize the data
% This section normalizes the data to be a percentage of 100%.


temp = sum(transition_matrix,2); %Determine the sum of each row
temp = transition_matrix./temp; % Determines the percentage
transition_matrix = round(temp*100);
        
%% Define the attribute selection {Vulnerability 1; Phishing}
% This version of attribute selection is based on all related controls for
% a specific vulnerability for each node. This means if an agent has 4
% possible nodes to visit, each node will have a set of controls related to
% possible vulnerabilities associated to the activity that the node
% represents.  The code will only check incidents for one vulnerability at
% a time. For example, attribute_selection{1,1] represents "checking email"
% therefore, all the values represent the compliance scores for each
% control. 

if safeguard_controls == "SC_1"
        attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.2794	0.8515	0.1927	0.4408	0.3012	0.4337	0.6506	0.1113	0.9116	0.5382	0.7268	0.9319];
        attribute_selection{2,1} = [0.2627	0.9236	0.2256	0.8874	0.9704	0.6219	0.0594	0.8320	0.9027	0.2413	0.2485	0.9522	0.9133	0.9590	0.6195	0.5221	0.9292];
        attribute_selection{3,1} = [0.8301	0.5968	0.4735	0.3535	0.8294	0.6103	0.9183	0.4613	0.9714	0.6175	0.1196	0.3128	0.0605];
        attribute_selection{4,1} = [0.6030	0.7088	0.1658	0.9182	0.7916	0.5152	0.9256	0.4979	0.7753	0.6819	0.7310	0.2591	0.4423];
        attribute_selection{5,1} = [];

        %attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.7794	0.8515	0.7927	0.4408	0.3012	0.4337	0.6506	0.7113	0.9116	0.5382	0.7268	0.9319];
end

if safeguard_controls == "SC_2"
    xmin = .0;
    xmax = .24;
    
    for m = 1:threat_size
        attribute_selection{m,1}= xmin + (xmax-xmin).*rand(1,15);
    end

        attribute_selection{5,1} = [];
end


if safeguard_controls == "SC_3"
    xmin = .25;
    xmax = .49;
    
    for m = 1:threat_size
        attribute_selection{m,1}= xmin + (xmax-xmin).*rand(1,15);
    end

        attribute_selection{5,1} = [];
end

if safeguard_controls == "SC_4"
    xmin = .50;
    xmax = .74;
    
    for m = 1:threat_size
        attribute_selection{m,1}= xmin + (xmax-xmin).*rand(1,15);
    end

        attribute_selection{5,1} = [];
end

if safeguard_controls == "SC_5"
    xmin = .75;
    xmax = .99;
    
    for m = 1:threat_size
        attribute_selection{m,1}= xmin + (xmax-xmin).*rand(1,15);
    end

        attribute_selection{5,1} = [];
end

if safeguard_controls == "SC_6"
    xmin = .10;
    xmax = .95;
    
    for m = 1:threat_size
        attribute_selection{m,1}= xmin + (xmax-xmin).*rand(1,15);
    end

        attribute_selection{5,1} = [];
end
%}
%%
        %e_size = size(e_thresholds,2);
        % The control size is defined for each vulnerability. This 
        % assessment will focus on all the controls
        % relevant to the vulnerability regardless of the control family.
        control_size = zeros(actions_size,vuln_size);
        for m = 1: actions_size
             control_size(m,1) = size(attribute_selection{m,1},2);
        end

     
%% Slight change of environment control scores
% This creates and holds the environment compliance controls for each day.
% Each day, each control can vary up to +/-15%. This simulates the subtle
% changes a control compliance can change daily.

temp = cell(actions_size,vuln_size);
for k = 1:days
   for P = 1:actions_size
        for Q = 1:vuln_size
            temp{P,Q} = create_control_vuln(attribute_selection(P,1), control_size(P,Q));
        end
   end
    e_thresholds_daily{1,k} = temp;
end

%% Creates mc_baseline
   % This section takes the transition_matrix and applies the markov chain to
   % determine the transitions for each agent for each day. This model
   % outlines the daily paths for each agent before the agent does them.
   % Once the daily paths are created, the agent traverses through the
   % paths.
        [mc_temp, markov_temp] = create_mc_baseline(transition_matrix);
        mc_baseline{i,j} = mc_temp;
        markov{i,j} = markov_temp;

   end
end
%% For loop for determine_mc_count
%This creates the data structure to hold the number of actions each agent
%did each day.
mc_count = cell(a_size,days);

% This counts the number of times each agent does each activity each day
for i = 1: a_size
    for j = 1: days
        mc_count{i,j} = determine_mc_count(actions_size, mc_baseline(i,j));
    end
end

%% This partitions the mc_count into individual values
% The variable mc_count consolidates all the action for each agent for
% each day. The variable mc_count_day separates the activity values to
% allow for easier computation.

mc_count_day = cell(1,days);

for i = 1:days
    mc_count_day{1,i} = cell2mat(mc_count(:,i));
end

%% Determine mc_count per agent
% This calculates the total number of actions for each agent, inclusive of
% all days.
 mc_count_agent = cell(a_size,1);
for i = 1: a_size
    mc_count_agent{i,1} = determine_mc_count_agent(mc_count, days, actions_size,i);
end

%% Determine mc_count per day
% This calculates the total number of all actions for all agents for each
% day.
mc_count_total = cell(1,days);
for i = 1: days
    mc_count_total{1,i} = sum(cell2mat(mc_count_day(1,i)));
end
%% Calculate total steps for the year
% this calculates the total times that all agents did each activity.
mc_count_total_sum = zeros(1,actions_size);
for i = 1: days
    mc_count_total_sum = mc_count_total_sum +mc_count_total{1,i}(1,:);
end
%% 
% Calculate the total amount of transitions per person each day
steps = zeros(1,zeros);
for i = 1: a_size
    for j = 1:days
        steps(i,j) = size(mc_baseline{i,j},1);
    end
end

%%

%In the event this model were to use several vulnerabilities (other than
%phishing, the vuln_idx variable would identify which vulnerability is
%calculated. This was originally developed to support several
%vulnerabilities, but now it is only focused on one, phishing.
vuln_idx = 1;

%This creates the data structure to hold the vuln_1 scores.
vuln_controls = cell(a_size, days);
vuln_exploits = cell(a_size,days);
incident_input = cell(a_size,days);
vuln_breach_total = cell(a_size,days);
    for i = 1:a_size
        for j = 1: days
              [vuln_controls{i,j}, incident_input{i,j}, vuln_exploits{i,j}, ~] = determine_state_vuln8(people{i,3}(1,:), mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
             
             % This section uses an average compliance score as opposed to
             % individual scores
             if scenario == "1d2"
                
                [vuln_controls{i,j}, incident_input{i,j}, vuln_exploits{i,j}, ~] = determine_state_vuln8(agent_compliance_threat, mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
             end
        end
    end

%% This calculates the total amount of exploits
exploit_total = cell(a_size,days);

for i = 1:a_size
    for j = 1:days
        exploit_total{i,j} =  calculate_breach_total(vuln_exploits{i,j},threat_size);
    end
end
%% Determines the total number of exploits per agent

exploit_per_agent = cell(a_size,1);
for i = 1: a_size
        exploit_per_agent{i,1} = determine_mc_count_agent2(exploit_total, days, threat_size,i);
end
%%
%
%% Calculates the incident opportunity per day
incident_opportunity_per_day = cell(1,days);
control_size = [15;17;13;13;0];
for i = 1: days
    incident_opportunity_per_day{1,i} = sum(cell2mat(mc_count_day(1,i)).*control_size(:,1)',1);
end
%% Calculate the exploits per day
exploit_per_day = cell(1,days);
temp = cell(1,threat_size);
for i = 1: days
    for j = 1:a_size
        temp = toArray(exploit_total(j,i),threat_size);
        exploit_per_day{1,i} = [cell2mat(exploit_per_day(1,i));temp];
    end
    exploit_per_day{1,i} = sum(exploit_per_day{1,i},1);
end

%% removes the last action
for i = 1: days
    %temp = incident_opportunity_per_day{1,i}(1,5);
    temp = incident_opportunity_per_day{1,i}(1,:);
    temp(5)=[];
    incident_opportunity_per_day{1,i} = temp;
end

%% Calculate the daily click rate
daily_click_rate= cell(1,threat_size);
for i = 1: days
   daily_click_rate{1,i} = cell2mat(exploit_per_day(1,i))./cell2mat(incident_opportunity_per_day(1,i));
end

%% Stack the clickrate
total_click_rate = [];
temp = [];
for i = 1: days
    temp= cell2mat(daily_click_rate(1,i));
    total_click_rate = [total_click_rate; temp];
end


%% Plots daily click rate
n = 1:days;
for i = 1:days
    plot(n',total_click_rate(:,1), "red");
    hold on
    plot(n',total_click_rate(:,2), "blue");
    hold on
    plot(n',total_click_rate(:,3), "green");
    hold on
    plot(n',total_click_rate(:,4), "black");
    hold on
end
title("Daily Agent Click Rate  (50 days)")
xlabel('Days')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Checking Email', 'Web-Surfing', 'Mobile Phone')
hold off
%}
%% Total amount of opportunities for an incident (or click)
incident_opportunity = cell2mat(mc_count_agent).*control_size(:,1)';
%% Remove the last column ("other")
incident_opportunity(:,5) = [];
%% Determine the click rate 
click_percent_step = cell2mat(exploit_per_agent)./incident_opportunity;
%% Determine the mean click rate
click_percent_step_mean = mean(click_percent_step,1);