%% Scenario 2: 
% Scenario 2 focuses on agent interaction within a more complex
% organiztaion. Scenario 1 focuses on a "flat organization" where the
% differences are mostly within each agent. Scenarios 2a and 2b focus on
% the impact when an agent from one group interacts with another group.
% Scenario 2a focuses on the impact when agents report phishing emails.
% Scenario 2b focuses on the impact when agents forward phishing emails to
% each other. 


% Develop 250 personnel organization.
% Team 1: 100 personnel
    % agent average 70%
    % click rate: 2.5%
    % forward rate: 1%
    % report rate: 70%

% Team 2: 75 Personnel
    % agent average 65%
    % click rate: 3.5%
    % forward rate: 3.0%
    % report rate: 60%
    
% Team 3: 50 peresonnel
    % agent average 75% 
    % click rate: 2.0%
    % forward rate: 1.0%
    % report rate: 75%

% Team 4: 25 personnel
    % agent average 80%
    % click rate: 1.0%
    % forward rate: 0.5%
    % report rate: 85%
%% Definitions

actions_size = 4;
%a_size = 25;

a_size = [100,75,50,25];
days = 50;
% agent compliance
agent_compliance_average = [.6,.65,.7, .75, .8, .85, .9, .95];
%phish_report_rate = [.70, .60, .75, .80];
click_size = 8;
org_size = 4;
scenario = "2a";

%% This section determines the range for phishing report rates.
% The report rate from the literature used for this project was
% approximately 70%. Since the "reasonable standards" caps the agent's
% compliance floor to 70%, a compliant agent will have a range of 60% to
% 80% for reporting phishing emails. Noncompliant agents (compliance under
% 70%) will have a reporting range from 50% to 70%. This places the lowest
% compliant score (70%) and the lowest noncompliant score (60%) in the
% middle of each of their respective ranges
%Change team3 to 60%

phish_report_rate = zeros(1,org_size);
agent_compliance = [.7, .65, .75, .8];
for i = 1: org_size
    
    if agent_compliance(1,i) >= .70
        xmin=.60; % the compliance floor score
        xmax=.80; % the compliance ceiling  score

        phish_report_rate(1,i) = xmin + (xmax-xmin).*rand(1,1);

    elseif agent_compliance(1,i) >= .60
        xmin=.50; % the compliance floor score
        xmax=.70; % the compliance ceiling  score
        
        phish_report_rate(1,i) = xmin + (xmax-xmin).*rand(1,1);
    end
end

%%

% this defines the click rate for each oranization. Each element represents
% their corresponding click rates.
incident_threshold = [.025, .035, .020, .010];

agent_click = cell(click_size,org_size);
total_report_rate = cell(click_size,org_size);
v_total = cell(click_size,org_size);
a_size_total = [2,4,6,4,2];

% This stores the reduction rate for team 2 after each team has reported
% phishing emails.
team_2_reduction_rate = zeros(1,org_size);
team_increase_rate = zeros(org_size,actions_size);
% This version of attribute selection is based on all related controls for
% a specific vulnerability for each node. This means if an agent has 4
% possible nodes to visit, each node will have a set of controls related to
% possible vulnerabilities associated to the activity that the node
% represents.  The code will only check incidents for one vulnerability at
% a time. For example, attribute_selection{1,1] represents "checking email"
% therefore, all the values represent the compliance scores for each
% control. 

attribute_selection {1,1} = [.7467, .3624, .1073, .7538, .5053];
attribute_selection {2,1} = [0.9135,0.4975,0.0330,0.2703,0.6587,0.3627,0.3998];
attribute_selection {3,1} = [0.3830,0.2413,0.9665];
attribute_selection {4,1} = [0.2197,0.8792,0.3815];

%% Create Suborgnization (Team 1)
click_size = 8;
org_size = 4;
% this defines the click rate for each oranization. Each element represents
% their corresponding click rates.


