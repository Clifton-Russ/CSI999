
%% This is a tester class that tests the functions of the program
% This class is for agent interaction
%clc;clear;
%% Creates the control data
vuln_size = 1;
%% This creates The agents
start = 1;
stop = 10;
threat_size = 4; 
people = create_agent(start,stop,threat_size);
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
markov = cell(a_size, days);
vuln_controls = cell(a_size, days);
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
        actions = zeros(1,5);
        actions_size = size(actions,2);

        %actions_size = size(actions_initial,2);


        %min_max represents minimum and maximum values of a range that an agent
        %will spend a percentage of their time doing a particular action in a
        %single day
        min_max = zeros (2,actions_size);

        % This section determines the initial amount of actions an agent has in one
        % day based on the predefined metrics
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
% a time.
%%
    attribute_selection = cell(actions_size,1);
    %% Company 1
    %{
    xmin=0.0; % the compliance floor score
    xmax=.24; % the compliance ceiling  score
    
    for m = 1:threat_size
        attribute_selection{m,1} = xmin + (xmax-xmin).*rand(1,15);
    end    
    %}
%% Company 2
    %{ 

    xmin=0.25; % the compliance floor score
    xmax=.49; % the compliance ceiling  score
    
    for m = 1:threat_size
        attribute_selection{m,1} = xmin + (xmax-xmin).*rand(1,15);
    end   
    %}
%%

%{
    for m = 1:threat_size
        attribute_selection{m,1} = rand(1,15);
    end   
%}  
%%

 attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.2794	0.8515	0.1927	0.4408	0.3012	0.4337	0.6506	0.1113	0.9116	0.5382	0.7268	0.9319];
 attribute_selection{2,1} = [0.2627	0.9236	0.2256	0.8874	0.9704	0.6219	0.0594	0.8320	0.9027	0.2413	0.2485	0.9522	0.9133	0.9590	0.6195	0.5221	0.9292];
 attribute_selection{3,1} = [0.8301	0.5968	0.4735	0.3535	0.8294	0.6103	0.9183	0.4613	0.9714	0.6175	0.1196	0.3128	0.0605];
 %attribute_selection{4,1} = [0.6030	0.4088	0.4658	0.1182	0.2916	0.8152	0.9256	0.4979	0.7753	0.9819	0.3310	0.2591	0.0423];
 attribute_selection{4,1} = [0.6030	0.7088	0.7658	0.9182	0.7916	0.8152	0.9256	0.4979	0.7753	0.9819	0.7310	0.7591	0.9423];
 attribute_selection{5,1} = [];% This represents the other
%}
%}
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
        [mc_temp,markov_temp] = create_mc_baseline(transition_matrix);
        mc_baseline{i,j} = mc_temp;
        markov{i,j} = markov_temp;
   end
end
%% For loop for determine_mc_count
mc_count = cell(a_size,days);
% This counts the number of stages per day
for i = 1: a_size
    for j = 1: days
        mc_count{i,j} = determine_mc_count(actions_size, mc_baseline(i,j));
    end
end

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

%%
mc_count_total = cell(1,days);
for i = 1: days
    mc_count_total{1,i} = sum(cell2mat(mc_count_day(1,i)));
end
%% Calculate total steps for the year
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
vuln_breach = cell(a_size,days);
vuln_breach_total = cell(a_size,days);
    for i = 1:a_size
        for j = 1: days
            %[vuln_1{i,j}, ~, incident_input{i,j}] = determine_state_vuln6(agent_compliance_average, mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
             % individual
              %[vuln_controls{i,j}, ~, incident_input{i,j}] = determine_state_vuln6(people{i,2}(1,1), mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
              %[vuln_controls{i,j}, ~, incident_input{i,j}] = determine_state_vuln7(people{i,2}(1,1), mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
              [vuln_controls{i,j}, incident_input{i,j}, vuln_breach{i,j}, ~] = determine_state_vuln8(people{i,3}(1,:), mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
        end
    end

%% Calculate all incidents for each day (for each step) with each person
%array_incident = cell(a_size,days);

vuln_incident_total = cell(a_size,days);
    for i = 1:a_size 
        for j = 1:days
        vuln_incident_total{i,j} = calculate_total2(vuln_controls{i,j},mc_baseline{i,j}, actions_size);
        end
    end

%% This section determines the amount of breaches based on incidents

%click_forward = cell(a_size, days);
click_forward = zeros(a_size, days);
second_click = cell(a_size, days);
%the incident thresholds represent the percent that a breach will occur.

% Threshold is calculated based on the literature of the likelihood of a
% person clicking on a link
incident_threshold(1,1) = .043;
%%


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
      %[vuln_breach{i,j}, vuln_breach_total{i,j}, click_forward(i,j), second_click{i,j}] = determine_breach2(vuln_incident_total{i,j},incident_threshold(1,1));
       [~, ~, click_forward(i,j), second_click{i,j}] = determine_breach2(vuln_incident_total{i,j},incident_threshold(1,1));

    end
end
%% This calculates the total amount of exploits
for i = 1:a_size
    for j = 1:days
        vuln_breach_total{i,j} =  calculate_breach_total(vuln_breach{i,j},threat_size);
    end
end

    %% This section determines the amount of breaches by the day
%[by_day_sum,by_day_graph] = determine_by_day(vuln_breach_total,days,1);
%% This section determines the amount of breaches by the agent
%by_agent_forward
%[by_agent_sum, by_agent_graph] = determine_by_agent(vuln_breach_total, a_size,1);
 %% This section determines the amount of breaches by the day
%[incident_day,~] = determine_by_day(vuln_incident_total,days,1);
%% This section determines the amount of breaches by the agent
%[incident_agent, ~] = determine_by_agent(vuln_incident_total, a_size,1);

%% Total amount of opportunities for an incident (or click)
%incident_opportunity = mc_count_total_sum.*control_size(:,1)';
incident_opportunity = cell2mat(mc_count_agent).*control_size(:,1)';
%% Determines the number of breaches per agent

agent_breach = cell(a_size,1);
for i = 1: a_size
    %agent_breach{i,1} = determine_mc_count_agent(vuln_breach_total, days, actions_size,i);
    agent_breach{i,1} = determine_mc_count_agent2(vuln_breach_total, days, threat_size,i);
end
%}
%%
incident_opportunity(:,5) = [];
%%
click_percent_step = cell2mat(agent_breach)./incident_opportunity;
%%
click_percent_step_mean = mean(click_percent_step,1);
%% New Attempt Full simulation for dissertation
%{
figure;
simplot(markov{1,1},mc_baseline{1,1});
set(gca,'YTickLabel',[]);
%}
%% New Attempt 
%{
figure;
graphplot(markov{1,1}, 'ColorEdges', true);
%}
%%
by_agent_forward = zeros(a_size,1);
for i = 1: a_size
    %by_agent_forward(i,1) = sum([click_forward{i,:}]);
    %by_agent_forward(i,1) = sum([click_forward(i,:)]);
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

