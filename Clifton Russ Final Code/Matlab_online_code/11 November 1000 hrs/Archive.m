%% This script is a sandbox to test concepts

%% Creating doors
ext_badge = ones(2,1);% the number of exterior doors with badges
ext_nobadge= ones(2,1); % the number of exterior doors without badges
int_badge = ones(4,1); % the number of interior doors with badges
int_nobadge= ones(20,1);% the numbr of interior doors without badges

%{
1 = closed and secured (lock, badge or guard)
.9 = security guard (regardless of door state)
.75 = closed, but unsecured
.25 = open, unsecured
%}

%% Creates random values for capability of a person committing an incident
%rand_incident = create_Incident(people);
%% test determine incident
%incident = determine_incident(people,threshold);
%%
%network_act = create_Incident(people);
%% 
%%
%Phys_act = create_PhysAct(people);
%% Process to determine random range for each action
%% Test create_workstation
%workstations = create_workstations(people);
%%
% compiling all actions in an array
actions = zeros(1,5);

% For any person, working should be between 40 to 80%
xmin=.4;
xmax=.8;
rand_product= xmin + (xmax-xmin).*rand(1,1);
%%
% For any person, walking should be between .5 to 20%
xmin=.05;
xmax=.2;
rand_walk= xmin + (xmax-xmin).*rand(1,1);
%%
% this is the combination of product and walking and the ceiling for the
% remainder tasks
 action_max = rand_product + rand_walk;
%%
% determining the first action  
xmin= .01;
xmax= 1- action_max; 
rand_action(1,1)  = abs(xmin + (xmax-xmin).*rand(1,1));
%%
% determining the second action
xmin= .01;
xmax= 1 - action_max + rand_action(1,1);
rand_action(1,2)= abs(xmin + (xmax-xmin).*rand(1,1));
%%
% determining the third action
xmin= .01;
xmax= 1 - action_max-(rand_action(1,1) + rand_action(1,2));
rand_action(1,3) = abs(xmin - (rand_action(1,1) +rand_action(1,2)));
%%

%rand_walk= 1- (rand_product + rand_email+rand_surf+rand_chitchat);
%total = rand_chitchat + rand_walk + rand_product + rand_surf + rand_email;
total = sum(rand_action) + action_max; % rand_product +rand_walk;
%%
%generates random order for remaining activities
p = randperm(3,3); 
% assigns random percentages to remaining activities
actions(1,1) = rand_action(p(1,1));
actions(1,2) = rand_action(p(1,2));
actions(1,3) = rand_action(p(1,3));

% assigning the previously determing actions product and walk
actions(1,4) = rand_product;
actions(1,5) = rand_walk;

% calculates the total number of times an action is performed out of a 100
counter = round(actions*100);


%% Random Distribution
p = .7;
select = rand();

if select >= p
    act = 1;
else
    act = 0;
end



%% Process to determine random range for each action

% compiling all actions in an array
actions = zeros(1,2);

% For any person, they should be on the network between 40% to 80%
xmin=.4;
xmax=.8;
actions(1,1)= xmin + (xmax-xmin).*rand(1,1); %online

% For any person, off the network will be the remaining time%
actions(1,2) = 1-(actions(1,1));%offline


%% This tests includes person feature scores
online_actions = 0;
offline_actions = 0;
%b = zeros(1,2); % testing variable to validate loop 
      
% Online activities
 while  online_actions < action_counter(1,1)
         % insert action: compare with environment score
          online_actions = online_actions +1;
          % insert calculation to determine continuation
          %b(1) = b(1)+1;       
 end

 % Offline activities
 while  offline_actions < action_counter(1,2)
         % insert action: compare with environment score
          offline_actions = offline_actions +1;
          % insert calculation to determine continuation
          %b(1) = b(1)+1;       
 end

%% This tests includes person feature scores
day_actions = 0;
b = zeros(1,5); % testing variable to validate loop 
while day_actions <150
      
% Action 1
 while  actions(1,1) > 0
         % insert action
          day_actions = day_actions +1;
          % insert calculation to determine continuation
          b(1) = b(1)+1;
        
         actions(1,1)= actions(1,1)-1;
 end

end
%{
 % Action 2
 while  actions(1,2) > 0
         % insert action
          day_actions = day_actions +1;
          % insert calculation to determine continuation
          b(2) = b(2)+1;
       
          actions(1,2)= actions(1,2)-1;          
 end

% Action 3
  while  actions(1,3) > 0
         % insert action
          day_actions = day_actions +1;
          % insert calculation to determine continuation
          b(3) = b(3)+1;
       
          actions(1,3)= actions(1,3)-1;
          
 end
% Action 4
  while  actions(1,4) > 0
         % insert action
          day_actions = day_actions +1;
          % insert calculation to determine continuation
          b(4) = b(4)+1;
       
        actions(1,4)= actions(1,4)-1;
          
 end
 % Action 5
 while  actions(1,5)> 0
         % insert action
          day_actions = day_actions +1;
          % insert calculation to determine continuation
          b(5) = b(5)+1;
         
        actions(1,5)= actions(1,5)-1;
 end

end

%}
%% This tests includes person feature scores
a = zeros(1,11);
while counter <11
      
r = rand(); % creates a random number from 0 to 1
%actions(1,r) = 1; % assigns the element as true, indicating an action 
a(1,counter+1) = r; % assigns the random variable to a table for reference
% test variables



% Action 1
 while  r > 0 && r<= actions(1,1)
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          b(1) = b(1)+1;
        
         r = 0;
 end
 
 while  r > actions(1,1) && r <= actions(1,1)+ actions(1,2)
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          b(2) = b(2)+1;
       
          r = 0;
          
 end

  while  r > actions(1,1)+ actions(1,2) && r <= actions(1,2)+ actions(1,3)
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          b(3) = b(3)+1;
       
          r = 0;
          
 end

  while  r > actions(1,2)+ actions(1,3) && r <= actions(1,3)+ actions(1,4)
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          b(4) = b(4)+1;
       
          r = 0;
          
 end
 % Action 3       
 while  r > actions(1,3)+ actions(1,4)
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          b(5) = b(5)+1;
         
          r =0;
 end

end
%%
%% testing agent for loop
% this keeps track of individual agent actions. Each day will be limited by
% a number of user actions. Each number of actions will be randomly chosen
% from a range based on a user characteristics. For example, 40% PC, 10% 
% email, 5% lunch, etc.

counter = 0; 
% insert random calculation based off user characteristic

% These are dummy variables used to test the loops
b = zeros(1,5);

% The percentage of time spent on the computer = 70%
on_the_pc = .7;

%while on the computer, the time spent doing activities:
product = .5; % The time spent working on a product
email = .4; % The time spent checking *any* email
surfing = .1; % The time spent websurfing

chit_chat = .2; % The amount of time talking while not on PC (lunch)
walking = .1; % the amount of time spent moving around

% compiling all actions in an array
actions = [email, surfing, chit_chat, product, walking];
% sorting all actions
sorted_actions = sort(actions);

% need to develop way to add "email" to "product" as logical comparison

%%

% Action 1
 while  r > 0 && r<= .7
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          x = x+1;
        
         r = 0;
 end
 
 while  r > .7 && r <= .9
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          y = y+1;
       
          r = 0;
          
 end

 %y = y+1;
 % Action 3       
 while  r > .9
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          z = z+1;
         
          r =0;
 end

% end
%%
a = zeros(1,11);
while counter <11
      
r = randi([1 3],1,1); % creates a random integer from 1 to 3
actions(1,r) = 1; % assigns the element as true, indicating an action 
a(1,counter+1) = r; % assigns the random variable to a table for reference
% test variables

n = size(actions,2);
% Action 1
 while  r == 1 %actions(1,r) == 1
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          x = x+1;
        
         r = 0;
 end
 
 while  r == 2 
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          y = y+1;
       
          r =0;
          
 end

 %y = y+1;
 % Action 3       
 while  r == 3
         % insert action
          counter = counter +1;
          % insert calculation to determine continuation
          z = z+1;
         
          r =0;
 end

end
    %%
if strcmp(test_variable,'true') == 1
    x = 3;
end
%%
%%
% compiling all actions in an array
actions = [rand_product, rand_email, rand_surf, rand_chitchat, rand_walk];
% sorting all actions
sorted_actions = sort(actions);
%%
counter = sorted_actions*100;
%%
%%
e_thresholds = rand(1,15);%environment threshold
e_size = size(e_thresholds,2);%environment size
a_size = size(people,1); %agent size

count = 1; 
agent_vuln_size = size(people{1,3},2);
a_incidents = cell(a_size,agent_vuln_size);
% Separate this to compare each agent vuln score to each array of
% environment thresholds. This is because the number of controls grouping
% together will be different.

% There should be agent size number of rows for each grouping of enviroment
% of controls for each particular vulnarability. For example, for agent
% vulnerability door access, each agent door access score will be compared
% to the total number. 

% Each column will represent the different agent vulnerability score. For
% example, if there are 50 agents with 6 vulnerability scores, the cell
% will have 50 rows and 6 columns. Within each cell, there will be an array
% with n length of controls.
n = size(a_incidents,2);
m = 0; % counter for the number of agent vulnerabilities
while count < n %sorts through the agents
    while m < agent_vuln_size % sorts through the vulnerabilities
        for i = 1: agent_vuln_size
            for j = 1:e_size
                if a_incidents(count,i) > e_thresholds(1,j)
                    %e_vuln =
                end
            end
            m = m+1;
        end
        
    end
    m = 0;
    count = count +1;
end
%%
e_thresholds = rand(1,15);%environment threshold
e_size = size(e_thresholds,2);%environment size
a_size = size(people,1); %agent size
a_incidents = zeros(a_size,e_size); % agent incident % Make this a cell
%count = 0;%43;
agent_vuln_size = size(people{1,3},2);

%adjust loop to compare specific agent vulnerability to specific
%environment scores. Currently, each control is compared to the first vuln
%score of each user.

%while count < 43
for i = 1:e_size
    for j = 1:a_size
        %for k = 1: agent_v_size
            if people{j,3}(1,1) > e_thresholds(1,i)
                a_incidents(j,i) = 1;
            end
        %end
    end
end
%count = count +1;
%end
%%
e_thresholds = rand(1,15);
e_size = size(e_thresholds,2);
a_size = size(people,1);
a_incidents = zeros(a_size,e_size);
%count = 0;%43;
agent_vuln_size = size(people{1,3},2);

%adjust loop to compare specific agent vulnerability to specific
%environment scores. Currently, each control is compared to 6 vuln scores
%for each user. Not every user vuln score is applicable. 
%while count < 43
for i = 1:e_size
    for j = 1:a_size
        %for k = 1: agent_v_size
            if people{j,3}(1,1) > e_thresholds(1,i)
                a_incidents(j,i) = 1;
            end
        %end
    end
end
%count = count +1;
%end

%%

%{
a = 50;
b = 125;

total_actions = round(a + (b-a).*rand(1,1));% this is the number of work days being calculated
online_percentage = xmin + (xmax-xmin).*rand(1,1); % this calculates the percentage
offline_percentage = 1-online_percentage;

online_actions = round(total_actions * online_percentage);
offline_actions = round(total_actions * offline_percentage);

%}

%%
%environment_thresholds = rand(1,50);
e_thresholds = rand(1,15);
e_size = size(e_thresholds,2);
a_size = size(people,1);
a_incidents = zeros(a_size,e_size);
count = 0;%43;
a_vuln_size = size(people{1,3},2);

%adjust loop to compare specific agent vulnerability to specific
%environment scores. Currently, each control is compared to 6 vuln scores
%for each user. Not every user vuln score is applicable. 
%while count < 43

% Additionally, the loop is replacing it self. It needs to loop through the
% cell. Find the size of each e_threshold entry and that should be the
% value of "i". e_size appears to be the value of "1".
for i = 1:e_size
    for j = 1:a_size
        for k = 1: a_vuln_size
            if people{j,3}(1,k) > e_thresholds(1,i)
                a_incidents(j,k) = 1;
            end
        end
    end
end
%%

for i = 1:a_vuln_size
    for j = 1:a_size
        for k = 1: a_vuln_size
            if people{j,3}(1,k) > e_thresholds(1,i)
                a_incidents(j,k) = 1;
            end
        end
    end
end
%count = count +1;
%end

%%

