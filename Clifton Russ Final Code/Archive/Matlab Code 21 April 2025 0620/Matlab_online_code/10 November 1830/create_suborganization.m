function [click_percent_step_mean,report_rate, vuln_incident_total,click_percent_daily_input] = create_suborganization(a_size_total, days, agent_compliance_average,incident_threshold, phish_report_rate, scenario)
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
people = create_agent(1,a_size_total,vuln_size);
%% Taking the mean of agents' overall compliance
%This is done to simulate assessing an organization's compliance. In
%practice, people do not come with compliance scores. While it is possible
%to create a risk profile based on historical information, the more
%practical solution is to assess the organization as a whole with any
%exceptions.



% this section adjusts the agent compliance for Scenario 1d. In Scenaro 1d,
% the individual scores for each agent is known.
if scenario =="1d"
    temp = cell2mat(people(:,2));
    agent_compliance_average = mean(temp);
end

%% This determines which e_threshold data to use based on the current state



a_size = size(people,1); % This counts the number of agents

% This creates the data structure for the Markov Chain used to determine
% the steps for each agent
mc_baseline = cell(a_size, days);

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

vuln_1 = cell(a_size, days);


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
        actions = zeros(1,4);
        actions_size = size(actions,2);


        %min_max represents minimum and maximum values of a range that an agent
        %will spend a percentage of their time doing a particular action in a
        %single day. 
        min_max = zeros (2,actions_size);

        % This section determines the initial amount of actions an agent has in one
        % day
        actions_initial = determine_state_num(actions,min_max);

%% Determine initial transition Matrix

        [actions_baseline, transition_matrix] = create_action_baseline(actions_initial); 
%% Normalize the data
% This section normalizes the data to be a percentage of 100%.


temp = sum(transition_matrix,2); %Determine the sum of each row
temp = transition_matrix./temp; % Determines the percentage
transition_matrix = round(temp*100);


        
        % This sections takes the initial actions and creates additional actions to
        % create an nxn matrix to later be used for the Markov Chain
       
        %actions_baseline = create_action_baseline(actions_initial); 
        
%% Define the attribute selection {Vulnerability 1; Phishing}
% This version of attribute selection is based on all related controls for
% a specific vulnerability for each node. This means if an agent has 4
% possible nodes to visit, each node will have a set of controls related to
% possible vulnerabilities associated to the activity that the node
% represents.  The code will only check incidents for one vulnerability at
% a time. For example, attribute_selection{1,1] represents "checking email"
% therefore, all the values represent the compliance scores for each
% control. 

 attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.2794	0.8515	0.1927	0.4408	0.3012	0.4337	0.6506	0.1113	0.9116	0.5382	0.7268	0.9319];
 attribute_selection{2,1} = [0.2627	0.9236	0.2256	0.8874	0.9704	0.6219	0.0594	0.8320	0.9027	0.2413	0.2485	0.9522	0.9133	0.9590	0.6195	0.5221	0.9292];
 attribute_selection{3,1} = [0.8301	0.5968	0.4735	0.3535	0.8294	0.6103	0.9183	0.4613	0.9714	0.6175	0.1196	0.3128	0.0605];
 attribute_selection{4,1} = [0.6030	0.7088	0.7658	0.9182	0.7916	0.8152	0.9256	0.4979	0.7753	0.9819	0.7310	0.7591	0.9423];

 % this changes the values for activity 1 (checking email) if scenario 1b
 % is ran.
if scenario == "1b"
    attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.7794	0.8515	0.7927	0.4408	0.3012	0.4337	0.6506	0.7113	0.9116	0.5382	0.7268	0.9319];
end

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
   % This section takes the actions_baseline and applies the markov chain to
   % determine the transitions for each agent for each day. This model
   % outlines the daily paths for each agent before the agent does them.
   % Once the daily paths are created, the agent traverses through the
   % paths.
        mc_temp = create_mc_baseline(transition_matrix);     
   %mc_temp = create_mc_baseline(actions_baseline);
        mc_baseline{i,j} = mc_temp;

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
%% Additional variables
% These are additional variables that can be used to better understand some
% of the behavior. These includes the total number of steps by each agent,
% the total number of steps by everyone for each day, and the total number
% of steps during the entire simulation. 

%steps_by_agent = sum(steps,2);
%steps_by_day = sum(steps,1);
%steps_total = sum(steps,"all");

%%

