
%% This is a tester class that tests the functions of the program
% This class is for agent interaction
clc;clear;
%% Creates the control data
%run test_envi ronment.m;
num_control = 6;
%% This creates The agents
start = 1;
stop = 10;
vuln_size = 1;%3; 
people = create_agent(start,stop,vuln_size);
%% Taking the mean of agents' overall compliance
%This is done to simulate assessing an organization's compliance. In
%practice, people do not come with compliance scores. While it is possible
%to create a risk profile based on historical information, the more
%practical solution is to assess the organization as a whole with any
%exceptions.

temp = cell2mat(people(:,2));
%agent_compliance_average = mean(temp);
agent_compliance_average = .70;
%% Taking the mean of the agents' vulnerability threat scores

% This takes the mean of all the agent vulnerability threat scores to
% represent one score. This is done to simulate assessing an organization's
% compliance as there are typically no risk profiles on agents.

%vuln_agent_average = calculate_agent_average(people, vuln_size );
%% This determines which e_threshold data to use based on the current state

%mc_size = size(mc_baseline,1);
a_size = size(people,1); %agent size
days = 50;
%mc_incident = cell(a_size, days);
mc_baseline = cell(a_size, days);
agent_schedule = cell(a_size,days);
vuln_1 = cell(a_size, days);
e_thresholds_daily = cell(1,days); % environment thresholds

%%
for i = 1:a_size
    for j = 1: days


%%

        %Tests Determine state num
        % This function tests the function to determine the amount of states that
        % an agent transitions through in a single day.
        % Each action represents a particular state that an agent will be in during
        % the work day. In this instance, there will only be five different
        % actions: 1. Working on a product. 2. Checking email. 3. Email surfing 4.
        % walking 5. Other. The dimensions for "actions" will depend on the numberCM_compliance
        % of predefined actions that an agent can take.
        actions = zeros(1,4);
        actions_size = size(actions,2);

        %actions_size = size(actions_initial,2);


        %min_max represents minimum and maximum values of a range that an agent
        %will spend a percentage of their time doing a particular action in a
        %single day
        min_max = zeros (2,actions_size);

        % This section determines the initial amount of actions an agent has in one
        % day based on the predefined metrics
        actions_initial = determine_state_num(actions,min_max);

        
        % This sections takes the initial actions and creates additional actions to
        % create an nxn matrix to later be used for the Markov Chain


%% Determine initial transition Matrix

        [actions_baseline, transition_matrix] = create_action_baseline(actions_initial); 
%% Normalize the data
% This section normalizes the data to be a percentage of 100%.


temp = sum(transition_matrix,2); %Determine the sum of each row
temp = transition_matrix./temp; % Determines the percentage
transition_matrix = round(temp*100);
%%

        %actions_baseline = create_action_baseline(actions_initial);
        %actions_baseline = create_action_baseline(transition_data); 
        % Creates mc_baseline
        % This section takes the actions_baseline and applies the markov chain to
        % determine the transition rates
%% Define the attribute selection {Vulnerability 1; Phishing}
% This version of attribute selection is based on all related controls for
% a specific vulnerability for each node. This means if an agent has 4
% possible nodes to visit, each node will have a set of controls related to
% possible vulnerabilities associated to the activity that the node
% represents.  The code will only check incidents for one vulnerability at
% a time.
%%

 attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.2794	0.8515	0.1927	0.4408	0.3012	0.4337	0.6506	0.1113	0.9116	0.5382	0.7268	0.9319];
 attribute_selection{2,1} = [0.2627	0.9236	0.2256	0.8874	0.9704	0.6219	0.0594	0.8320	0.9027	0.2413	0.2485	0.9522	0.9133	0.9590	0.6195	0.5221	0.9292];
 attribute_selection{3,1} = [0.8301	0.5968	0.4735	0.3535	0.8294	0.6103	0.9183	0.4613	0.9714	0.6175	0.1196	0.3128	0.0605];
 %attribute_selection{4,1} = [0.6030	0.4088	0.4658	0.1182	0.2916	0.8152	0.9256	0.4979	0.7753	0.9819	0.3310	0.2591	0.0423];
 attribute_selection{4,1} = [0.6030	0.7088	0.7658	0.9182	0.7916	0.8152	0.9256	0.4979	0.7753	0.9819	0.7310	0.7591	0.9423];


