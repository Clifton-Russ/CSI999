%% Thoughts
% Use unsupervised learning to see if the outcome is the same or able to
% predict new incidents
% Compare different types of supervised learning techniques
% 14 days for input, for 1 year, 3 years, 6 years and 10 years. Change each
% 14 days by +/- 10%.
% e_thresholds times the number of times the occurrence in the mc.
% Count the number of times each step.

% For each row of controls (represented by control by each day), [input],
% the output is a single digit or string for each any breach. If there is
% more than one, either the threat with the most breaches or a combination.

% calculate a way to determine the average of incidents per state. If the
% average is above 50%, then it's considered an incident. This will be the
% input for that day for that state.

% Determine state vuln and determine incident
% vuln control size determines the amount controls for each vulnerability.
% For each step, the total number of controls need to be calculated. For
% example, step 1 involves vuln1 and vuln 2, so add vuln size 1 and vuln
% size 2. Once that is added, then for each person, that number needs to be
% multiplied for the number of times each step occurs. For example, if
% person 1 was in step 1 10 times, then the number would be 10 times (vuln
% size 1 + vuln size 2). Once that number is calculated (vuln_total), that
% will act as the denominator. Dividing the part / whole will give a
% percentage of incidents. This number can then be used to either determine
% the output layer or label.

% output layer, each vulnerability (1 or 0) and NA (1 or 0). List all
% controls as the input. This trains against all vulnerabilities at once.

% control size = number of each controls for each vulnerability
% vuln_control count: sum of control size columns. The total amount of
% controls for each vulnerability
% vuln incident total = total sum of incidents per person, per day, per
% step.
% sort through mc-baseline to determine the amount steps per day.


% Currently, the vuln1 input and attribute information are random and need to be separated from
% specifically chosen controls.

% Need to focus on simulating agent movement and less on predictions.


%%
%isempty(cell2mat(vuln1_scores{1,1}(3,1)))
%likelihood = round(vuln1_scores(1,i)*.21);
% Converts the incident matrix to an array and sum all incidents
        %temp = sum(cell2mat(vuln1_scores{i,j}));
        % likelihood for agent clicking the link.
        %likelihood = round(temp *.21);
       % likelihood = .51;
%%
%input label includes the vuln1_scores for the day and the +1 is the label
%to determine if it were a breach.

%{
vuln_breach2 = cell(a_size,days);
temp = cell(a_size,days);

% This is only done for setting up for prediction modeling.
for i = 1: a_size
    for j = 1:days  
        
        [vuln_breach2{i,j}, temp{i,j}] = determine_breach3(vuln_1{i,j}, incident_threshold, steps(i,j),attribute_size,likelihood);
    end
    %input_label = cell2mat(vuln_breach{1,1}(1,1))';
end
%}
%%
% links, forward email. Then calculate per person, per day, per activity
% Fix determine breach. incident size is incorrect


% calculate instances where phishing attacks fail
% Determine the amount of people in survey/percentage
% Assume that the agents receive the same attacks
% range of steps, risk (phishing)/different
% controls.
% Slide 31- Social Engineering
% Used 21% for exposure based on the number of incidents reported within a
% year.
% adjust scores for various scenarios and then check to see if percentage
% is closer to 4%
% compare what happens when reduce the number of steps

%%
%1. Select controls again determine_attribute
% Need to calculalte for each agent as opposed to one person
% 98% email 

%%
%agent_click = toArray(agent_click,click_size);
%% This saves the plot in a temporary variable. The variable needs to be saved in order to be maintained. 
%click_figure = create_plot(agent_comp,agent_click, actions_size);
%%
% For each reported email, tag the email as reported. If an email is tagged
% as reported in the future, then it is considered "null".

%%
%agent_comp = [60 65, 70, 75, 80, 85, 90, 95];


%%
%{
add_email_index = randi([1, 5],1,1);
add_email = randi([0, 1],1,add_email_index);
email_original{1,1} = agent_email_total{1,2}{1,2}(1,:);
temp = [email_original{1,1}, add_email];
%}


%% For loop to determine the total of emails reported

 r_email_total = cell(1, days);
for i = 1: days
    r_email_total{1,i} = sum(cell2mat(r_email(:,i)),1);
end

%% For loop to summarize all reported emails for all days

r_email_total_by_activity = zeros(1,actions_size);
for i = 1: days
    for j = 1: actions_size
        r_email_total_by_activity(1,j) = r_email_total_by_activity(1,j) + r_email_total{1,i}(1,j);
    end
end
%% For loop to determine the total of checked emails 

 c_email_total = cell(1, days);
for i = 1: days
    c_email_total{1,i} = sum(cell2mat(c_email(:,i)),1);
end
%% For loop to summarize all checked emails for all days

c_email_total_by_activity = zeros(1,actions_size);
for i = 1: days
    for j = 1: actions_size
        c_email_total_by_activity(1,j) = c_email_total_by_activity(1,j) + c_email_total{1,i}(1,j);
    end
end
%%
r_email_percentage = r_email_total_by_activity./c_email_total_by_activity;



%% For loop to determine the total of checked emails (forwarded)

 c_email_total_new = cell(1, days);
for i = 1: days
    c_email_total_new{1,i} = sum(cell2mat(c_email(:,i)),1);
end

 c_email_total_old = cell(1, days);
for i = 1: days
    c_email_total_old{1,i} = sum(cell2mat(c_email_old(:,i)),1);
end
%% For loop to summarize all checked emails for all days (Forward)

c_email_total_by_activity_new = zeros(1,actions_size);
for i = 1: days
    for j = 1: actions_size
        c_email_total_by_activity_new(1,j) = c_email_total_by_activity_new(1,j) + c_email_total_new{1,i}(1,j);
    end
end

c_email_total_by_activity_old = zeros(1,actions_size);
for i = 1: days
    for j = 1: actions_size
        c_email_total_by_activity_old(1,j) = c_email_total_by_activity_old(1,j) + c_email_total_old{1,i}(1,j);
    end
end
%% calculate the checked email increase (Forward)
c_email_increase = (c_email_total_by_activity_new -c_email_total_by_activity_old )./c_email_total_by_activity_old;






%% Scenario 2 input

agent_compliance_average = [.60, .65, .70, .75, .80, .85, .90, .95];

incident_threshold = [.025, .035, .02, .01];
phish_report_rate = [.7,.6,.75,.80];
agent_compliance_size = size(agent_compliance_average,2);
team_size = 4;
observation_size = 20;

click_percent_step_mean = cell(observation_size, agent_compliance_size);
report_rate = cell (observation_size,agent_compliance_size);

a_size_total = [100, 75, 50, 25];