%In the event this model were to use several vulnerabilities (other than
%phishing, the vuln_idx variable would identify which vulnerability is
%calculated. This was originally developed to support several
%vulnerabilities, but now it is only focused on one, phishing.
vuln_idx = 1;

%This creates the data structure to hold the vuln_1 scores.
vuln1_scores = cell(a_size,days);

incident_input = cell(a_size,days);

    for i = 1:a_size
        for j = 1: days
             [vuln_1{i,j}, vuln1_scores{i,j}, incident_input{i,j}] = determine_state_vuln6(agent_compliance_average, mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
             
             % This section uses individual scores as
             % opposed to an average
             if scenario == "1d2"
                [vuln_1{i,j}, vuln1_scores{i,j}, incident_input{i,j}] = determine_state_vuln6(people{i,2}(1,1), mc_baseline{i,j},e_thresholds_daily{1,j},vuln_idx);
             end
        end
    end

%% Calculate all incidents for each day (for each step) with each person

vuln_incident_total = cell(a_size,days);
    for i = 1:a_size 
        for j = 1:days
        vuln_incident_total{i,j} = calculate_total2(vuln_1{i,j},mc_baseline{i,j}, actions_size);
        end
    end

%% This section determines the amount of breaches based on incidents

vuln_breach = cell(a_size, days);
vuln_breach_total = cell(a_size,days);
click_forward = zeros(a_size, days);
second_click = cell(a_size, days);



%% Calculate the number of clicks on phishing emails
% As defined in the Verizon study, there is a differentiation between an
% incident, where someone does something wrong, and a breach, when there is
% evidence of impact. In this scenario, an incident is defined by the
% agent having a higher threat than the control compliance score to stop
% that threat. However, that does not mean anything with impact has
% occurred. For example, a careless user who easily falls victims to
% phishing attempts might simply delete the email to clear their email. In
% that instance, there would be an incident, but no breach. Incidents are
% noted to highlight the risk. Understanding the risk can lower breaches.
% If that same user were to click on the actual link, then it is considered
% a breach. The other variables, click_forward and second_click represent
% the percent the user forwarded the phishing email after clicking it and
% clicking on a second phishing email after clicking the first. 

for i = 1:a_size 
    for j = 1:days
      [vuln_breach{i,j}, vuln_breach_total{i,j}, click_forward(i,j), second_click{i,j}] = determine_breach2(vuln_incident_total{i,j},incident_threshold(1,1));

    end
end

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
%% Total amount of opportunities for an incident (or click)
% This calculates the total amount of times an agent could thereotically
% cause an incident. This defined by first counting all the steps per agent
% for each activity. The variable, mc_count_agent) is the sum of each
% activity each agent did. The variable, control_size, is the total number
% of phishing controls for each activity. Multiplying these two variables
% yields the total amount opportunities the agent could cause an incident.
incident_opportunity = cell2mat(mc_count_agent).*control_size(:,1)';

incident_opportunity_day = cell(1,days);
for i = 1: days
    incident_opportunity_day{1,i} = cell2mat(mc_count_total(1,i)).*control_size(:,1)';
end

%% Determines the number of breaches per agent
% This determines the number of breaches for each agent.
agent_breach = cell(a_size,1);
for i = 1: a_size
    agent_breach{i,1} = determine_mc_count_agent(vuln_breach_total, days, actions_size,i);
end
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
%
if scenario == "1a2"
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
end




%% Determine the click percent for each activity
click_percent_step = cell2mat(agent_breach)./incident_opportunity;
%% Determines the mean for the click percent for each activity
click_percent_step_mean = mean(click_percent_step,1);
click_percent_step_mean = click_percent_step_mean.*100;

%% Determines the number of forwarded emails by each agent
by_agent_forward = zeros(a_size,1);
for i = 1: a_size
    by_agent_forward(i,1) = sum([click_forward(i,:)]);
end
%% Define variables for Scenario 2

checked_email = cell(a_size, days);
report_email = cell(a_size,days);
agent_email = cell(a_size,days);
agent_email_total = cell(1,days);

%% Determine checked and reported email
% This calculates the number of emails that agents opened/clicked and the
% number of those checked emails the agents reported 
for i = 1: a_size
    for j = 1: days
        [agent_email,phish_selected] = agent_interaction_create_email();
        agent_email_total{1,j} = agent_email;
        [checked_email{i,j}, report_email{i,j}] = calculate_email_report(vuln_incident_total{i,j},agent_email,phish_report_rate, actions_size);
    end
end
%% Calculate total checked email
checked_email_total = zeros(1,actions_size);
for i = 1: days
    checked_email_total = checked_email_total + cell2mat(checked_email(1,i));
end
%% Calculate total reported email
report_email_total = zeros(1,actions_size);
for i = 1: days
    report_email_total = report_email_total + cell2mat(report_email(1,i));
end
%% Calculate the report rate
% This calculates the total report rate by comparing the number of times an
% agent checked a phishing attempt vs reporting that phishing email. The
% mean is used to determine the rate.
report_rate = mean(report_email_total./checked_email_total);

end