%a_size_total, days, agent_compliance_average,incident_threshold, phish_report_rate, scenario
for i = 1: click_size
    for j = 1:org_size
        [click_percent_step_mean,report_rate, vuln_incident_total] = ... 
            create_suborganization(a_size_total(1,j), days, agent_compliance_average(1,i), incident_threshold(1,j), phish_report_rate(1,j), scenario);
        agent_click{i,j} = click_percent_step_mean;
        total_report_rate{i,j} = report_rate;
        v_total{i,j} = vuln_incident_total;

    end
    
end
%% Display calculated click rates and report rates
% This section displays the calculated click and report rates for each team
% This information comes from the variables agent_click and total_report
% rate. The x values represent the team's compliance rate from 60 to 95.
% The y values represent each team. For example, agent_click {3,1}
% represents the third compliance (70%) and the first team. 

%% Team 1
% This section prints the click rates and report rates for Team 1
disp("Team 1 Click Rate: "); 
for i = 1: org_size
    disp("     Activity " + i + ": " + agent_click{1,1}(1,i)+"%");
end


disp(' ');
disp("Team 1 Report Rate: "+ total_report_rate{1,1} *100);
 
disp(' ');
disp(' ');

%% Team 2

% This section prints the click rates and report rates for Team 2
disp("Team 2 Click Rate: "); 

for i = 1: org_size
    disp("     Activity " + i + ": " + agent_click{2,2}(1,i)+"%");
end


disp(' ');
disp("Team 2 Report Rate: "+ total_report_rate{2,2} *100);

disp(' ');
disp(' ');
%% Team 3

% This section prints the click rates and report rates for Team 3
disp("Team 3 Click Rate: "); 

for i = 1: org_size
    disp("     Activity " + i + ": " + agent_click{3,3}(1,i)+"%");
end


disp(' ');
disp("Team 3 Report Rate: "+ total_report_rate{3,3} *100);

disp(' ');
disp(' ');
%% Team 4

% This section prints the click rates and report rates for Team 4
disp("Team 4 Click Rate: "); 

for i = 1: org_size
    disp("     Activity " + i + ": " + agent_click{4,4}(1,i)+"%");
end

disp(' ');
disp("Team 4 Report Rate: " + total_report_rate{4,4} *100);



%% Subsections at specific agent compliance level 
checked_email = cell(1, org_size);
report_email = cell(1,org_size);
agent_email_total = cell(1,org_size);
%% Subsection 1 70%  100 people 
c_email = cell(a_size_total(1,1), days);
r_email = cell(a_size_total(1,1),days);
a_email_total = cell(a_size_total(1,1),days);
p_selected = cell(a_size_total(1,1),days);

for m = 1: a_size_total(1,1)
    for n = 1: days
        [agent_email,p_selected] = agent_interaction_create_email();
        a_email_total{m,n} = agent_email;
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{3,1}{m,n},agent_email, phish_report_rate(1,1), actions_size);
    end
end

checked_email{1,1} = c_email;
report_email{1,1} = r_email;
agent_email_total{1,1} = a_email_total;


%% Create Reported email (Team 1)
% This changes existing phishing email to reported
% This represents the second team receiving a reported email.
c_email = cell(a_size_total(1,1), days);
r_email = cell(a_size_total(1,1),days);
a_email_total = cell(a_size_total(1,1),days);

%This checks to see if the email is a phishing email. If the email is a
%phishing email, then there is a random chance that the agent will report
%the email.
resolved_email = 0;
for m = 1: a_size_total(1,1)
    for n = 1: days
        
        for o = 1: size(agent_email_total{1,1}{m,n}(1,:),2)
            if agent_email_total{1,1}{m,n}(1,o) == 1
                temp = rand;
                    if temp < phish_report_rate(1,1)
                        agent_email_total{1,1}{m,n}(1,o) = 0;
                        resolved_email = resolved_email+1;
                    end
            end
            agent_email = agent_email_total{1,1}{m,n}(1,:);
        end
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,1}{m,n},agent_email,phish_report_rate(1,1), actions_size);
    end    