%{
%% Probability Density Function
x = [0,1];
n = 1;
p = .1;
binopdf(x,n,p);
%%


%compliance = zeros(1,7);
xmin=0;
xmax=1;

%compliance(1,1)= xmin + (xmax-xmin).*rand(1,1);
compliance = xmin + (xmax-xmin).*rand(1,1);
a = 0; b = 0; c = 0;
n = 6;
%if compliance(1,1) <.50
%    xmin=0;
 %   xmax=1;
%    compliance(1,n)= xmin + (xmax-xmin).*rand(1,1);

%end
agent_vuln = zeros(1,6);
if compliance <.50
    for i = 1:n
        xmin = 0;
        xmax = .5;
        agent_vuln(1,i) = xmin + (xmax-xmin).*rand(1,1);
        agent_vuln(2,i) = agent_vuln(1,i)*.1;
        a = a +1;
    end
end

if compliance >= .50 && compliance < .75
    for i = 1:n    
        xmin = .5;
        xmax = .75;
        agent_vuln(1,i) = xmin + (xmax-xmin).*rand(1,1);
        agent_vuln(2,i) = agent_vuln(1,i)*.1;
        b = b+1;
    end
end 

if compliance (1,1)>= .75 
    for i = 1:n
        xmin = .75;
        xmax = 1;
        agent_vuln(1,i) = xmin + (xmax-xmin).*rand(1,1);
        agent_vuln(2,i) = agent_vuln(1,i)*.1;
        c = c+1;
    end
end
%}

%%
xmin = .4;
xmax = .8;
[x, y] = determine_daily_actions(xmin,xmax);
%%
%% Online vs offline
% For any person, they should be on the network between 40% to 80%
xmin=.4;
xmax=.8;

days = zeros(num_days,2);

for i = 1: num_days
   [online, offline] = determine_daily_actions(xmin, xmax);
    days(i,1) = online;
    days(i,2) = offline;
end

%%
%% create 
n = 100;% input n, min_max
% This creates a cell array of the baseline attributes for the agents. This
% will then be used to calculate each day.
mc_baseline = cell(n,1); 

for i = 1:n
    min_max = zeros (2,5);

    action_counter = determine_state_num(actions,min_max);
    mc_baseline{i,1} = action_counter; %fix this
end

%%

days = 20;
mc_size = size(mc_baseline,1);
action_size = size(mc_baseline{1,1},2);
%mc_daily = cell(action_size,action_size);
mc_day = cell(mc_size,action_size);
mc_daily = cell(mc_size,1);



for k = 1:days
for i = 1: mc_size
    for j = 1:action_size   
        min = mc_baseline{i,1}(1,j)-(.1*mc_baseline{i,1}(1,j));
        max = mc_baseline{i,1}(1,j)+(.1*mc_baseline{i,1}(1,j));
        mc_day{i,j} = round(min + (max-min).*rand(1,1));
        mc_daily{i,k} = [mc_day{i,:}];
    end
end
end
 %% Comparing agent threat score to threshold score (Scrap)
n = 6; %size(people{1,3},2);
m = 15; %size(thresholds,2);
a_incidents = zeros(n,m);
people = rand(1,n);
thresholds = rand(1,m);
for i = 1:n %agent_vuln_size
    for j = 1:m %e_thresholds
        if people(1,i) > thresholds(1,j)
            a_incidents(i,j) = 1;
        end
    end
end
%%
% compiling all actions in an array
actions = zeros(1,5);

% For any person, working should be between 40 to 80%
xmin=.4;
xmax=.8;
rand_product= xmin + (xmax-xmin).*rand(1,1);
%%
% For any person, walking should be between .5 to 20%
xmin=.05;
xmax=.2;
rand_walk= xmin + (xmax-xmin).*rand(1,1);
%%
% this is the combination of product and walking and the ceiling for the
% remainder tasks
 action_max = rand_product + rand_walk;
%%
% determining the first action  
xmin= .01;
xmax= 1- action_max; 
rand_action(1,1)  = abs(xmin + (xmax-xmin).*rand(1,1));
%%
% determining the second action
xmin= .01;
xmax= 1 - (action_max + rand_action(1,1));
rand_action(1,2)= abs(xmin + (xmax-xmin).*rand(1,1));
%%
% determining the third action
xmin= .01;
xmax= 1 - (action_max-(rand_action(1,1) + rand_action(1,2)));
rand_action(1,3) = abs(xmin - (rand_action(1,1) +rand_action(1,2)));
%%

%rand_walk= 1- (rand_product + rand_email+rand_surf+rand_chitchat);
%total = rand_chitchat + rand_walk + rand_product + rand_surf + rand_email;
total = sum(rand_action) + action_max; % rand_product +rand_walk;
%%
%generates random order for remaining activities
p = randperm(3,3); 
% assigns random percentages to remaining activities
actions(1,1) = rand_action(p(1,1));
actions(1,2) = rand_action(p(1,2));
actions(1,3) = rand_action(p(1,3));

% assigning the previously determing actions product and walk
actions(1,4) = rand_product;
actions(1,5) = rand_walk;

% calculates the total number of times an action is performed out of a 100
counter = round(actions*100);



%% Calculates the counter
% calculates the total number of times an action is performed out of a 100
action_counter = round(actions*100);
%% Markov Chains

% listed states: walking/talking (offline [1]), work (online/offline [2]), 
% email (online [3]),internet surfing (online[4])

P = randi(5,5); %creates random matrix (for testing). Replace with real data
%%
markov = dtmc(P); %creates markov chain from random matrix
%%  markov chain percentages

markov_percentages = markov.P;
 
%% Label State names
markov.StateNames = ["Walking" "Working" "Web Browsing" "Emailing" "other"];

%% view