%%
        %e_size = size(e_thresholds,2);
        % The control size is defined for each vulnerability. This version
        % is not differentiating control families, but specific controls.
        % In other words, the previous implementation separated the
        % controls by control family, which allowed to assess based on
        % certain controls. This assessment will focus on all the controls
        % relevant to the vulnerability regardless of the control family.
        control_size = zeros(actions_size,vuln_size);
        for m = 1: actions_size
             control_size(m,1) = size(attribute_selection{m,1},2);
        end

     
%% Slight change of environment control scores
% This needs to be updated to only update each day for each iteration. This
% currently updates the entire e thresholds all at once.

temp = cell(actions_size,vuln_size);
for k = 1:days
   for P = 1:actions_size
        for Q = 1:vuln_size
            temp{P,Q} = create_control_vuln(attribute_selection(P,1), control_size(P,Q));
        end
   end
    e_thresholds_daily{1,k} = temp;
end

%%
        % This calculates all the controls associated for each
        % vulnerability
      % [control_count, control_cell] = determine_control_count(e_thresholds,control_size);
%% This calls the "create e variable" function
    %variable = create_e_variable(e_thresholds, control_size, num_control,e_size);



%%
         %mc_temp = create_mc_baseline(actions_baseline);
         mc_temp = create_mc_baseline(transition_matrix);
         mc_baseline{i,j} = mc_temp;

   end
end

%% Create agent schedules with  time intervals

for i = 1: a_size
    for j = 1: days
     agent_schedule{i,j} = create_schedule(cell2mat(mc_baseline(i,j)));
    end
end
%% Update the Mc_baseline
% this prunes the mc_baseline based on their schedule

for i = 1:a_size
    for j = 1: days
         temp =  size(agent_schedule{i,j},1);
         mc_baseline{i,j}(temp+1: end) =[];
    end
end

%
%% For loop for determine_mc_count
mc_count = cell(a_size,days);
% This counts the number of stages per day
for i = 1: a_size
    for j = 1: days
        mc_count{i,j} = determine_mc_count(actions_size, mc_baseline(i,j));
    end
end

%% This stacks the number of stages
%temp = mc_count(:);
%% This converts the stack (cell) into an array
%mc_count = toArray(temp,actions_size);
%% Summarizes mc_count
%mc_count_total = sum(mc_count);
%% This partitions the count per person per day per step
% This puts together the total steps for each person
%mc_count_person = mat2cell(mc_count, a_size*ones(1,size(mc_count,1)/a_size), size(mc_count,2));
%% This partitions the count per day per day per step
% This puts together the total steps for each day

mc_count_day = cell(1,days);

for i = 1:days
    mc_count_day{1,i} = cell2mat(mc_count(:,i));
end

%% Determine mc_count per agent

 mc_count_agent = cell(a_size,1);
for i = 1: a_size
    mc_count_agent{i,1} = determine_mc_count_agent(mc_count, days, actions_size,i);
end
%% Determine mc_count per day
%{
 mc_count_day2 = cell(1,days);
 temp = cell(1,days);
for i = 1: days
    temp{1,i} = determine_mc_count_day(mc_count, a_size, actions_size,i);
    mc_count_day2{1,i} =  sum(cell2mat(temp(1,i)),1);
end
%}
%%
mc_count_total = cell(1,days);
for i = 1: days
    mc_count_total{1,i} = sum(cell2mat(mc_count_day(1,i)));
end
%% Calculate total steps for the year
mc_count_total_sum = zeros(1,4);
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
steps_by_agent = sum(steps,2);
steps_by_day = sum(steps,1);
steps_total = sum(steps,"all");

%%

% This needs to be done for each vulnerability separately. Currently this
% only addresses the vulnerabilities from each step; however, only the
% controls associated with each vulnerability within the step should be
% used to calculate the number of incidents.
vuln_idx = 1;

%This is only comparing to the environment controls for vulnerability 1
vuln1_scores = cell(a_size,days);