end

%% Determining the new checked emails after emails have been reported (Team 1)

c_email_new = zeros(a_size_total(1,1),actions_size);
%c_email_report = zeros(1,actions_size);
for i = 1: a_size_total(1,1)
    for j = 1: days
        %c_email_report = c_email_report + cell2mat(c_email(1,j));
        c_email_new(i,:) = c_email_new(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 1)
c_email_old = zeros(a_size_total(1,1),actions_size);
for i = 1: a_size_total(1,1)
    for j = 1: days
        c_email_old(i,:) = c_email_old(i,:) + cell2mat(checked_email{1,1}(i,j));
    end
end
%% calculate the checked email reduction (Team 1)
c_email_reduction = (c_email_old - c_email_new)./c_email_old;

%% calculate the checked email reduction (Team 1)
% This saves the reduction rate of emails from team 2 after team 1 has
% reported phishing emails.
temp = mean(c_email_reduction,1);
team_2_reduction_rate(1,1) = temp(1,2);

%% Create forward email (Team 1)
% This adds phishing email to existing email
% This represents the second team receiving a additional phishing email.
c_email = cell(a_size_total(1,1), days);
r_email = cell(a_size_total(1,1),days);

c_email_old = cell(a_size_total(1,1), days);
r_email_old = cell(a_size_total(1,1),days);
a_email_total = cell(a_size_total(1,1),days);

email_original = cell(a_size_total(1,1),days);


additional_email = 0;
for m = 1: a_size_total(1,1)
    for n = 1: days
        %this creates a number of additional emails that reflects phishing
        %emails that were forwarded
        add_email_index = randi([1, 5],1,1);
        add_email = randi([0, 1],1,add_email_index);

        %This line captures the original amount of emails before adding the
        %additional phishing emails
        agent_email_old = agent_email_total{1,1}{m,n}(1,:);
        email_original{m,n} = agent_email_old;
        
        % This process adds the new forwarded phishing emails to the
        % original emails
        temp = 0;
        temp = [email_original{m,n}, add_email];
        
        agent_email = temp;
        a_email_total{m,n} = agent_email;
       
        %These two lines determines the number of emails that agents
        %checked with the original email and then with the new email (with
        %the forwarded phishing emails)
        [c_email_old{m,n}, r_email_old{m,n}] = calculate_email_report(v_total{1,1}{m,n},agent_email_old, phish_report_rate(1,1), actions_size);
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,1}{m,n},agent_email, phish_report_rate(1,1),actions_size);
    end

end

%% Defined Team 1

checked_email_new = cell(1, org_size);
report_email_new = cell(1,org_size);
%agent_email_total_new = cell(1,org_size);

checked_email{1,1} = c_email_old;
report_email{1,1} = r_email_old;

checked_email_new{1,1} = c_email;
report_email_new{1,1} = r_email;
%agent_email_total_new{1,2} = a_email_total;%agent_email;

%% Determining the new checked emails after emails have been forwarded (Team 1)

c_email_new_final = zeros(a_size_total(1,1),actions_size);

for i = 1: a_size_total(1,1)
    for j = 1: days
          c_email_new_final(i,:) = c_email_new_final(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 1)
c_email_old_final = zeros(a_size_total(1,1),actions_size);
for i = 1: a_size_total(1,1)
    for j = 1: days
        c_email_old_final(i,:) = c_email_old_final(i,:) + cell2mat(checked_email{1,1}(i,j));
    end
end
%% calculate the checked email increase (Team 1)
c_email_increase = (c_email_new_final -c_email_old_final )./c_email_old_final;

temp = mean(c_email_increase,1);
team_increase_rate(1,:) = temp(1,:);
%% Subsection 2 60%  75 people 
c_email = cell(a_size_total(1,2), days);
r_email = cell(a_size_total(1,2),days);
a_email_total = cell(a_size_total(1,2),days);