figure;
graphplot(markov, 'ColorEdges', true);
%%
mc_steps = 10;
%x0 = 3;```
%x = simulate(markov, mc_steps);
mc_sim = simulate(markov, mc_steps);


%%
figure;
simplot(markov,mc_sim);

%% Create 5 x5 Markov chain
% After the initial random run of actions, 4 additional runs will take
% place with values +/- 10% of the initial run. Collectively, this will
% create the square matrix necessry for Markov Chain. 
agent_actions = zeros(5,5);
agent_actions(1,:) = action_counter;



for i = 1:5
    for j = 2:5
        min = action_counter(1,i)-(.1*action_counter(1,i));
        max = action_counter(1,i)+(.1*action_counter(1,i));
        agent_actions(j,i) = round(min + (max-min).*rand(1,1));
         
    end
end
%%
%% Determine Markov

% Establishing a 5x5 by taking the first 5 runs. This needs to be updated
% to incorporate 5 runs

%[markov, mc_steps, mc_sim] = determine_Markov(action_counter);

%%
mc_size = size(mc_baseline,1);
mc_incident = cell(mc_size,1);
for i = 1:mc_size
    if mc_baseline(i,1) == 1
        
        control_size = size(e_thresholds{1,:},2);
    
        mc_incident{i,1} = determine_incident(people(1,3),e_thresholds(1,:));
        

    elseif mc_baseline(i,1) == 2
         control_size = size(e_thresholds{2,:},2);
    
         mc_incident{i,1} = determine_incident(people(1,3),e_thresholds(2,:));

    elseif mc_baseline(i,1) == 3
         control_size = size(e_thresholds{3,:},2);
    
         mc_incident{i,1} = determine_incident(people(1,3),e_thresholds(3,:));

    elseif mc_baseline(i,1) == 4
         control_size = size(e_thresholds{4,:},2);
    
         mc_incident{i,1} = determine_incident(people(1,3),e_thresholds(4,:));

    elseif mc_baseline(i,1) == 5
         control_size = size(e_thresholds{5,:},2);
    
         mc_incident{i,1} = determine_incident(people(1,3),e_thresholds(5,:));
    end

end
%%
% create loop where input argument is mc_incident{i,1}.
% mc_size = size(mc_incident{1,1},1)
% second forloop that cycles through the steps
% if mc_baseline{i,1} = 1,2,3,4,5
% total_vuln(1,1) = total_vuln(1,1)+total_vuln(1,1)

A = mc_incident{1,1};
A_size = size(A,1);
total_vuln = zeros(A_size,6);
%%
for i = 1: A_size
    if(mc_baseline{1,1}(i,1))== 1
        total_vuln(i,1) = 1;
    end

    if(mc_baseline{1,1}(i,1))== 2
        total_vuln(i,2) = 1;
    end

    if(mc_baseline{1,1}(i,1))== 3
        total_vuln(i,3) = 1;
    end

    if(mc_baseline{1,1}(i,1))== 4
        total_vuln(i,4) = 1;
    end

    if(mc_baseline{1,1}(i,1))== 5
        total_vuln(i,5) = 1;
    end
end
%%
% This summarizes all the incidents within by the day
by_day_sum = zeros(1,days);
for i = 1: days
    by_day_sum(1,i) = sum([incident_array{:,i}]);
end

%%
b = bar(by_day_sum)
title('Total Incidents by the day (10 people)')
xlabel('Days')
ylabel('Incidents')
%%

% This summarizes all the incidents by the person
by_agent_sum = zeros(a_size,1);
for i = 1: a_size
    by_agent_sum(i,1) = sum([incident_array{i,:}]);
end

%%
b = bar(by_agent_sum)
title('Total Incidents by the person (15 days)')
xlabel('Person ID')
ylabel('Incidents')
%%
%test toArray
incident_total = cell(a_size,1);

for i = 1: a_size
    for j = 1:days
        incident_total{i,1} = toArray(incident_array{:,j},vuln_size);
    end
end
%%

%function [a_breach] = determine_breach(incidents,incident_threshold)

% the incident threshold is a percent. Creates a forloop where threshold is
% compared to random number
incidents = incident_array{4,1};
incident_threshold = [.15, .10, .05, .03, .20, .02 ];
incident_size = size(incidents,2);
%a_breach = zeros(1,n);
a_breach = cell(1,1);
temp_total = zeros(1,incident_size);
for i = 1:incident_size % each element
    %for j = 1: incidents(1,i) %total amount of incidents per type
        temp = rand(1,1);
        temp_total(1,i) = temp; 
        % Fix this!
        if temp < incident_threshold(1,i) %percent of a breach
            a_breach{1,1}(1,i) = 1; % this needs to be changed to be a cell
        else
            a_breach{1,1}(1,i) = 0;
        end
    %end
    
end

%% To do

% Need to change steps in mc_baseline. The number of rows are incorrect.
% The number of steps represent the number of actions taken in a single
% day. Step one: Calculate baseline for day 1. Step 2: Calculate 4
% additional days based off +/- 10%. This will create a 5x5 matrix. Step 3,
% determine the markov chain with the n x n matrix, where n is based on the
% number of states. Step 4, sum the number of states of the mc_baseline as
% the total steps. Step 5, simulate a day using the markov chain and steps
%%
% This creates a cell of environment thresholds. Each row represents an
% incident. Within each cell, there is an array of vulnerability thresholds
% associated with each control related to that incident. For example, a
% phishing incident might have 20 related controls while a compromised
% password might have 15 related controls. For the phishing incident, there
% would be a 1 x 20 array where each column is the control ( or
% environment) threshold. 
e_thresholds = cell(6,1); % environment thresholds
for i = 1: 6
    r = randi([5 25],1, 1);
    e_thresholds{i,1} = rand(1,r);
end

%%
e_thresholds{1,1} = [.95, .85, .90, .99, .75];
%%
%e_size = size(e_thresholds,2);%environment size
a_size = size(people,1); %agent size
a_vuln_size = size(people{1,3},2);
a_incidents = cell(a_size,a_vuln_size);
% In this spot, determine the amount of actions per agent for each day

%% Determine the amount of days
num_days = 75; % this is the number of work days being calculated

%%
for i = 1: a_size
    for j = 1:a_vuln_size
        a_incidents{i,j} = determine_incident(people{i,3}(1,:),e_thresholds{j,1}(1,:));
    end
end
%% Determine the size of the thresholds for each control
e_size = size(e_thresholds,1);
control_size = zeros(e_size,1);
for i = 1 : e_size
    control_size(i,1) =  size(e_thresholds{i,:},2);
end


%% Calculates the a_incident score.
% For each agent, their threat score (as defined within People) are
% compared to sets of RMF control threshold scores relevant to the threat
% score. For example, phishing threat scores are related to controls where
% a noncompliance in an RMF control would yield a vulnerability to phishing

a_size = size(people,1);

for i = 1:a_size % number of agents
    for j = 1:e_size % number of incident type
        for k = 1: control_size(j) % number of selective controls
            if people{i,3}(1,j) > e_thresholds{j,1}(1,k)
                a_incidents{i,j}(j,k) = 1;
            end
        end
    end
end
%% Create a function that takes an action based on MC state
% At each step of the MC, an incident check
% will occur based on the related environmental controls. 

% input mc_baseline,
%mc_size = size(mc_baseline,1);
%test = size()
state_size = size(mc_baseline{1,1},2);
% This sorts through each entry of the mc_baseline. Each entry represents a
% different day.
for i = 1: state_size 
    % This loop sorts through the each sum of states within each day. For
    % example, within day 1, the agent might be at state 1 50 times, state
    % 2 20 times, state 3 10 times, state 4 5 times and state 5 2 times. At
    % each state, the agent will be exposed to the same vulnerabilities
    % associated with the environment for that state. For example, if state
    % 1 is "checking email", and the agent is in this state for 50 times,
    % then code will compare the agent threat score to the environment
    % threshold that is related to "checking email" 50 different times.
    for j = 1:mc_baseline{1,1}(1,i)
        % if i = 1
        %test
    end
end
%% Read file name
filename = 'RMF_Control_Status.xlsx';
RMF_Control_Status = readtable(filename);

%%
e_size = size(e_thresholds,1);
control_size = zeros(e_size,1);
for i = 1 : e_size
    control_size(i,1) =  size(e_thresholds{i,:},2);
end
%%

%a_size = size(people,1); %agent size
a_vuln_size = size(people{1,3},2);
a_incidents = cell(1,a_vuln_size);

%a_incidents = cell(a_size,a_vuln_size);
% In this spot, determine the amount of actions per agent for each day
%% Calculates the a_incident score.
% For each agent, their threat score (as defined within People) are
% compared to sets of RMF control threshold scores relevant to the threat
% score. For example, phishing threat scores are related to controls where
% a noncompliance in an RMF control would yield a vulnerability to phishing

%a_size = size(people,1);
%a_incidents = cell(a_size,a_vuln_size);

    for j = 1:e_size % number of incident type
        for k = 1: control_size(j) % number of selective controls
            if people{1,3}(1,j) > e_thresholds{j,1}(1,k)
                a_incidents{1,j}(j,k) = 1;
            end
        end
    end
%% This determines which e_threshold data to use based on the current state


%%

sum(mc_incident{1,1}{1,1}{1,1});
%%

% size(mc_incident{1,1},1)
% mc_incident{1,1}
temp = size (150,days);
incident_counter = zeros();
for i = 1:a_size %(the number of agents)
    for j= 1:days %(the amount of days)
        for k= 1: size(mc_incident{i,1},1) %number of steps
             %insert work
        end
    end
end



    %%
   % A = mc_incident{1,1};
    %[incident_count,incident_sum] = calculate_total(A,mc_baseline);

    [incident_count,incident_sum] = calculate_total(mc_incident{1,1},mc_baseline);
 %[incident_count,incident_sum] = calculate_total(mc_incident,mc_baseline);
    %%
incident_array = cell(1,days);
    for i = 1:days
         incident_array{1,i} = calculate_total(mc_incident{1,i},mc_baseline);
    end

    %%
    mc_size = size(mc_baseline{1,1},1);

    temp = 0;
    incident_count = zeros(1,vuln_size);
    for i = 1: mc_size
    if(mc_baseline{1,1}(i,1))== 1
        temp = sum(mc_incident{1,1}{1,1}{1,1});
        incident_count(1,1) = incident_count(1,1) + temp;
        
        %incident_count(i,1) = 1;
    end
    end
%%
% This is to reduce the incidents associated with the first stage

    
    %% Calculate all incidents for each day with each person
incident_array = cell(a_size,days);
incident_total = zeros(a_size,days);
    for i = 1:a_size 
        for j = 1:days
         %incident_total{i,j} = calculate_total(mc_incident{i,j},mc_baseline);
        [incident_count, incident_sum] = calculate_total(mc_incident{i,j},mc_baseline);
        incident_array{i,j} = incident_count;
        incident_total(i,j) = incident_sum;
        end
    end
%% Incidents by the day
%incident_array{2,1} + incident_array{4,1}

%by_day = zeros(1,days);
%by_day{i,1} = sum(incident_array(i,1));
%for i = 1: days
 %   by_day(1,i) = sum([incident_array{:,i}]);
%end
%%
%{
by_the_incident = zeros(a_size, vuln_size);
for i = 1: a_size
    for j = 1:vuln_size
        by_the_incident(i,j) = by_the_incident(i,j) + incident_array[1,1](i,j);
    end
end
%}
%% This puts all the cell entries into the array

temp = zeros(a_size,vuln_size);
for i = 1:a_size
    temp(i,:) = incident_array{i,:};
end
%temp = sum([incident_array{:,1}, ])
%temp = sum([incident_array{:,1}])

%%
e_size = size(e_thresholds,1);
e_threshold_mean = zeros(e_size,1);
for i = 1: vuln_size
    e_threshold_mean(i,1) = mean(e_thresholds{i,1}(1,:));
end
%%
%% Count the number of controls
control_info = zeros(1,6);
for i = 1 : e_size 
    control_info(1,i) = size(e_thresholds{i,1},2);
end
%%

%{
mc_count(1,1) = nnz(mc_baseline{1,1}==1);
mc_count(1,2) = nnz(mc_baseline{1,1}==2);
mc_count(1,3) = nnz(mc_baseline{1,1}==3);
mc_count(1,4) = nnz(mc_baseline{1,1}==4);
mc_count(1,5) = nnz(mc_baseline{1,1}==5);

for i = 1:actions_size
    mc_count(1,i) = nnz(mc_baseline{1,1} == i);
end
%}

%% Multiplying the number of controls by Steps

a = toArray(e_thresholds(1,:),control_info(1,1));
b = toArray(e_thresholds(2,:),control_info(1,2));
c = [a b];
%total_count (1,1) = mc_count(1,1)*
%%
%%
%agent =.17;    
temp1 = zeros(1,control_size(1,1));
temp2 = zeros(1,control_size(1,2));
        agent = people{1,3}(1,1);
        temp4 =  cell2mat(determine_incident(agent,control_cell(1,1)));
        temp1 = temp1+ cell2mat(determine_incident(agent,control_cell(1,1)));
        
        % This determines the incidents for the controls in respect to the
        % second threat and then converts it into a matrix.
        temp2 = temp2 + cell2mat(determine_incident(agent,control_cell(1,2)));
        
        %Since this state involves vulnerabilities in respect to both
        %threats 1 and 2, both sets of controls are combined to represent
        %the total amount of vulnerabilities.
       
        temp3 = [temp1 temp2];
        %A{1,1} = zeros(1,control_size(1,1)+control_size(1,2));
        A{1,1} = temp3;

%%


agent = people{1,3}(1,1); %This scrolls through all agents
        temp1 = cell2mat(determine_incident(agent,control_cell(1,1)));
        temp2 = cell2mat(determine_incident(agent,control_cell(1,2)));

        %c_family_incident{i,1} = c_family_incident{i,1} + temp1 + temp2;
        %determine_incident(agent,control_cell(1,1));

%%
incident_count = zeros (2,2);

        if mc_baseline{2,1}(37,1)== 1  
             temp = sum(mc_incident{2,1}{37,1}{1,1});
             incident_count(1,1) = incident_count(1,1) + temp;
        end

         if mc_baseline{2,1}(1,1)== 5  && isequal(mc_incident{2,1}(1,1),0)
             temp = sum(mc_incident{2,1}{37,1}{1,1});
             incident_count(1,2) = incident_count(1,2) + temp;
        end
%% Create training labels
%iteration = 100;
%[training_data] = create_training_data(control_compliance, vuln_size, iteration);
%training_data = e_threshold_mean;
%% Summarize incidents
% This section summarizes the total incidents by category for each person
% for all days
%a_size = size(array_incident,1);
incident_stack = array_incident(:);
incident_size = size(incident_stack,1);
incident_information = toArray(incident_stack,vuln_size);
incident_sum = sum(incident_information); % Numerator
incident_final = [incident_sum(1,1) + incident_sum(1,2), incident_sum(1,4) + ...
    incident_sum(1,3), incident_sum(1,3) + incident_sum(1,1), incident_sum(1,6) + ...
    incident_sum(1,5), incident_sum(1,3) + incident_sum(1,5)];
% Calculate the incidents per stage as opposed to total or calculate each
% total possible incidents per category

%%
 %%
% This section calculates the amount of controls for each vulnerability.
% E1 represents the first vulnerability. The following 6, e_1, e_2, etc.
% represents the controls associated for each family. In this example,
% it's a coincidence that there are 6 vulnerabilities and 6 controls. E2
% represents the second vulnerability, with the -1,2,3..6 representing the
% corresponding controls.

%This section puts all the scores into a single array, then into a cell
%where control count 1,1 represents all the controls for that particular
%vulnerability. 

% This is necessary when predicting the likelihood of a compromise by
% evaulating the controls associated with the vuilnerability. 
% Calculating the controls for the first vulnerability 
e1_1 = toArray(e_thresholds(1,:),control_size(1,1));    
e1_2 = toArray(e_thresholds(2,:),control_size(2,1));
e1_3 = toArray(e_thresholds(3,:),control_size(3,1));
e1_4 = toArray(e_thresholds(4,:),control_size(4,1));
e1_5 = toArray(e_thresholds(5,:),control_size(5,1));
e1_6 = toArray(e_thresholds(6,:),control_size(6,1));
control_count{1,1} = [e1_1 e1_2 e1_3 e1_4 e1_5 e1_6];

% Calculating the controls for the second vulnerability
e2_1 = toArray(e_thresholds(1,2),control_size(1,2));    
e2_2 = toArray(e_thresholds(2,2),control_size(2,2));
e2_3 = toArray(e_thresholds(3,2),control_size(3,2));
e2_4 = toArray(e_thresholds(4,2),control_size(4,2));
e2_5 = toArray(e_thresholds(5,2),control_size(5,2));
e2_6 = toArray(e_thresholds(6,2),control_size(6,2));
control_count{1,2} = [e2_1 e2_2 e2_3 e2_4 e2_5 e2_6];

% Calculating the controls for the third vulnerability
e3_1 = toArray(e_thresholds(1,3),control_size(1,3));    
e3_2 = toArray(e_thresholds(2,3),control_size(2,3));
e3_3 = toArray(e_thresholds(3,3),control_size(3,3));
e3_4 = toArray(e_thresholds(4,3),control_size(4,3));
e3_5 = toArray(e_thresholds(5,3),control_size(5,3));
e3_6 = toArray(e_thresholds(6,3),control_size(6,3));
control_count{1,3} = [e3_1 e3_2 e3_3 e3_4 e3_5 e3_6];


% Calculating the controls for the fourth vulnerability
e4_1 = toArray(e_thresholds(1,4),control_size(1,4));    
e4_2 = toArray(e_thresholds(2,4),control_size(2,4));
e4_3 = toArray(e_thresholds(3,4),control_size(3,4));
e4_4 = toArray(e_thresholds(4,4),control_size(4,4));
e4_5 = toArray(e_thresholds(5,4),control_size(5,4));
e4_6 = toArray(e_thresholds(6,4),control_size(6,4));
control_count{1,4} = [e4_1 e4_2 e4_3 e4_4 e4_5 e4_6];

% Calculating the controls for the fifth vulnerability
e5_1 = toArray(e_thresholds(1,5),control_size(1,5));    
e5_2 = toArray(e_thresholds(2,5),control_size(2,5));
e5_3 = toArray(e_thresholds(3,5),control_size(3,5));
e5_4 = toArray(e_thresholds(4,5),control_size(4,5));
e5_5 = toArray(e_thresholds(5,5),control_size(5,5));
e5_6 = toArray(e_thresholds(6,5),control_size(6,5));
control_count{1,5} = [e5_1 e5_2 e5_3 e5_4 e5_5 e5_6];

% Calculating the controls for the sixth vulnerability
e6_1 = toArray(e_thresholds(1,6),control_size(1,6));    
e6_2 = toArray(e_thresholds(2,6),control_size(2,6));
e6_3 = toArray(e_thresholds(3,6),control_size(3,6));
e6_4 = toArray(e_thresholds(4,6),control_size(4,6));
e6_5 = toArray(e_thresholds(5,6),control_size(5,6));
e6_6 = toArray(e_thresholds(6,6),control_size(6,6));
control_count{1,6} = [e6_1 e6_2 e6_3 e6_4 e6_5 e6_6];

%%
 %agent = people{3,3}(1,1);
agent = .89;

 e_1 = toArray(e_thresholds(1,1),control_size(1,1));
 temp = det_incident2(agent,e_1);
 control_tally = zeros(1,size(temp,2));
 control_tally = control_tally + temp;
        %temp1 = determine_incident(agent,control_size(1,1));
        %temp2 = toArray(temp1(1,1),control_size(1,1));
       % temp2 = toArray(control_incident(1,1),control_size(1,1));

        %control_incident{1,1} = temp1+temp2;
 

        %temp1 = determine_incident(agent,e_thresholds(1,1));
        %temp2 = toArray(temp1(1,1),control_size(1,1));
        %temp3 = toArray(control_incident(1,1),control_size(1,1));
        %temp2 = zeros(1,control_size(1,1));
        %temp2 = temp2 + sum(temp1{1,1},1);
        %temp2 = sum(temp1{1,1},1);
        %control_incident{1,1} = temp3+temp2;

        %control_incident{1,1} = determine_incident(agent,e_thresholds(1,1));
        %temp = sum(control_incident{1,1},1);
        %control_incident{1,1} = control_incident{1,1} + temp;
%%

[incident_count, incident_sum] = calculate_total(mc_incident,mc_baseline,vuln_size);
        %%

agent = .3;
        temp1 = determine_incident(agent,e_thresholds(1,1));
        %%
        temp2 = toArray(temp1(1,1),control_size(1,1));
        %%
        temp3 = toArray(control_incident(1,1),control_size(1,1));
        %%
        
        control_incident{1,1} = temp3+temp2;

        %%
e_thresholds = cell(num_control,vuln_size);
e_size = size(e_thresholds,2);
control_size = zeros(e_size, num_control);
%%

e_thresholds = cell(num_control,vuln_size); % environment thresholds
min =.45;
max =.95;
%e_thresholds{i,1} = rand(1,r);

for i = 1: vuln_size
    for j = 1: num_control
        r = randi([5 25],1, 1);
        e_thresholds{i,j}= min + (max-min)*rand(1,r);
    end
    %e_thresholds{i,1} = rand(1,r);
end
%%

for i = 1 : e_size
    for j = 1:num_control
        control_size(i,j) = size(e_thresholds{i,j},2);
    end
end
%%

e_threshold_1 = toArray(e_thresholds(1,:),control_size(1,1));
e_threshold_2 = toArray(e_thresholds(2,:),control_size(2,1));
control_count{1,1} = [e_threshold_1 e_threshold_2];


%% This adjusts the number of controls for each stage

% For each stage, only certain vulnerabilities are applicable. 
% In this instance, stage 1 is vulnerable to vulnerability groups 1 and 2.
%{ 
control_size(1,1) = control_info(1,1) + control_info(1,2);
control_size(1,2) = control_info(1,4) + control_info(1,3);
control_size(1,3) = control_info(1,3) + control_info(1,1);
control_size(1,4) = control_info(1,6) + control_info(1,5);
control_size(1,5) = control_info(1,3) + control_info(1,5);

%}
%%
agent = people{1,3}(1,1);
control_incident{1,1} = determine_incident(agent,e_thresholds(1,1));
       % temp = sum(control_incident{1,1}(1,1),2);
        %control_incident{1,1} = control_incident{1,1} + temp;

%% Count the number of times an agent as at a stage per day.
%[mc_count] = determine_mc_count(actions_size, mc_baseline);

%% For loop for determine_mc_count
mc_count = cell(a_size,days);
% This counts the number of stages per day
for i = 1: a_size
    for j = 1: days
        mc_count{i,j} = determine_mc_count(actions_size, mc_baseline(i,j));
    end
end

%% This stacks the number of stages
temp = mc_count(:);
%% This converts the stack (cell) into an array
%mc_array_size = zeros(mc_count_stack,1);
%mc_count_array = toArray(mc_count_stack,vuln_size);

mc_count = toArray(temp,actions_size);
%% Summarizes mc_count
mc_count_total = sum(mc_count);
 %% Calculates the total possibilities for an incident per day
 incident_max = mc_count_total .* control_size; 
 incident_max = sum(incident_max,1);
 % this is the denominator for the input data
%% This represents the ratio of incidents committed to the total possible incidents
%training_labels = incident_final./incident_max;
%training_data = control_compliance;

str_array = [ "A" "B"; "B" "C"; "C" "D"; "D" "E"; "E" "F"];
%{
str_cell = cell(5,1);
str_cell{1,1} = ["A","B"];
str_cell{2,1} = ["G","C"];
str_cell{3,1} = ["H","D"];
str_cell{4,1} = ["I","E"];
str_cell{5,1} = ["J","F"];
%}
%{
char_cell = cell(5,1);
char_cell{1,1} = ['A';'B'];
char_cell{2,1} = ['G';'C'];
char_cell{3,1} = ['H';'D'];
char_cell{4,1} = ['I';'E'];
char_cell{5,1} = ['J';'F'];
%}
%training_labels = char_cell; %rand(5,1);
%training_labels = str_cell; 
training_labels = str_array; 
training_data = rand(5,10);
%%
%%
N = 10;
for k = 1:N
    my_field = strcat('v',num2str(k));
    variable.(my_field) = k*2;
end
%%
%e_size = 7;
m = 3;
for i = 1:e_size
    my_field = strcat('e',num2str(m),'_',num2str(i));
    variable.(my_field) = toArray(e_thresholds(1,i),control_size(1,i));
end

%% This calls the "create e variable" function
    variable = create_e_variable(e_thresholds, control_size, num_control,e_size);
    %%
    %%

for i = 1: num_control
    for j = 1: vuln_size 
        min =.45;
max =.95;
        r = randi([5 25],1, 1);
        e_thresholds{i,j}= min + (max-min)*rand(1,r);
    end
end


%%

%%
for P = 1: num_control
    for Q = 1: vuln_size 
        min = e_thresholds{P,1}(1,Q)-(.1*e_thresholds{P,1}(1,Q));
        max = e_thresholds{P,1}(1,Q)+(.1*e_thresholds{P,1}(1,Q));
        r = randi([5 25],1, 1);
        e_thresholds2{P,Q}= min + (max-min)*rand(1,control_size(P,Q));
    end
end
%%
e_temp = zeros(1,vuln_control_size(1,1)); % environment thresholds
for i = 1: vuln_control_size(1,1)   
        min = vuln_control_count{1,1}(1,i)-(.05*vuln_control_count{1,1}(1,i));
        max = vuln_control_count{1,1}(1,i)+(.05*vuln_control_count{1,1}(1,i));
        e_temp(1,i) = min + (max-min).*rand(1,1);
end   
%%
e_daily = cell(1, days);
for i = 1: days
     e_daily{1,i} = create_new_env_score(vuln_control_count, vuln_control_size);
end
%%
%cell2mat(e_daily(1,1))
e_daily2 = e_daily';
input = cell2mat(e_daily2);
%%
e_temp = cell(num_control, vuln_size);   
        min = e_thresholds{P,1}(1,Q)-(.1*e_thresholds{P,1}(1,Q));
        max = e_thresholds{P,1}(1,Q)+(.1*e_thresholds{P,1}(1,Q));
        e_temp(P,Q) = min + (max-min).*rand(1,1);


%%
for i = 1:num_control
    for j = 1:vuln_size
        e_thresholds2{i,j} = create_new_env_score(e_thresholds(i,j),control_size(i,j));
    end
end
%%
% control_count
% control_cell
%control_count{1,1} = [e_thresholds{:,1}];
%{
vuln_control_values = cell(1,e_size);

for i = 1:e_size
    vuln_control_values{1,i} = [e_thresholds{:,i}];
end
%}

%%
%%
%mdl = fitcnet(training_data, training_labels);
% Training_data is the vuln_control_count 
%%
% This ranks the features
%AC_test = rand(100,30);
%[idx, score] = fsulaplacian(AC_test);

%%
%{
training_info = zeros(a_size,e_size);
training_size = size(array_incident,1);

for i = 1: training_size
    for j = 1: days
        temp = toArray(array_incident(i,j),vuln_size);
        training_info(i,:) = temp;
        %training_data = vertcat(training_data(i,:),temp);
    end
end
%}
%%

%training_sum = sum(training_info);


%% Random Forrest
%%
%mdl = fitcensemble(training_data,training_labels, 'Method', 'Bag', 'NumLearningCycles',100,'KFold',10);
% Naive Bayes Model
%mdl = fitcnb(training_data, training_labels);
%%
% K-nearest neighbor
%mdl = fitcknn(training_data, training_labels);
%%
% multiclass SVM
mdl = fitcecoc(training_data, training_labels);
%%
% Neural Network
%mdl = fitcnet(training_data, training_labels);
%net = patternnet(10);
%view(net);
%[net, tr] = train(net,training_data', training_labels');

%% Predicting the data using Linear Regression Model
%Yfit = predict(mdl,predict_data);

Yfit = predict(mdl.Trainable{10,1}.Trained{100},predict_data);
%% Predicting the data using Linear Regression Model
%Yfit = predict(mdl,predict_data);
%Yfit = predict(mdl.Trainable{1,1}.Trained{1},predict_data);
%Yfit = predict(mdl.Trainable{10,1}.Trained{100},predict_data);
%Yfit = predict(mdl.Trainable{20,1}.Trained{200},predict_data);

%% Manual error rate
correct = 0;
Results = zeros(9002,2);
for i = 1:9002
    if Yfit(i) == Answer_Label(i,1)
        correct = correct +1;
        Results(i,1) = Yfit(i);
        Results(i,2) = Answer_Label(i,1);
    end
end
percentage = (correct/9002)* 100;
%% 
%days = size(array_incident,2);

%training_data = zeros(training_size,vuln_size);
%training_labels = zeros(training_size,vuln_size);

%%
for i = 1: training_size
   temp = toArray(array_breach(i,j),vuln_size); 
   temp2 =  vertcat(training_labels(i,:),temp);
end
%%
training_data = create_training_data ();
%%
temp = e_thresholds2{1,1};

temm = []; 
for i = 1: num_control
    temp2 = cell2mat(temp(i,1));
    temm = [ temm temp2];
end
%%
A = [0,2,4,6,8; ...
    1,3,5,7,9; ...
    8,6,4,2,0; ...
    9,7,5,3,1; ...
    3,1,7,9,5; ...
    2,0,8,6,4; ...
    8,6,4,0,2; ...
    1,1,3,3,5; ...
    2,2,4,4,6;...
    8,8,6,4,0];

B = [1,0; 0,1; 1,0; 0,1; 0,1; 1,0; 1,0; 0,1; 1,0; 1,0];
%%
% This replaces the original e_thresholds by defining the controls
% independent of the vulnerabilities. This is because the previous
% e_thresholds did not reuse any controls because they were all random.
%{
for i = 1: num_control
        r = randi([5 25],1, 1);
        e_thresholds3{i,1}= e_min + (e_max-e_min)*rand(1,r);
end
%}
%%
%incident_threshold = [.05, .1, .15, .01, .02, .11, .03 ];
%incident_threshold = [.20, .4, .50, .30, .24, .11, .35 ];
%incident_threshold = [.50, .6, .50, .45, .74, .65, .55 ];
%incident_threshold = [.5, .5, .5, .5, .5, .5, .5 ];
%incident_threshold = [.9, .9, .9, .9, .9, .9, .9 ];
%%
%{
mc_count_day = cell(1,days);
for i = 1: days
    %mc_count_day{1,i} = mc_count(i:temp:end,:);
    mc_count_day{1,i} = mc_count(i:a_size:end,:);
end
%}
%%
%%
%test = cell(5,3);
%%
%{
test = cell(6,3);

for i = 1:6
    for j = 1:3
        r = randi([1 15],1,1);
        test{i,j} = rand(1,r);
    end
end
%%
test2 = cell(1,3);
for i = 1:6
    for j = 1:3
        test2{1,j} = cell2mat([test2(1,j) test(i,j)]);
    end
end
%}
%%
% calculate for each day
mc_size = size(mc_baseline{1,1},1);
vuln_1scores2 = cell(mc_size,1);
for i = 1: actions_size
    for j = 1: mc_size
        if ~isequal(vuln_1{1,1}{1,i}(1,1),0)
             vuln_1scores2{j,1} = cell2mat(vuln_1{1,1}{1,i}(1,1));
        end
    end
end

%%

%If A is 8760-by-1, and you want to find the sum of every 24 elements, 
% such that you will end up with 365 sums, then do:
%sum(reshape(A,24,365))
%%
%% Testing
a_size2 = 10;%agent size
days2 = 5;%days
mc2 = cell(1,days2);
for i = 1:days2
    for j = 1:a_size2
        steps = randi([5 10],1,1);
        for k = 1: steps
            mc2{j,i}{k,1} = randi([1 5],1,1); 
        end
    end
end
%%
vm2 = cell(a_size2,days2);
step_size = 5;
for i = 1:days2
    for j = 1:a_size2
        for k = 1: step_size 
            vm2{j,i}{k,1} = rand; 
        end
    end
end
%%

vuln_incident_total = cell(a_size2,days2);
vuln_2 = [];

%This is only comparing to the environment controls for vulnerability 1
vuln_agent_average(1,1) =.80;
vuln_idx =1;
%vuln1_scores = cell(a_size,days);

    for i = 1:a_size2
        for j = 1: days2
             [vuln_2{i,j}, ~] = determine_state_vuln5(vuln_agent_average(1,1), mc2{i,j},a_size2,vm2{1,j},vuln_idx);
        end
    end
%%
    for i = 1:a_size2 
        for j = 1:days2
                %vuln_incident_total{i,j} = calculate_total2(vuln_1{i,j},mc_baseline{i,j}, actions_size);
                vuln_incident_total{i,j} = calculate_total2(vuln_2{i,j},mc2{i,j}, a_size2);
        end
    end
    %%
  %% Testing
%{
for i = 1: a_size
    temp_max(i,:) = mc_count_day{1,1}(i,:).* control_size_per_state;
end
day_max = sum(temp_max);
%}
%{
control_max = cell(1, days);
for i = 1: days
    control_max{1,i} = calculate_daily_control_max(mc_count_day{1,i},control_size_per_state, a_size);
end
%}
  %%
  A = [...
1	1	1	1	1	1	1	1	1	1	1	1	1	0;
1	0	1	1	1	1	1	0	0	1	0	1	0	0;
1	0	1	1	1	1	1	1	1	1	1	1	1	0;
1	1	1	1	1	1	1	1	1	1	0	1	0	0;
1	0	1	1	1	1	1	1	0	1	1	1	0	0;
1	1	1	1	1	1	1	1	0	1	0	1	1	0;
1	0	1	1	1	1	1	1	1	1	1	1	1	0;
1	1	1	1	1	1	1	0	0	1	0	1	1	0;
1	0	1	1	1	1	1	1	1	1	1	1	0	0;
1	1	1	1	1	1	1	1	1	1	0	1	1	0;
0	1	0	0	0	0	0	1	1	0	1	1	1	1;
1	1	0	0	1	1	0	1	1	0	1	0	1	1;
0	1	0	0	1	0	1	1	1	1	0	1	1	1;
1	1	0	0	0	0	1	1	0	1	0	0	1	1;
1	0	0	0	1	1	1	0	1	1	1	1	1	1;
0	1	0	0	1	1	1	1	0	0	1	0	1	1;
1	1	0	0	1	1	1	1	1	0	1	1	0	1;
1	1	0	0	1	1	0	0	0	1	1	0	1	1;
1	0	0	0	1	1	1	1	1	1	0	0	1	1;
1	1	0	0	0	0	0	1	1	0	1	1	0	1;
];
  %%
  %% 
% This sorts through the mc_baseline to determine the total possible of
% incidents per person, per day per state.

% create determine_state_total()

%%
%{
 vuln_merge2 = cell(1, vuln_size);
 % calculates the number of control families relative to action step
vps = vuln_per_step{1,1};
%vm = vuln_merge{1,1};
%temp_size = size(vm,1);
temp_size = size(vps,1);

 %temp_size = size(vuln_combo{1,vuln_idx}(1,:),2);
 for i = 1: temp_size
    for j = 1: vuln_size
        %temp2 = cell2mat(vuln_merge(1,j));
        vuln_merge2{1,j} = cell2mat([vuln_merge2(1,j) vps(i,j)]);
    end
 end
 %%

vuln_final = cell(actions_size,1);
for i = 1:actions_size
    vuln_final{i,1} = calculate_vuln_final(vuln_merge{i,1});
end
%}
%%
%% mc_count_day ; control combo vuln control count 3: determine max control
% This section takes the control_size_per_state (which represents the number
% of controls per state) and then multiplies it against the number of
% instances that state appeared in that day. For example, if there are 10
% controls associated with state 1, and an agent was at state 1 five times,
% then there were a total of 50 (five * ten) opportunities for an agent to
% committ an incident.
%
% 
%{
control_max = cell(a_size, days);
for i = 1: days
    for j = 1:a_size
        control_max{i,j} = calculate_daily_control_max(mc_count_day{1,i},control_size_per_state, a_size);
    end
end
%}


%{
control_max = cell(1, days); %This one works
for i = 1: days
    control_max{1,i} = calculate_daily_control_max(mc_count_day{1,i},control_size_per_state, a_size);
end
%}

%control_max = zeros(a_size, days);
%{
for i = 1: a_size 
    for j = 1:days
        %mc_count_day(i,:).* control_size_per_state;
        control_max{i,j} = mc_count_day{1,j}(i,:).* control_size_per_state;
    end
end
%}
%%
%{
control_percentages = zeros(days,actions_size);
for i = 1:days
    %temp = toArray(vuln_incident_total{1,1}(i,:),5);
    control_percentages(i,:) = vuln_incident_total{1,i}./control_max{1,i};
end
%}
%% This calculates the incident
% This takes the average of each row and compare it to a score.

%{
ctrl_percent_avg = mean(control_percentages,2);
vuln1_output4 = zeros(days,1);

for i = 1: days
    if ctrl_percent_avg(i,1) > .70
        vuln1_output4(i,1) = 1;
    end
end
%}
%%
%% compare the agent score with each score to get a 1 or 0.
%{
ctrl_percent_avg2 = mean(control_percentages,2);
vuln1_output5 = zeros(days,1);

for i = 1: days
    if ctrl_percent_avg2(i,1) > .70
        vuln1_output5(i,1) = 1;
    end
end
%}
%%
%% Check if all attibution selection = 1
%{
for i = 1:days
   % if all((i,:)==1)
        vuln1_output6(i,1) = 1;
   % end
end
%}
%%
%% Training data information for state 1.

%training_data = create_training_data(e_thresholds2, a_size, vuln_size, days,1);
%% Training labels for state 1
%training_labels = create_training_label(array_breach,days,1);

%%
% summarize all thresholds for each; Use this to fix vuln_merge/matrix/sorted. Currently incorrect 
%size(e_thresholds2{1,1}{1,1},2);
%{
vuln1_size = sum(control_size(:,1)); % This represents the total number of columns 
vuln1_input = zeros(days,vuln1_size);


for i = 1:days
        vuln1_input(i,:) = [cell2mat(e_thresholds_daily ...
            {1,i}(1,1)) cell2mat(e_thresholds_daily{1,i}(2,1)) ...
            cell2mat(e_thresholds_daily{1,i}(3,1)) cell2mat(e_thresholds_daily{1,i}(4,1)) ...
            cell2mat(e_thresholds_daily{1,i}(5,1)) cell2mat(e_thresholds_daily{1,i}(6,1));];
end
%}
%% This takes the breaches as output to be used as labels
%{
vuln1_output = cell(1, days);

for i = 1:days
    vuln1_output{1,i} = vuln_breach{1,i};  
end
%}
%% This inverts the output to meet the criteria to match input number
%vuln1_output = vuln1_output';
%%
%{
vuln1_output2 = zeros(days,actions_size);
for i = 1: days
    vuln1_output2(i,:) = toArray(vuln1_output(i,1),actions_size);
end
%}
%%
%vuln1_output3 = vuln1_output2(:,1);
%% Calculate the number of controls applicable for each state
% This step calculates the number of controls associated with each step.
% The vuln_matrix highlights the total amount of controls for each step.
% The control_size_per_state takes the size of each step within the vuln
% matrix. For example, if there are 10 controls for step 1 in the vuln
% matrix, then that means there are 10 opportunities for an agent to
% committ an incident at that state. 
%{
control_size_per_state = zeros(1,actions_size);

for i = 1: actions_size
    control_size_per_state(1,i) = size(cell2mat(vuln_matrix{1,1}{i,1}(1,1)),2);
end
%}
%%
% double checked the e_threshold daily. It aligns with vuln1_input next
% step is to double check the total incident count. Test with one row of
% vuln1_input.

% If all incident(i,attribute_index(j) == 1, then there is an incident. 
% Reverse engineer it?????? Find the ones and then train that?
%% Testing
% Attribute size represents the number attributes for a vulnerability
%{
attribute_size = size(vuln1_input,2); 

% The attribute number represents the number of controls that represent the
% controls that impact the incident 
attribute_num = round(.15 * attribute_size);

% This outlines the index
attribute_index = randi([1 attribute_size],1, attribute_num);

% This selects the specific controls based on the index
attribute_selection = zeros(1, attribute_num);

for i = 1: days
    for j = 1:attribute_num
        attribute_selection(i,j) = vuln1_input(i,attribute_index(j));
    end
end

%}

%% Initial test values
%sample_controls = zeros(1,13);
%sample_incident_score = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92,.75,.85];
%sample_no_incident_score = [.92,1,1,.94,1,1,1,.75,1,1,1,.85,1];

%% Secondary test values
%{
sample_incident_score = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92,.75,.85 ...
   .62, .84, .92, .68,.72,.63,.72,.92, .93,.82,.65,.82 ];
sample_no_incident_score = [.92,1,1,.94,1,1,1,.75,1,1,1,.85,1 ...
    .82, .64, .62, .88,.76,.68,.88,.82, .83,.72,.85,.72 ];
%}
%%
%i_scores = zeros(days/2,i_size);

% This demonstrates daily change for the controls that represent an
% incident. For this test, 50% of the data results in an incident.
% Therefore P goes from 1 to days/2.
%{
for P = 1: days %days/2
    for Q = 1: i_size
        min = sample_incident_score(1,Q)-(.05*sample_incident_score(1,Q));
        max = sample_incident_score(1,Q)+(.05*sample_incident_score(1,Q));
        i_scores(P,Q)= min + (max-min)*rand(1,1);
    end
end
%}

%{
for P = 1: days %days/2
    for Q = 1: i_size
        min = sample_incident_score(1,Q)-(.05*sample_incident_score(1,Q));
        max = sample_incident_score(1,Q)+(.05*sample_incident_score(1,Q));
        i_scores(P,Q)= min + (max-min)*rand(1,1);
    end
end
%}
% This adds a column to represent the label of an "incident"
%temp = ones(days/2,1);
%i_scores = [ i_scores,temp];
%%
%% calculate incident
%{
%vuln1_output6 = zeros(days,1);
%agent_average = .6;
incident = zeros(days,attribute_num);
for i = 1:days
    for j = 1:attribute_num
        if agent_average > i_scores(i,j)
            incident(i,j) =1;
        end
    end
end
%}

%%
%%
%attribute_mean = mean(incident,1);
%{
no_i_size = size(sample_no_incident_score,2);
no_i_scores = zeros(days/2,vuln_size);

% This demonstrates daily change for controls that do not represent an
% incident
for P = 1: days/2
    for Q = 1: i_size
        min = sample_no_incident_score(1,Q)-(.05*sample_no_incident_score(1,Q));
        max = sample_no_incident_score(1,Q)+(.05*sample_no_incident_score(1,Q));
        no_i_scores(P,Q)= min + (max-min)*rand(1,1);
    end
end

% This adds a column to represent the label of "no incident"
temp = zeros(days/2,1);
no_i_scores = [ no_i_scores,temp];
%}
%%
% This combines the scores for the two groups
%temp = [ i_scores; no_i_scores];

% This shuffles the rows
%combined_test_score = temp(randperm(size(temp, 1)), :);
%% This has the agent compare to each score
% For each control/element, if the agent score is greater than the
% control's compliance score, then there is an incident.
%{
incident_test = zeros(days,i_size);
for i = 1: days
    for j = 1:i_size
        if agent_average > combined_test_score(i,j)
            incident_test(i,j) = 1;
        end
    end
end
%}
%%
% This merges the results from the incidents with the labels
%input_output2 = [incident_test combined_test_score(:,i_size+1)];
%%
% This saves the labels for reference and removes them from the data
%label_final(:,1) = combined_test_score(:,i_size+1);
%combined_test_score(:,i_size+1) = [];
%%
% This removes the labels.
%input_output2(:,i_size+1) = [];
%%
%% Scenario "Less Steps"
% This scenario calculates the outcome when the steps are cut in half
%{
for i = 1: a_size
    for j = 1:days
        temp = steps(i,j)/2;
        mc_baseline{i,j}(temp,:) = [];
    end
end
%}

%% Training labels for state 1
%training_labels = create_training_label(array_breach,days,1);

%% Training data information for state 2.

%training_data2 = create_training_data(e_thresholds2, a_size, vuln_size, days,2);
%% Training labels for state 1
%training_labels2 = create_training_label(array_breach,days,2);
%%
%% Calculates the a_incident score.
% For each agent, their threat score (as defined within People) are
% compared to sets of RMF control threshold scores relevant to the threat
% score. For example, phishing threat scores are related to controls where
% a noncompliance in an RMF control would yield a vulnerability to phishing

%a_size = size(people,1);
%a_incidents = cell(a_size,a_vuln_size);
%if people{1,3}(1,j) > e_thresholds{j,1}(1,k)
%{
    for j = 1:e_size % number of incident type
        a_incidents{1,j} = zeros(1,control_size(j));% preallocate
        for k = 1: control_size(j) % number of selective controls
            if people(1,j) > e_thresholds_daily{j,1}(1,k)
                a_incidents{1,j}(j,k) = 1;
            end
        end
    end
%}
%%
%% Internet Browsing attribute controls:
 
 %all_attributes 
 %internet_email:  
 %internet_attributes

%% Checking Email attribute controls:
 %all_attributes 
 %internet_email
 %email_attributes

 %% Cell Phone:
 %all_attributes
 %mobile_attributes

%% Landline:
%all_attributes
%Internet_email_landline_attributes
%attribute_selection{1,1} = [.7,.6,.90,.88,.85,.65,.63,.92,.90,.85,.92,.75,.85 ...
%   .62, .84, .92, .68,.72,.63,.72,.92, .93,.82,.65,.82];

attribute_selection{1,1} = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92, ...
    .75,.85,.62, ... % internet_email controls
    .84, ]; % internent control

attribute_selection{2,1} = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92 ...
     .75,.85,.62, ... % internet_email controls
     .90]; % email control

attribute_selection{3,1} = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92];

attribute_selection{4,1} = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92];

%{
all_attributes = [.7,.6,.58,.53,.85,.65,.63,.62,.60,.65,.62];
internet_email_attributes = [.55,.52,.52];
internet_attributes = .54;
email_attributes = .60;
mobile_attributes = [.68, .66];
internet_email_landline_attributes = [.61, .62];

% Combine controls to complete the attribute selection

% Internet Browsing 15 controls
attribute_selection{1,1} = [all_attributes,internet_email_attributes,internet_attributes];
% Email 17 controls
attribute_selection{2,1} = [all_attributes,internet_email_attributes,email_attributes];
% Mobile Phone 13 controls
attribute_selection{3,1} = [all_attributes, mobile_attributes];
% Landline Phone 13 controls
attribute_selection{4,1} = [all_attributes, internet_email_landline_attributes];
%}



attribute_selection{1,1} = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92,.75,.85 ...
   .62, .84, .92, .68,.72,.63,.72,.92, .93,.82,.65,.82];

%attribute_selection{1,1} = [.7,.6,.90,.88,.85,.65,.63,.92,.90,.85,.92,.75,.85 ...
%   .62, .84, .92, .68,.72,.63,.72,.92, .93,.82,.65,.82];
attribute_selection{2,1} = [.82, .78,.65, .98, .74 ];

attribute_selection{3,1} = [.78, .85, .93, .91, .85 ];

attribute_selection{4,1} = [.95, .92, .95, .88, .92, .90, .95, .90, .90];

%%

[click_percent_step2,click_percent_step_mean2] = scenario_people(15,attribute_selection, e_thresholds_daily);
%%
%save("test_function_v3.m","attribut_selection");
%%
 attribute_selection{1,1} = [0.4022	0.8859	0.4491	0.2794	0.8515	0.1927	0.4408	0.3012	0.4337	0.6506	0.1113	0.9116	0.5382	0.7268	0.9319];
 attribute_selection{2,1} = [0.2627	0.9236	0.2256	0.8874	0.9704	0.6219	0.0594	0.8320	0.9027	0.2413	0.2485	0.9522	0.9133	0.9590	0.6195	0.5221	0.9292];
 attribute_selection{3,1} = [0.8301	0.5968	0.4735	0.3535	0.8294	0.6103	0.9183	0.4613	0.9714	0.6175	0.1196	0.3128	0.0605];
 attribute_selection{4,1} = [0.6030	0.4088	0.4658	0.1182	0.2916	0.8152	0.9256	0.4979	0.7753	0.9819	0.3310	0.2591	0.0423];
 %%
 %incident opportunity is calculated incorrectly.
%mc_count per agent instead of day

mc_count_agent = cell(a_size,1);
for i = 1: a_size
    for j = 1: days
        mc_count_agent(i,1) = mc_count_agent(i,1) + toArray(mc_count(i,j),actions_size);
    end
end
%%
mc_count_agent = zeros(1,actions_size);
for i = 1: days
    mc_count_agent = mc_count_agent + cell2mat(mc_count(1,i));
end

 %%
 mc_count_agent = cell(a_size,1);
for i = 1: a_size
    mc_count_agent{i,1} = determine_mc_count_agent(mc_count, days, actions_size,i);
end

% fix by_agent (numerator)
%%
agent_breach = cell(a_size,1);
for i = 1: a_size
    agent_breach{i,1} = determine_mc_count_agent(vuln_breach_total, days, actions_size,i);
end
%%
click_percent_step = cell2mat(agent_breach)./incident_opportunity;
%%
for i = 1:size(agent_email{1,1}(1,:),2)
    if agent_email{1,1}(1,i) == 1
       checked_email = checked_email +1;
        temp = rand(1,1);
            if temp < .70 % 70% chance of reporting phishing
                 report_email = report_email +1;
            end
    end
end
%%

%% Individual agents
%This is only comparing to the environment controls for  vulnerability 1
%% Target Phishing (Whaling}
% 19% success rate [ Phishing Repo]

% This determines the amount of email each agent receives
a_size = 10;
email_population = randi([20 120],a_size,1);
phish_population = randi([4,7],a_size,1);
% This creates the email
agent_email = cell(a_size,1);

for i = 1:a_size
    agent_email{i,1} = zeros(1,email_population(i));
end
%% Select the phishing email
phish_selected = cell(a_size,1);
for i = 1: a_size
    phish_selected{i,1} = randi([20 email_population(i,1)],1,phish_population(i,1));
end
%% Assignd the email as phishing

for i = 1:a_size
    for j = 1:phish_population(i,1)
        agent_email{i,1}(1,phish_selected{i,1}(1,j)) = 1;
    end
end
%% Have the agents identify and report phishing emails
% Only check if attribute{i,1}(1,1) or attribute{i,1}(1,2). This simulates
% the ability for an agent to identify and report a phishing email based on
% their knowledge set. Higher score increases the likelihood of the agent
% reporting the email.

% agent identify phishing email
% How to calculate which emails to check
% Remove phishing email to see any improvement
% Impact of training
%%
%[agent_email,phish_selected] = agent_interaction_create_email(a_size);
%[agent_email,phish_selected] = agent_interaction_create_email(10);

%%
% Change agent_email{1,1}(1,i) == 1 to check for invidual {j,1}(1,i)
% reset email_index at the test_function level to restart each day
% check for all 
%%
%{
[agent_email,phish_selected] = agent_interaction_create_email(a_size);
control_size = vuln_incident_total{1,1}(1,1);
%email_number = 5; %randi([1 5],1,1); % selects the number of emails
report_email = zeros(1,actions_size);
checked_email = zeros(1,actions_size);
%email_index = 1;

for i = 1: actions_size
    email_index = 1;
    for j = 1: vuln_incident_total{1,1}(1,i)
        email_number = randi([1 5],1,1); % selects the number of emails
            if email_index + email_number < size(agent_email(1,:),2)%size(agent_email{1,1}(1,:),2)
                for k = email_index: email_index +email_number
                    if agent_email(1,k) == 1%agent_email{1,1}(1,k) == 1
                        checked_email(1,i) = checked_email(1,i) +1;
                        temp = rand(1,1);
                            if temp < .70 % 70% chance of reporting phishing
                                report_email(1,i) = report_email(1,i) +1;
                            end
                    end
                    %email_index = email_index +email_number;
                end
                email_index = email_index +email_number;
            end
    end
end
%}  

%%

% This is the plot information for click rates click_rate_data
 click_rate_scatter = [73, .1; 72, 1.5; 70, 2.8; 68, 4.1; 66, 5.5; 64, 6.7; 62, 7.9; 60, 9.1; 58,  10.4; 56, 11.4; 54, 12.2; 52, 13.3];

%%
%A = rand(10,2);
scatter_graph = scatter(click_rate_scatter(:,1), click_rate_scatter(:,2));

%scatter_graph = scatter(click_rate_data(:,1), click_rate_data(:,2));
title("Click Rate per Compliance ")
xlabel('Compliance')
ylabel('Click Rate')
set(gcf, 'Name', 'Click Rate per Compliance')

%%
%incident_threshold = .7;
%test{1,1} = determine_breach3(vuln_1{1,1}, incident_threshold, steps(1,1),attribute_size,likelihood);

%%
attribute_size = zeros(1,actions_size);
for i = 1: actions_size
   attribute_size(i,1) = size(attribute_selection{i,1},2);
end
%%
attribute_average = zeros(1,365);

for i = 1: 365
    attribute_average(1,i) = mean(cell2mat((e_thresholds_daily{1,i}(1,1))));
end
%%
%%
%[checked_email, report_email] = calculate_email_report(vuln_incident_total{1,1}, agent_email, actions_size);

%%
%{
checked_email_total = cell(1,actions_size);
for i = 1: a_size
    for j = 1: days
        checked_email_total = cell2mat(checked_email_total) + checked_email{i,j};
    end
end
%}

%%
%{
for i = 1: a_size
    for j = 1: days
        [agent_email,phish_selected] = agent_interaction_create_email(a_size);
        agent_email_total{1,j} = agent_email;
    end
end
%}
%%
%{
attribute_selection{1,1} = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92,.75,.85 ...
   .62, .84, .92, .68,.72,.63,.72,.92, .93,.82,.65,.82];

%attribute_selection{1,1} = [.7,.6,.90,.88,.85,.65,.63,.92,.90,.85,.92,.75,.85 ...
%   .62, .84, .92, .68,.72,.63,.72,.92, .93,.82,.65,.82];
attribute_selection{2,1} = [.82, .78,.65, .98, .74 ];

attribute_selection{3,1} = [.78, .85, .93, .91, .85 ];

attribute_selection{4,1} = [.95, .92, .95, .88, .92, .90, .95, .90, .90];
%}
%%
%{
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];
agent_click(1,:) = [.5, 2.4, 1.32, 3.9];%60
agent_click(2,:) = [.52, 2.1, 1.2, 3.5];%65
agent_click(3,:) = [.45, 1.89, 1.0, 3.0];%70
agent_click(4,:) = [.38, 1.59, .86, 2.56];%75
agent_click(5,:) = [.26, 1.1, .60, 1.75];%80
agent_click(6,:) = [.17, .72, .4, 1.2];%85
agent_click(7,:) = [0,   .4,  .13, .6];%90
agent_click(8,:) = [.0,  .13,  0, .21];%95
%}
%%
%% Scatterplot of percentages


click_size = size(agent_click,2);

for i = 1: click_size
    scatter(agent_comp',agent_click(:,i));
    hold on
end
title("Agent Click Rate  (" + actions_size + " steps)")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Web-Surfing','Mobile Phone','Checking Email')
hold off

%%
%[click_percent_step_mean,report_rate] = create_suborganization(start,stop, agent_compliance_average, attribute_selection, incident_threshold);
%{
email_population = randi([20 120],a_size,1);
phish_population = randi([4,7],a_size,1);
% This creates the email
agent_email = cell(a_size,1);

for i = 1:a_size
    agent_email{i,1} = zeros(1,email_population(i));
end
%% Select the phishing email
phish_selected = cell(a_size,1);
for i = 1: a_size
    phish_selected{i,1} = randi([20 email_population(i,1)],1,phish_population(i,1));
end
%% Assignd the email as phishing

for i = 1:a_size
    for j = 1:phish_population(i,1)
        agent_email{i,1}(1,phish_selected{i,1}(1,j)) = 1;
    end
end
%}
%{
agent_email = cell(a_size,1);

for i = 1:a_size
    agent_email{i,1} = zeros(1,email_population(i));
end
%}
%{
phish_selected = cell(a_size,1);
for i = 1: a_size
    phish_selected{i,1} = randi([20 email_population(i,1)],1,phish_population(i,1));
end
%}
%%
%{
agent_email_total = cell(1,days);
for i = 1: a_size
    for j = 1: days
        [agent_email,~] = agent_interaction_create_email();
        agent_email_total{1,j} = agent_email;
        [checked_email{i,j}, report_email{i,j}] = calculate_email_report(vuln_incident_total{i,j},agent_email, actions_size);
        %[checked_email{i,j}, report_email{i,j}] = calculate_email_report(vuln_incident_total(i,j),agent_email, actions_size);
        %[checked_email{i,j}, report_email{i,j}] = calculate_email_report(vuln_incident_total,agent_email, actions_size);
    end
end
%}
%% This step separates the report rate from create_suborganization


%checked_email = cell(click_size, org_size);
%report_email = cell(click_size,org_size);
%agent_email = cell(click_size,days);
agent_email_total = cell(1,org_size);


%[checked_email,report_email] = create_org_email(v_total{1,1},a_size, actions_size);

%{
for i = 1: click_size
    for j = 1:org_size
        %[checked_email{i,j},report_email{i,j}, ~] = create_org_email(v_total{i,j},a_size, actions_size);
        [checked_email{i,j},report_email{i,j}, agent_email_total{i,j}] = create_org_email(v_total{i,j},a_size, actions_size);
        %[checked_email{i,j},report_email{i,j}] = create_org_email(v_total,a_size, actions_size);
    end
end

%}
%%
%[checked_email{1,1},report_email{1,1}, agent_email_total{1,1}] = create_org_email(v_total{1,1},a_size_total(1,1), actions_size);
%%
%start = 1;
%stop = 10;
actions_size = 4;
a_size = 10;
days = 50;
agent_compliance_average = [.6,.65,.7, .75, .8, .85, .9, .95];

attribute_selection {1,1} = [.7467, .3624, .1073, .7538, .5053];
attribute_selection {2,1} = [0.9135,0.4975,0.0330,0.2703,0.6587,0.3627,0.3998];
attribute_selection {3,1} = [0.3830,0.2413,0.9665];
attribute_selection {4,1} = [0.2197,0.8792,0.3815];

%{
attribute_selection{1,1} = rand(1,5);
attribute_selection{2,1} = rand(1,7);
attribute_selection{3,1} = rand(1,6);
attribute_selection{4,1} = rand(1,5);
%}
incident_threshold = .043;

%%
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];
%% Create Suborganizations 
%Creates a loop where a suborganization is created and compairsons are made
%for each compliance level between 60 to 95 with increments of five. 
click_size = 8;
org_size = 4;

agent_click = cell(click_size,org_size);
total_report_rate = cell(click_size,org_size);
v_total = cell(click_size,org_size);
a_size_total = [2,4,6,4,2];

for i = 1: click_size
    for j = 1:org_size
        [click_percent_step_mean,report_rate, vuln_incident_total] = create_suborganization(a_size_total(1,j), days, agent_compliance_average(1,i), attribute_selection, incident_threshold);
        agent_click{i,j} = click_percent_step_mean;
        total_report_rate{i,j} = report_rate;
        v_total{i,j} = vuln_incident_total;
    end
end
%{
for i = 1: click_size
    [click_percent_step_mean,report_rate, vuln_incident_total] = create_suborganization(start,stop, agent_compliance_average(1,i), attribute_selection, incident_threshold);
    agent_click{i,:} = click_percent_step_mean;
    total_report_rate{i,:} = report_rate;
    v_total{i,:} = vuln_incident_total;
end
%}

%% Create Reported email
% This changes existing phishing email to reported
% This represents the second team receiving a reported email.
c_email = cell(a_size_total(1,1), days);
r_email = cell(a_size_total(1,1),days);
a_email_total = cell(a_size_total(1,1),days);

% need to check the value for 1. If it's a 1, 50/50 that it is reported. If
% it is reported, then don't check.
%agent_email_total{m,n}(1,:);
%size(agent_email_total{m,1}{m,1}(n,:),2);
resolved_email = 0;
for m = 1: a_size_total(1,1)
    for n = 1: days
        
        for o = 1: size(agent_email_total{1,1}{m,n}(1,:),2)
            if agent_email_total{1,1}{m,n}(1,o) == 1
                temp = rand;
                    if temp < .70
                        agent_email_total{1,1}{m,n}(1,o) = 0;
                        resolved_email = resolved_email+1;
                    end
            end
            agent_email = agent_email_total{1,1}{m,n}(1,:);
        end
        [c_email{m,n}, r_email{m,n}] = calculate_email_report(v_total{1,1}{m,n},agent_email, actions_size);
    end    
end

%% Determining the new checked emails after emails have been reported

c_email_new = zeros(a_size_total(1,1),actions_size);
%c_email_report = zeros(1,actions_size);
for i = 1: a_size_total(1,1)
    for j = 1: days
        %c_email_report = c_email_report + cell2mat(c_email(1,j));
        c_email_new(i,:) = c_email_new(i,:) + cell2mat(c_email(i,j));
    end
end
%% Determining the sum of original checked email
c_email_old = zeros(a_size_total(1,1),actions_size);
for i = 1: a_size_total(1,1)
    for j = 1: days
        c_email_old(i,:) = c_email_old(i,:) + cell2mat(checked_email{1,1}(i,j));
    end
end
%%
c_email_reduction = (c_email_old - c_email_new)./c_email_old;
%%
%% Initial test values
sample_controls = zeros(1,13);
%sample_incident_score = [.7,.6,.58,.53,.85,.65,.63,.92,.90,.85,.92,.75,.85];
%sample_no_incident_score = [.92,1,1,.94,1,1,1,.75,1,1,1,.85,1];

%% Secondary test values

sample_incident_score = ...
    [.7,.6,.58,.53,.85,...
    .65,.63,.92,.90,.85, ...
    .92,.75,.85,.62,.84, ... 
    .92, .68,.72,.63,.72,...
    .92, .93,.82,.65,.82 ];

sample_no_incident_score = ... 
    [.92, 1, 1, .94, 1, ... 
      1, 1, .75, 1, 1, ... 
      1,.85, 1, .82, .64, ...
     .62, .88, .76,.68,.88, ...
    .82, .83, .72,.85,.72 ];

%% Using same test values from scenario 1b
 %sample_incident_score = [0.4022	0.8859	0.4491	0.2794	0.8515	0.1927	0.4408	0.3012	0.4337	0.6506	0.1113	0.9116	0.5382	0.7268	0.9319];
 %sample_no_incident_score = [0.4022	0.8859	0.4491	0.7794	0.8515	0.7927	0.4408	0.3012	0.4337	0.6506	0.7113	0.9116	0.5382	0.7268	0.9319];

%% Defined Variables

vuln_size = 1;
days = 200;
agent_average = .7;
%%
i_size = size(sample_incident_score,2);
i_scores = zeros(days/2,vuln_size);
%i_scores = zeros(days/2,vuln_size);
%i_scores = zeros(days/2,i_size); [delete this one]

% This demonstrates daily change for the controls that represent an
% incident. For this test, 50% of the data results in an incident.
% Therefore P goes from 1 to days/2.
%{
for P = 1: days/2 %days/2
    for Q = 1: i_size
        min = sample_incident_score(1,Q)-(.05*sample_incident_score(1,Q));
        max = sample_incident_score(1,Q)+(.05*sample_incident_score(1,Q));
        i_scores(P,Q)= min + (max-min)*rand(1,1);
    end
end
%}


for P = 1: days/2 %days/2
    for Q = 1: i_size
        min = sample_incident_score(1,Q)-(.25*sample_incident_score(1,Q));
        max = sample_incident_score(1,Q)+(.25*sample_incident_score(1,Q));
        i_scores(P,Q)= min + (max-min)*rand(1,1);
    end
end

% This adds a column to represent the label of an "incident"
temp = ones(days/2,1);%[ original]
%temp = ones(days,1);
i_scores = [ i_scores,temp];
%%

% The attribute number represents the number of controls that represent the
% controls that impact the incident 
%attribute_num = round(.15 * attribute_size);
%attribute_num = round(.15 * i_size);
%% calculate incident
%{
%vuln1_output6 = zeros(days,1);
%agent_average = .6;
incident = zeros(days,attribute_num);
for i = 1:days
    for j = 1:attribute_num
        if agent_average > i_scores(i,j)
            incident(i,j) =1;
        end
    end
end
%}

%%
%%
%attribute_mean = mean(incident,1);

no_i_size = size(sample_no_incident_score,2);
no_i_scores = zeros(days/2,vuln_size);

% This demonstrates daily change for controls that do not represent an
% incident
for P = 1: days/2
    for Q = 1: i_size
        min = sample_no_incident_score(1,Q)-(.25*sample_no_incident_score(1,Q));
        max = sample_no_incident_score(1,Q)+(.25*sample_no_incident_score(1,Q));
        no_i_scores(P,Q)= min + (max-min)*rand(1,1);
    end
end

% This adds a column to represent the label of "no incident"
temp = zeros(days/2,1);
no_i_scores = [ no_i_scores,temp];

%%
% This combines the scores for the two groups
temp = [ i_scores; no_i_scores];

% This shuffles the rows
combined_test_score = temp(randperm(size(temp, 1)), :);
%% This has the agent compare to each score
% For each control/element, if the agent score is greater than the
% control's compliance score, then there is an incident.

incident_test = zeros(days,i_size);
for i = 1: days
    for j = 1:i_size
        if agent_average > combined_test_score(i,j)
            incident_test(i,j) = 1;
        end
    end
end

%%
% This merges the results from the incidents with the labels
input_output2 = [incident_test combined_test_score(:,i_size+1)];
%%
% This saves the labels for reference and removes them from the data
label_final(:,1) = combined_test_score(:,i_size+1);
combined_test_score(:,i_size+1) = [];
%%
% This removes the labels.
input_output2(:,i_size+1) = [];
%%
%% This does 20 iterations for one agent compliance
%{
for i = 1:20
[click_percent_step_mean{i,1},report_rate{i,1}, vuln_incident_total] = ...
    create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate);
end
%}
%%
%% This stacks all the 
%{
agent_click = [];

for i = 1: agent_compliance_size
   temp = cell2mat(click_percent_step_mean(1,i));
   agent_click = [agent_click;temp];
end
%}
%%
%% Demonstrates multiple runs
percent_60 = [  0.0327 0.0227 0.0328 0.0201; 
 0.0329 0.0222 0.0320 0.0216;
 0.0330 0.0221 0.0331 0.0227;
 0.0332 0.0221 0.0319 0.0220;
 0.0323 0.0212 0.0331 0.0235;
 0.0326 0.0229 0.0330 0.0219;
 0.0329 0.0231 0.0327 0.0213;
 0.0323 0.0220 0.0327 0.0218;
 0.0332 0.0222 0.0329 0.0220;
 0.0325 0.0223 0.0324 0.0248];

percent_65 = [0.0291 0.0203 0.0293 0.0116;
 0.0292 0.0195 0.0288 0.0113;
 0.0294 0.0195 0.0291 0.0136;
 0.0293 0.0209 0.0298 0.0114;
 0.0286 0.0200 0.0297 0.0107;
 0.0291 0.0197 0.0293 0.0119;
 0.0292 0.0200 0.0298 0.0117;
 0.0294 0.0199 0.0294 0.0114;
 0.0288 0.0198 0.0295 0.0112;
 0.0286 0.0197 0.0293 0.0112];

percent_70 = [ 0.0258 0.0177 0.0245 0.0046;
 0.0260 0.0185 0.0247 0.0050;
 0.0257 0.0169 0.0237 0.0048;
 0.0263 0.0170 0.0247 0.0051;
 0.0265 0.0165 0.0243 0.0050;
 0.0263 0.0169 0.0246 0.0045;
 0.0262 0.0175 0.0252 0.0047;
 0.0261 0.0173 0.0246 0.0049;
 0.0259 0.0173 0.0249 0.0053;
 0.0263 0.0170 0.0249 0.0055];

percent_75 = [ 0.0237 0.0137 0.0177 0.0016;
 0.0236 0.0140 0.0181 0.0017;
 0.0231 0.0141 0.0187 0.0018;
 0.0226 0.0142 0.0188 0.0014;
 0.0232 0.0138 0.0186 0.0022;
 0.0228 0.0133 0.0179 0.0015;
 0.0242 0.0139 0.0176 0.0011;
 0.0237 0.0145 0.0185 0.0020;
 0.0228 0.0133 0.0178 0.0026;
 0.0239 0.0133 0.0172 0.0016];

percent_80 = [ 0.0150 0.0128 0.0127 0;
 0.0152 0.0128 0.0135 0;
 0.0152 0.0129 0.0130 0;
 0.0145 0.0117 0.0134 0;
 0.0142 0.0123 0.0131 0;
 0.0143 0.0130 0.0138 0;
 0.0138 0.0129 0.0128 0;
 0.0143 0.0126 0.0129 0;
 0.0139 0.0126 0.0133 0;
 0.0144 0.0120 0.0136 0];

percent_85 = [0.0092 0.0124 0.0080 0;
0.0089 0.0128 0.0073 0;
0.0090 0.0127 0.0075 0;
0.0089 0.0129 0.0082 0;
0.0091 0.0127 0.0083 0;
0.0098 0.0119 0.0077 0;
0.0102 0.0119 0.0074 0;
0.0090 0.0124 0.0078 0;
0.0093 0.0137 0.0083 0;
0.0096 0.0130 0.0076 0];

percent_90 = [0.0045 0.0032 0.0067 0;
0.0047 0.0026 0.0066 0;
0.0045 0.0031 0.0065 0;
0.0049 0.0033 0.0066 0;
0.0048 0.0027 0.0063 0;
0.0049 0.0025 0.0064 0;
0.0046 0.0028 0.0068 0;
0.0049 0.0027 0.0068 0;
0.0045 0.0030 0.0063 0;
0.0047 0.0028 0.0066 0];

percent_95 = [0.0002 0.0024 0.0035 0;
0.0002 0.0026 0.0034 0;
0.0004 0.0028 0.0032 0;
0.0002 0.0026 0.0033 0;
0.0006 0.0025 0.0032 0;
0.0005 0.0026 0.0034 0;
0.0003 0.0025 0.0032 0;
0.0006 0.0025 0.0030 0;
0.0003 0.0023 0.0032 0;
0.0007 0.0023 0.0034 0];
%% Create the separate instances (multiples of 10) for Messenging

agent_click_activity_1 = zeros(10,8);
agent_click_activity_1(:,1) = percent_60(:,1);
agent_click_activity_1(:,2) = percent_65(:,1);
agent_click_activity_1(:,3) = percent_70(:,1);
agent_click_activity_1(:,4) = percent_75(:,1);
agent_click_activity_1(:,5) = percent_80(:,1);
agent_click_activity_1(:,6) = percent_85(:,1);
agent_click_activity_1(:,7) = percent_90(:,1);
agent_click_activity_1(:,8) = percent_95(:,1);

agent_click_activity_1 = agent_click_activity_1.*100;

%% Scatterplot of percentages (Checking Email)
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];

for i = 1: 10
    scatter(agent_comp',agent_click_activity_1(i,:));
    hold on
end
title("Agent Click Rate for Checking email")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
%legend('Messenger')
hold off
%% Create the separate instances (multiples of 10) for Websurfing

agent_click_activity_2 = zeros(10,8);
agent_click_activity_2(:,1) = percent_60(:,2);
agent_click_activity_2(:,2) = percent_65(:,2);
agent_click_activity_2(:,3) = percent_70(:,2);
agent_click_activity_2(:,4) = percent_75(:,2);
agent_click_activity_2(:,5) = percent_80(:,2);
agent_click_activity_2(:,6) = percent_85(:,2);
agent_click_activity_2(:,7) = percent_90(:,2);
agent_click_activity_2(:,8) = percent_95(:,2);

agent_click_activity_2 = agent_click_activity_2.*100;
%% Scatterplot of percentages (Websurfing)
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];

for i = 1: 10
    scatter(agent_comp',agent_click_activity_2(i,:));
    hold on
end
title("Agent Click Rate for Websurfing")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
%legend('Messenger')
hold off


%% Create the separate instances (multiples of 10) for Mobile Phone

agent_click_activity_3 = zeros(10,8);
agent_click_activity_3(:,1) = percent_60(:,3);
agent_click_activity_3(:,2) = percent_65(:,3);
agent_click_activity_3(:,3) = percent_70(:,3);
agent_click_activity_3(:,4) = percent_75(:,3);
agent_click_activity_3(:,5) = percent_80(:,3);
agent_click_activity_3(:,6) = percent_85(:,3);
agent_click_activity_3(:,7) = percent_90(:,3);
agent_click_activity_3(:,8) = percent_95(:,3);

agent_click_activity_3 = agent_click_activity_3.*100;
%% Scatterplot of percentages (Mobile Phone)
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];

for i = 1: 10
    scatter(agent_comp',agent_click_activity_3(i,:));
    hold on
end
title("Agent Click Rate for Mobile Phone")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
%legend('Messenger')
hold off


%% Create the separate instances (multiples of 10) for Messenger

agent_click_activity_4 = zeros(10,8);
agent_click_activity_4(:,1) = percent_60(:,4);
agent_click_activity_4(:,2) = percent_65(:,4);
agent_click_activity_4(:,3) = percent_70(:,4);
agent_click_activity_4(:,4) = percent_75(:,4);
agent_click_activity_4(:,5) = percent_80(:,4);
agent_click_activity_4(:,6) = percent_85(:,4);
agent_click_activity_4(:,7) = percent_90(:,4);
agent_click_activity_4(:,8) = percent_95(:,4);

agent_click_activity_4 = agent_click_activity_4.*100;
%% Scatterplot of percentages (Messenger)
agent_comp = [60 65, 70, 75, 80, 85, 90, 95];

for i = 1: 10
    scatter(agent_comp',agent_click_activity_4(i,:));
    hold on
end
title("Agent Click Rate for Messenger")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
%legend('Messenger')
hold off

%%
%[click_percent_step_mean,report_rate, vuln_incident_total] = create_suborganization(a_size_total, days, agent_compliance_average, incident_threshold, phish_report_rate);
%% This converts the results into one matrix
agent_click = toArray(click_percent_step_mean(:,1),4);
%{
[idx_control, score_control] = fsulaplacian(input_output2);

rank_control = zeros(1,i_size);
for i = 1: i_size
    rank_control(idx_control(i))= i;
end

feature_control = [rank_control',score_control(idx_control)'];
%}
%[idx, scores] = fsrftest(input_output2, label_final);

if temp == 0
            value = .15;
            i_scores(P,Q) = calculate_max_min(sample_incident_score, value);
        else
            value = .25;
            i_scores(P,Q) = calculate_max_min(sample_incident_score, value);
        end
%%
%{
    for P = 1: days/2 
        for Q = 1: i_size
            temp = randi([0,1],1);
            if temp == 0
                min = sample_incident_score(1,Q)-(.25*sample_incident_score(1,Q));
                max = sample_incident_score(1,Q)-(.30*sample_incident_score(1,Q));
                i_scores(P,Q)= min + (max-min)*rand(1,1);
            else
                min = sample_incident_score(1,Q)+(.25*sample_incident_score(1,Q));
                max = sample_incident_score(1,Q)+(.30*sample_incident_score(1,Q));
                i_scores(P,Q)= min + (max-min)*rand(1,1);
            end
        end
    end
%}
%%
%{
    for P = 1: days/2
        for Q = 1: i_size
            temp = randi([0,1],1);
            if temp == 0
                min = sample_no_incident_score(1,Q)-(.25*sample_no_incident_score(1,Q));
                max = sample_no_incident_score(1,Q)-(.30*sample_no_incident_score(1,Q));
                no_i_scores(P,Q)= min + (max-min)*rand(1,1);
            else
                min = sample_no_incident_score(1,Q)+(.25*sample_no_incident_score(1,Q));
                max = sample_no_incident_score(1,Q)+(.30*sample_no_incident_score(1,Q));
                no_i_scores(P,Q)= min + (max-min)*rand(1,1);
            end
        end
    end
%}
%%
%% Ranking
% This portion determines the ranking of each feature
[idx_control, score_control] = fsrftest(input_output2, label_final);
idx = num2str(idx_control);
rank_control = zeros(1,i_size);
for i = 1: i_size
    rank_control(idx_control(i))= i;
end

feature_control = [rank_control',score_control(idx_control)'];
%%
bar(score_control(idx_control))
xlabel('Predictor rank')
ylabel('Predictor importance score')
%%
idxInf = find(isinf(score_control));
%%
hold on
bar(score_control(idx_control(length(idxInf)+1))*ones(length(idxInf),1))
%xticklabels(strrep(tbl.Properties.VariableNames(idx),'_','\_'))


xtickangle(45)
legend('Finite Scores','Infinite Scores')
hold off
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


%%
% action (1,1) checking email 40 to 80% [30 +1 minute]
% action (1,2) websurfing 5 to 10% [15 + 1 minute]
% action (1,3) mobile phone 10 to 50% [5 + 1 minute]
% action (1,4) messenger 5 to 15% [10 + 1 minute]

% mc_baseline
%size = size(mc_baseline{1,1},1);
%current_time = work_start;
%240 lunch
%480 ends the day 510 ends with lunch

%schedule = zeros(steps(1,1),3);
schedule = cell(steps(1,1),4);
temp = randi([5,9],1,1);
work_start = duration(hours(temp),'format','hh:mm');
agent_time = cell(steps(1,1),1);
execution = 0;
time_worked = 0;
lunch_minutes = 0;
lunch_time = 0;
    
for i = 1:steps(1,1)
    %while time_worked < 510
    if time_worked < 510
    if mc_baseline{1,1}(i,1) == 1
        execution = 31;
       
    elseif mc_baseline{1,1}(i,1) == 2
        execution = 16;
       
    elseif mc_baseline{1,1}(i,1) == 3
        execution = 6;
      
    else        
        execution = 11;
      
    end
  
    schedule{i,2} = time_worked; 
    schedule{i,3} = mc_baseline{1,1}(i,1);% the action
    schedule{i,4} = execution;% the amount of time
    % calculating lunch
    if time_worked >= 240 && time_worked <= 270
        execution = 30;
        lunch_minutes = time_worked;
        temp = duration(hours(lunch_minutes/60),'format','hh:mm');
        lunch_time = work_start + temp; 
        schedule{i,3} = 'Lunch' ;% the action
        schedule{i,4} = execution;
    end
time_worked = time_worked + execution;
if i == 1
    schedule{i,1} = work_start;
     %schedule{i,2} = execution; 
else
   %temp = duration(hours(time_worked/60),'format','hh:mm');
  temp = duration(hours(schedule{i-1,4}/60), 'format','hh:mm');
   %temp2 = hours(work_start + temp);
 temp2 = hours(schedule{i-1,1} + temp);
  
    schedule{i,1} = duration(hours(temp2),'format','hh:mm');
end

    end
% calculating the end of the day
temp = duration(hours(time_worked/60),'format','hh:mm');
work_end = work_start + temp;
end

%%
schedule= schedule(~all(cellfun(@isempty,schedule),2),:);
%%
A = create_schedule(mc_baseline{1,1});
%%
%mc_baseline{1,1}(size(agent_schedule(1,1),1))
 temp =  size(agent_schedule{1,1},1);
%mc_baseline{1,1}(size(agent_schedule{1,1},1),1)
mc_baseline{1,1}(a+1: end) =[];
%%
transition_matrix = zeros(actions_size,actions_size);
for i = 1: actions_size
    for j = 1:sum(actions_initial,2)
        if j < sum(actions_initial,2)
            if transition_data(j,1) == i && transition_data(j,1) == transition_data(j+1,1)
                transition_matrix(i,i) = transition_matrix(i,i) + 1;
            end
        end
    end
end
%% This does 1-2, 1-3, and 1-4 in a diagonal 

transition_matrix = zeros(actions_size,actions_size);
for i = 1: actions_size
    for j = 1:sum(actions_initial,2)
        if j < sum(actions_initial,2)
            if transition_data(j,1) == i && transition_data(j+1,1) ==  i+1
                transition_matrix(1,i+1) = transition_matrix(1,i+1) + 1;
            end
        end
    end
end
%% This does 1-2, 1-3, and 1-4 as diagonal

transition_matrix = zeros(actions_size,actions_size);
for i = 1: actions_size
    for j = 1:sum(actions_initial,2)
        if j < sum(actions_initial,2)
            if transition_data(j,1) == i && transition_data(j+1,1) ==  i+1
                transition_matrix(i,i+1) = transition_matrix(i,i+1) + 1;
            end
        end
    end
end