incident_input = cell(a_size,days);

    for i = 1:a_size
        for j = 1: days
             [vuln_1{i,j}, vuln1_scores{i,j}, incident_input{i,j}] = determine_state_vuln6(agent_compliance_average, mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
             %[vuln_1{i,j}, vuln1_scores{i,j}, incident_input{i,j}] = determine_state_vuln6(people{i,2}(1,1), mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
        end
    end

%% Calculate all incidents for each day (for each step) with each person
%array_incident = cell(a_size,days);

vuln_incident_total = cell(a_size,days);
    for i = 1:a_size 
        for j = 1:days
        vuln_incident_total{i,j} = calculate_total2(vuln_1{i,j},mc_baseline{i,j}, actions_size);
        end
    end

%% This section determines the amount of breaches based on incidents

vuln_breach = cell(a_size, days);
vuln_breach_total = cell(a_size,days);
%click_forward = cell(a_size, days);
click_forward = zeros(a_size, days);
second_click = cell(a_size, days);
%the incident thresholds represent the percent that a breach will occur.

% Threshold is calculated based on the literature of the likelihood of a
% person clicking on a link
incident_threshold(1,1) = .043;
%%

% Although each agent has the same score, the agent's pattern will be
% different, yielding different score results. The "control count"
% represents the input of related controls for each vulnerability. The
% control scores need to adjust weekly/monthly/daily to mimic change
%{
for i = 1:days 
   array_breach{1,i} = determine_breach(vuln_incident_total{1,i},incident_threshold); 
end
%}

% This is just for one vulnerability (incident_threshold (1,1))
% vuln_incident_total is not correct, need to adjust to use the percentage
% The percentage should use the mc_count * control

% Calculate the denominator by adding the sum of e_thresholds within each 
% vuln_combo. For example, if vuln_Combo{1,1} = [3,5], then add the 
% e_thresholds for 3 and 5. After finding that sum, multiply that by the 
% mc_count, which represents the number of times that person was in that
% state
for i = 1:a_size 
    for j = 1:days
      %[vuln_breach{i,j}, vuln_breach_total{i,j}, click_forward{i,j}, second_click{i,j}] = determine_breach2(vuln_incident_total{i,j},incident_threshold(1,1));
      [vuln_breach{i,j}, vuln_breach_total{i,j}, click_forward(i,j), second_click{i,j}] = determine_breach2(vuln_incident_total{i,j},incident_threshold(1,1));

    end
end
    %% This section determines the amount of breaches by the day
[by_day_sum,by_day_graph] = determine_by_day(vuln_breach_total,days,1);
%% This calculates the daily breaches per step
vuln_breach_daily_sum = cell(1,days);
temp = zeros(1,actions_size);
for i = 1: days
    for j = 1: a_size
        temp = temp + cell2mat(vuln_breach_total(j,i));
        vuln_breach_daily_sum{1,i} = temp;
    end
     temp = zeros(1,actions_size);
end

%% This section determines the amount of breaches by the agent
%by_agent_forward
%[by_agent_sum, by_agent_graph] = determine_by_agent(vuln_breach_total, a_size,1);
%%
%total_click_sum = sum(by_agent_sum,1);
%%
%click_percent_agent = by_agent_sum./steps_by_agent;
%click_percent_total = total_click_sum/steps_total;
 %% This section determines the amount of breaches by the day
[incident_day,~] = determine_by_day(vuln_incident_total,days,1);
%% This section determines the amount of breaches by the agent

[incident_agent, ~] = determine_by_agent(vuln_incident_total, a_size,1);
%%
%total_click_sum = sum(incident_agent,1);
%%
%click_percent_agent2 = by_agent_sum./incident_agent;
%%
%click_average = mean(click_percent_agent2)*100;
%% Total amount of opportunities for an incident (or click)
%incident_opportunity = steps_by_agent*control_size(1,1);
%%
%click_percent_agent = by_agent_sum./incident_opportunity;
%%
%click_percent_mean = mean(by_agent_sum)/ mean(incident_opportunity);

%% Total amount of opportunities for an incident (or click)
%incident_opportunity = mc_count_total_sum.*control_size(:,1)';
incident_opportunity = cell2mat(mc_count_agent).*control_size(:,1)';

incident_opportunity_day = cell(1,days);
for i = 1: days
    incident_opportunity_day{1,i} = cell2mat(mc_count_total(1,i)).*control_size(:,1)';
end
%incident_opportunity_day = cell2mat(mc_count_total)'.*control_size(:,1)';

%% Determines the number of breaches per agent
agent_breach = cell(a_size,1);
for i = 1: a_size
    agent_breach{i,1} = determine_mc_count_agent(vuln_breach_total, days, actions_size,i);
end
%%
%click_percent_mean = mean(by_agent_sum)/ mean(incident_opportunity);
%click_percent_step = by_agent_sum./incident_opportunity;
click_percent_step = cell2mat(agent_breach)./incident_opportunity;
%% Calculate the number of daily incidents per step
click_percent_step_per_day = cell(1,days);

for i = 1:days
    click_percent_step_per_day{1,i} = cell2mat(vuln_breach_daily_sum(1,i))./cell2mat(incident_opportunity_day(1,i));
end
%% Create matrix to Graph click percent step per day
click_percent_daily_input = zeros(days,actions_size);

for i = 1: days
    for j = 1: actions_size
        click_percent_daily_input(i,j) = click_percent_step_per_day{1,i}(1,j);
    end
end
%% Convert click_percent_daily_input 
%This converts the daily input into percentages
click_percent_daily_input = click_percent_daily_input*100;
%% Graph the click percent step per day

%click_size = size(agent_click,2);
days_axis = 1:days;
for i = 1: days
    for j = 1: actions_size
        %scatter(agent_comp',agent_click(:,i)); Scatter plot
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
%}
%%
click_percent_step_mean = mean(click_percent_step,1);
%% Scatterplot of percentages
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];
agent_click(1,:) = [.5, 2.4, 1.32, 3.9];%60
agent_click(2,:) = [.52, 2.1, 1.2, 3.5];%65
agent_click(3,:) = [.45, 1.89, 1.0, 3.0];%70
agent_click(4,:) = [.38, 1.59, .86, 2.56];%75
agent_click(5,:) = [.26, 1.1, .60, 1.75];%80
agent_click(6,:) = [.17, .72, .4, 1.2];%85
agent_click(7,:) = [0,   .4,  .13, .6];%90
agent_click(8,:) = [.0,  .13,  0, .21];%95
%% Graph the points
%{
click_size = size(agent_click,2);

for i = 1: click_size
    %scatter(agent_comp',agent_click(:,i)); Scatter plot
    plot(agent_comp',agent_click(:,i));
    hold on
end
title("Agent Click Rate  (" + actions_size + " steps)")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Web-Surfing','Mobile Phone','Checking Email')
hold off
%}
%%
by_agent_forward = zeros(a_size,1);
for i = 1: a_size
    %by_agent_forward(i,1) = sum([click_forward{i,:}]);
    by_agent_forward(i,1) = sum([click_forward(i,:)]);
end
%% Percentage of forwarding an email after clicking
%click_forward_percentage = by_agent_forward./by_agent_sum;
%temp = 1:10;
%bar(temp',click_forward_percentage.*100);
%% Percentage of second offenders after receiving training

%%
checked_email = cell(a_size, days);
report_email = cell(a_size,days);
agent_email = cell(a_size,days);
agent_email_total = cell(1,days);
phish_report_rate = .7;
%%
for i = 1: a_size
    for j = 1: days
        [agent_email,phish_selected] = agent_interaction_create_email();
        agent_email_total{1,j} = agent_email;
        [checked_email{i,j}, report_email{i,j}] = calculate_email_report(vuln_incident_total{i,j},agent_email, phish_report_rate, actions_size);
    end
end
%%
checked_email_total = zeros(1,actions_size);
for i = 1: days
    checked_email_total = checked_email_total + cell2mat(checked_email(1,i));
end
%%
report_email_total = zeros(1,actions_size);
for i = 1: days
    report_email_total = report_email_total + cell2mat(report_email(1,i));
end
%% Calculate the report rate
% This calculates the total report rate by comparing the number of times an
% agent checked a phishing attempt vs reporting that phishing email. The
% mean is used to determine the rate.
report_rate = mean(report_email_total./checked_email_total);