for m = 1: a_size_total(1,2)
    for n = 1: days
        [agent_email,~] = agent_interaction_create_email();
        a_email_total{m,n} = agent_email;
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,2}{m,n},agent_email, phish_report_rate(1,2), actions_size);
    end
end

checked_email{1,2} = c_email;
report_email{1,2} = r_email;
agent_email_total{1,2} = a_email_total;



%% Create Reported email (Team 2)
% This changes existing phishing email to reported
% This represents the second team receiving a reported email.
c_email = cell(a_size_total(1,2), days);
r_email = cell(a_size_total(1,2),days);
a_email_total = cell(a_size_total(1,2),days);

% need to check the value for 1. If it's a 1, 50/50 that it is reported. If
% it is reported, then don't check.
%agent_email_total{m,n}(1,:);
%size(agent_email_total{m,1}{m,1}(n,:),2);
resolved_email = 0;
for m = 1: a_size_total(1,2)
    for n = 1: days
        
        for o = 1: size(agent_email_total{1,2}{m,n}(1,:),2)
            if agent_email_total{1,2}{m,n}(1,o) == 1
                temp = rand;
                    if temp < phish_report_rate(1,2)
                        agent_email_total{1,2}{m,n}(1,o) = 0;
                        resolved_email = resolved_email+1;
                    end
            end
            agent_email = agent_email_total{1,2}{m,n}(1,:);
        end
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,2}{m,n},agent_email, phish_report_rate(1,2),actions_size);
    end    
end

%% Determining the new checked emails after emails have been reported (Team 2)

c_email_new = zeros(a_size_total(1,2),actions_size);

for i = 1: a_size_total(1,2)
    for j = 1: days
          c_email_new(i,:) = c_email_new(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 2)
c_email_old = zeros(a_size_total(1,2),actions_size);
for i = 1: a_size_total(1,2)
    for j = 1: days
        c_email_old(i,:) = c_email_old(i,:) + cell2mat(checked_email{1,2}(i,j));
    end
end
%% calculate the checked email reduction (Team 2)
c_email_reduction = (c_email_old - c_email_new)./c_email_old;

%% calculate the checked email reduction (Team 2)
% This saves the reduction rate of emails from team 2 after team 2 has
% reported phishing emails.

temp = mean(c_email_reduction,1);
team_2_reduction_rate(1,2) = temp(1,2);
%% Create forward email (Team 2)


% This adds phishing email to existing email
% This represents the second team receiving a additional phishing email.
c_email = cell(a_size_total(1,2), days);
r_email = cell(a_size_total(1,2),days);

c_email_old = cell(a_size_total(1,2), days);
r_email_old = cell(a_size_total(1,2),days);
a_email_total = cell(a_size_total(1,2),days);

email_original = cell(a_size_total(1,2),days);


additional_email = 0;
for m = 1: a_size_total(1,2)
    for n = 1: days
        %this creates a number of additional emails that reflects phishing
        %emails that were forwarded
        add_email_index = randi([1, 5],1,1);
        add_email = randi([0, 1],1,add_email_index);

        %This line captures the original amount of emails before adding the
        %additional phishing emails
        agent_email_old = agent_email_total{1,2}{m,n}(1,:);
        email_original{m,n} = agent_email_old;
        
        % This process adds the new forwarded phishing emails to the
        % original emails
        temp = 0;
        temp = [email_original{m,n}, add_email];
        
        agent_email = temp;
        a_email_total{m,n} = agent_email;
       
        %These two lines determines the number of emails that agents
        %checked with the original email and then with the new email (with
        %the forwarded phishing emails)
        [c_email_old{m,n}, r_email_old{m,n}] = calculate_email_report(v_total{1,2}{m,n},agent_email_old, phish_report_rate(1,2), actions_size);
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,2}{m,n},agent_email, phish_report_rate(1,2), actions_size);
    end

end

%%

checked_email_new = cell(1, org_size);
report_email_new = cell(1,org_size);
%agent_email_total_new = cell(1,org_size);

checked_email{1,2} = c_email_old;
report_email{1,2} = r_email_old;

checked_email_new{1,2} = c_email;
report_email_new{1,2} = r_email;
%agent_email_total_new{1,2} = a_email_total;%agent_email;

%% Determining the new checked emails after emails have been forwarded (Team 2)

c_email_new_final = zeros(a_size_total(1,2),actions_size);

for i = 1: a_size_total(1,2)
    for j = 1: days
          c_email_new_final(i,:) = c_email_new_final(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 2)
c_email_old_final = zeros(a_size_total(1,2),actions_size);
for i = 1: a_size_total(1,2)
    for j = 1: days
        c_email_old_final(i,:) = c_email_old_final(i,:) + cell2mat(checked_email{1,2}(i,j));
    end
end
%% calculate the checked email increase (Team 2)
c_email_increase = (c_email_new_final -c_email_old_final )./c_email_old_final;
temp = mean(c_email_increase,1);
team_increase_rate(2,:) = temp(1,:);

%% Subsection 3 75%  50 people 
c_email = cell(a_size_total(1,3), days);
r_email = cell(a_size_total(1,3),days);
a_email_total = cell(a_size_total(1,3),days);


for m = 1: a_size_total(1,3)
    for n = 1: days
        [agent_email,~] = agent_interaction_create_email();
        a_email_total{m,n} = agent_email;
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{4,3}{m,n},agent_email, phish_report_rate(1,3), actions_size);
    end
end
checked_email{1,3} = c_email;
report_email{1,3} = r_email;
agent_email_total{1,3} = a_email_total;


%% Create Reported email (Team 3)
% This changes existing phishing email to reported
% This represents the second team receiving a reported email.
c_email = cell(a_size_total(1,3), days);
r_email = cell(a_size_total(1,3),days);
a_email_total = cell(a_size_total(1,3),days);

% need to check the value for 1. If it's a 1, 50/50 that it is reported. If
% it is reported, then don't check.
%agent_email_total{m,n}(1,:);
%size(agent_email_total{m,1}{m,1}(n,:),2);
resolved_email = 0;
for m = 1: a_size_total(1,3)
    for n = 1: days
        
        for o = 1: size(agent_email_total{1,3}{m,n}(1,:),2)
            if agent_email_total{1,3}{m,n}(1,o) == 1
                temp = rand;
                    if temp < phish_report_rate(1,3)
                        agent_email_total{1,3}{m,n}(1,o) = 0;
                        resolved_email = resolved_email+1;
                    end
            end
            agent_email = agent_email_total{1,3}{m,n}(1,:);
        end
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,3}{m,n},agent_email, phish_report_rate(1,3),actions_size);
    end    
end

%% Determining the new checked emails after emails have been reported (Team 3)

c_email_new = zeros(a_size_total(1,3),actions_size);
%c_email_report = zeros(1,actions_size);
for i = 1: a_size_total(1,3)
    for j = 1: days
        %c_email_report = c_email_report + cell2mat(c_email(1,j));
        c_email_new(i,:) = c_email_new(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 3)
c_email_old = zeros(a_size_total(1,3),actions_size);
for i = 1: a_size_total(1,3)
    for j = 1: days
        c_email_old(i,:) = c_email_old(i,:) + cell2mat(checked_email{1,3}(i,j));
    end
end
%% calculate the checked email reduction (Team 3)
c_email_reduction = (c_email_old - c_email_new)./c_email_old;
%% calculate the checked email reduction (Team 3)
% This saves the reduction rate of emails from team 2 after team 3 has
% reported phishing emails.

temp = mean(c_email_reduction,1);
team_2_reduction_rate(1,3) = temp(1,2);
%% Create forward email (Team 3)


% This adds phishing email to existing email
% This represents the second team receiving a additional phishing email.
c_email = cell(a_size_total(1,3), days);
r_email = cell(a_size_total(1,3),days);

c_email_old = cell(a_size_total(1,3), days);
r_email_old = cell(a_size_total(1,3),days);
a_email_total = cell(a_size_total(1,3),days);

email_original = cell(a_size_total(1,3),days);


additional_email = 0;
for m = 1: a_size_total(1,3)
    for n = 1: days
        %this creates a number of additional emails that reflects phishing
        %emails that were forwarded
        add_email_index = randi([1, 5],1,1);
        add_email = randi([0, 1],1,add_email_index);

        %This line captures the original amount of emails before adding the
        %additional phishing emails
        agent_email_old = agent_email_total{1,3}{m,n}(1,:);
        email_original{m,n} = agent_email_old;
        
        % This process adds the new forwarded phishing emails to the
        % original emails
        temp = 0;
        temp = [email_original{m,n}, add_email];
        
        agent_email = temp;
        a_email_total{m,n} = agent_email;
       
        %These two lines determines the number of emails that agents
        %checked with the original email and then with the new email (with
        %the forwarded phishing emails)
        [c_email_old{m,n}, r_email_old{m,n}] = calculate_email_report(v_total{1,3}{m,n},agent_email_old, phish_report_rate(1,3),actions_size);
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,3}{m,n},agent_email, phish_report_rate(1,3),actions_size);
    end

end

%% Defined Team 3

checked_email_new = cell(1, org_size);
report_email_new = cell(1,org_size);
%agent_email_total_new = cell(1,org_size);

checked_email{1,3} = c_email_old;
report_email{1,3} = r_email_old;

checked_email_new{1,3} = c_email;
report_email_new{1,3} = r_email;
%agent_email_total_new{1,2} = a_email_total;%agent_email;

%% Determining the new checked emails after emails have been forwarded (Team 3)

c_email_new_final = zeros(a_size_total(1,3),actions_size);

for i = 1: a_size_total(1,3)
    for j = 1: days
          c_email_new_final(i,:) = c_email_new_final(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 3)
c_email_old_final = zeros(a_size_total(1,3),actions_size);
for i = 1: a_size_total(1,3)
    for j = 1: days
        c_email_old_final(i,:) = c_email_old_final(i,:) + cell2mat(checked_email{1,3}(i,j));
    end
end
%% calculate the checked email increase (Team 3)
c_email_increase = (c_email_new_final -c_email_old_final )./c_email_old_final;

temp = mean(c_email_increase,1);
team_increase_rate(3,:) = temp(1,:);
%% Subsection 4 80%  25 people 
c_email = cell(a_size_total(1,4), days);
r_email = cell(a_size_total(1,4),days);
a_email_total = cell(a_size_total(1,4),days);


for m = 1: a_size_total(1,4)
    for n = 1: days
        [agent_email,~] = agent_interaction_create_email();
        a_email_total{m,n} = agent_email;
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{5,4}{m,n},agent_email, phish_report_rate(1,4), actions_size);
    end
end
checked_email{1,4} = c_email;
report_email{1,4} = r_email;
agent_email_total{1,4} = a_email_total;



%% Create Reported email (Team 4)
% This changes existing phishing email to reported
% This represents the second team receiving a reported email.
c_email = cell(a_size_total(1,4), days);
r_email = cell(a_size_total(1,4),days);
a_email_total = cell(a_size_total(1,4),days);

% need to check the value for 1. If it's a 1, 50/50 that it is reported. If
% it is reported, then don't check.
%agent_email_total{m,n}(1,:);
%size(agent_email_total{m,1}{m,1}(n,:),2);
resolved_email = 0;
for m = 1: a_size_total(1,4)
    for n = 1: days
        
        for o = 1: size(agent_email_total{1,4}{m,n}(1,:),2)
            if agent_email_total{1,4}{m,n}(1,o) == 1
                temp = rand;
                    if temp < phish_report_rate(1,4)
                        agent_email_total{1,4}{m,n}(1,o) = 0;
                        resolved_email = resolved_email+1;
                    end
            end
            agent_email = agent_email_total{1,4}{m,n}(1,:);
        end
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,4}{m,n},agent_email, phish_report_rate(1,4), actions_size);
    end    
end

%% Determining the new checked emails after emails have been reported (Team 4)

c_email_new = zeros(a_size_total(1,4),actions_size);
for i = 1: a_size_total(1,4)
    for j = 1: days
        c_email_new(i,:) = c_email_new(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 4)
c_email_old = zeros(a_size_total(1,4),actions_size);
for i = 1: a_size_total(1,4)
    for j = 1: days
        c_email_old(i,:) = c_email_old(i,:) + cell2mat(checked_email{1,4}(i,j));
    end
end
%% calculate the checked email reduction (Team 4)
c_email_reduction = (c_email_old - c_email_new)./c_email_old;
%% Calculates the average reduction (Team 4)
% This saves the reduction rate of emails from team 2 after team 4 has
% reported phishing emails.
temp = mean(c_email_reduction,1);
team_2_reduction_rate(1,4) = temp(1,2);
%% Create forward email (Team 4)


% This adds phishing email to existing email
% This represents the second team receiving a additional phishing email.
c_email = cell(a_size_total(1,4), days);
r_email = cell(a_size_total(1,4),days);

c_email_old = cell(a_size_total(1,4), days);
r_email_old = cell(a_size_total(1,4),days);
a_email_total = cell(a_size_total(1,4),days);

email_original = cell(a_size_total(1,4),days);


additional_email = 0;
for m = 1: a_size_total(1,4)
    for n = 1: days
        %this creates a number of additional emails that reflects phishing
        %emails that were forwarded
        add_email_index = randi([1, 5],1,1);
        add_email = randi([0, 1],1,add_email_index);

        %This line captures the original amount of emails before adding the
        %additional phishing emails
        agent_email_old = agent_email_total{1,4}{m,n}(1,:);
        email_original{m,n} = agent_email_old;
        
        % This process adds the new forwarded phishing emails to the
        % original emails
        temp = 0;
        temp = [email_original{m,n}, add_email];
        
        agent_email = temp;
        a_email_total{m,n} = agent_email;
       
        %These two lines determines the number of emails that agents
        %checked with the original email and then with the new email (with
        %the forwarded phishing emails)
        [c_email_old{m,n}, r_email_old{m,n}] = calculate_email_report(v_total{1,4}{m,n},agent_email_old, phish_report_rate(1,4), actions_size);
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,4}{m,n},agent_email, phish_report_rate(1,4), actions_size);
    end

end

%% Defined Terms for Team 4

checked_email_new = cell(1, org_size);
report_email_new = cell(1,org_size);

checked_email{1,4} = c_email_old;
report_email{1,4} = r_email_old;

checked_email_new{1,4} = c_email;
report_email_new{1,4} = r_email;

%% Determining the new checked emails after emails have been forwarded (Team 4)

c_email_new_final = zeros(a_size_total(1,4),actions_size);

for i = 1: a_size_total(1,4)
    for j = 1: days
          c_email_new_final(i,:) = c_email_new_final(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email (Team 4)
c_email_old_final = zeros(a_size_total(1,4),actions_size);
for i = 1: a_size_total(1,4)
    for j = 1: days
        c_email_old_final(i,:) = c_email_old_final(i,:) + cell2mat(checked_email{1,4}(i,j));
    end
end
%% calculate the checked email increase (Team 4)
c_email_increase = (c_email_new_final -c_email_old_final )./c_email_old_final;
temp = mean(c_email_increase,1);
team_increase_rate(4,:) = temp(1,:);
%% Display reduction rates
disp("Team 2's reduction of emails due to the reporting of each team ");

for i = 1: org_size
    disp("     Activity " + i + ": " + team_2_reduction_rate(1,i)*100+"%");
end
%% Display increase rates

disp("Increase in click rates due to forwarding phishing emails");
disp("The x values are each of the activities");
disp("The y values are each teams");
team_increase_rate * 100
