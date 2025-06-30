   %% This is a tester class that tests the functions of the program
clc;clear;
%% Creates the control data
%run test_envi ronment.m;
num_control = 6;
%[training_data] = create_training_data(control_compliance,vuln_size, iteration);
%% This creates The agents
start = 1;
stop = 10;
vuln_size = 3; % 7;%6
people = create_agent(start,stop,vuln_size);
%% Taking the mean of agents' overall compliance
%This is done to simulate assessing an organization's compliance. In
%practice, people do not come with compliance scores. While it is possible
%to create a risk profile based on historical information, the more
%practical solution is to assess the organization as a whole with any
%exceptions.

temp = cell2mat(people(:,2));
agent_average = mean(temp);
%agent_average = 60;
%% Taking the mean of the agents' vulnerability threat scores

% This takes the mean of all the agent vulnerability threat scores to
% represent one score. This is done to simulate assessing an organization's
% compliance as there are typically no risk profiles on agents.

vuln_agent_average = calculate_agent_average(people, vuln_size );
%%
% This creates a cell of environment thresholds. Each row represents an
% incident. Within each cell, there is an array of vulnerability thresholds
% associated with each control related to that incident. For example, a
% phishing incident might have 20 related controls while a compromised
% password might have 15 related controls. For the phishing incident, there
% would be a 1 x 20 array where each column is the control ( or
% environment) threshold. 
e_thresholds_base = cell(num_control,vuln_size); % environment thresholds
e_min =.45;
e_max =.95;


%%%%%%%%%% XACTA has actual control compliance scores!!!!
% e_thresholds represent the controls for a control family. This needs to
% be renamed to avoid confusion. Each vulnerability will be a combination
% of control compliance.
for i = 1: num_control
    for j = 1: vuln_size 
        r = randi([5 25],1, 1);
        e_thresholds_base{i,j}= e_min + (e_max-e_min)*rand(1,r);
    end
end


%%
% In this section, need to add/subtract up to 10% for the scores for every
% 7,14,30, 90 and 365 days.


%% Takes the mean of each control to act as input data
e_size = size(e_thresholds_base,2);
%e_threshold_mean = zeros(1,e_size);

%{
for i = 1:vuln_size
    e_threshold_mean(1,i) = mean(e_thresholds{1,i}(1,:));
end
%}
%% This determines which e_threshold data to use based on the current state

%mc_size = size(mc_baseline,1);
a_size = size(people,1); %agent size
days = 200;
mc_incident = cell(a_size, days);
mc_baseline = cell(a_size, days);
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
       
        actions_baseline = create_action_baseline(actions_initial); 
        % Creates mc_baseline
        % This section takes the actions_baseline and applies the markov chain to
        % determine the transition rates

%%
        %e_size = size(e_thresholds,2);
        % The control size is defined for each vulnerability. This version
        % is not differentiating control families, but specific controls.
        % In other words, the previous implementation separated the
        % controls by control family, which allowed to assess based on
        % certain controls. This assessment will focus on all the controls
        % relevant to the vulnerability regardless of the control family.
        control_size = zeros(1,vuln_size);
        for m = 1: vuln_size
            control_size(1,m) = size(attribute_selection{m,1},2);
        end

        
         control_size = zeros(num_control, e_size);
            
            for m = 1 : num_control %e_size
                for n = 1: e_size %num_control
                    control_size(m,n) = size(e_thresholds_base{m,n},2);
                end
            end
        
%% Slight change of environment control scores
% This needs to be updated to only update each day for each iteration. This
% currently updates the entire e thresholds all at once.

temp = cell(num_control,vuln_size);
for k = 1:days
    for P = 1:num_control
        for Q = 1:vuln_size
            temp{P,Q} = create_new_env_score(e_thresholds_base(P,Q),control_size(P,Q));
        end
    end
    e_thresholds_daily{1,k} = temp;
end

%e_thresholds = temp;
%%
        % This calculates all the controls associated for each
        % vulnerability
      % [control_count, control_cell] = determine_control_count(e_thresholds,control_size);
%% This calls the "create e variable" function
    %variable = create_e_variable(e_thresholds, control_size, num_control,e_size);
%% Change the dimensions of control count

vuln_control_count = cell(1,vuln_size);

for n = 1:vuln_size
    vuln_control_count{1,n} = [e_thresholds{:,n}];
end



%% Vulnerability Control Count Size
% This calculates the number of controls in support of each vulnerability
        

            %vuln_control_size = size(1,vuln_size);

            for m = 1 : vuln_size%num_control
                vuln_control_size(1,m) = size(vuln_control_count{1,m},2);    
            end


            vuln_ctrl_size = size(num_control,1);

            for m = 1 : num_control
                vuln_ctrl_size(m,1) = size(vuln_control_count{m,1},2);    
            end
           
%%
        mc_temp = create_mc_baseline(actions_baseline);
        mc_baseline{i,j} = mc_temp;

   %{
        For each phase, count the total number controls associated. For example,
        during the day an agent is at step 1 20 times, then 20 * the number of 
        controls associated with step 1. In this case, that would be control 1 
        and control 2 total.

        Control Count represents the scores for each control within the
        environment that corresponds to a particular vulnerability.

        This flips the dimensions to better align with the vulnerabilities
        (horizontal) as opposed to the controls (vertical).
   %}

%control_count = control_count';

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


%%
mc_count_total = cell(1,days);
for i = 1: days
    mc_count_total{1,i} = sum(cell2mat(mc_count_day(1,i)));
end
%%


%% Calculate the total number of controls per state
% This is different than the first iteration where each state calculated
% the controls related to a particular vulnerability for all states for a
% given day. This calculates the number of controls per state per day.

%num_control;
%num_state = max( control_size ,[], 2 ) ;
%%
% determine the amount of controls aligned to the step
% use the num_state to determine number of controls associated with each
% control for each state
%control_per_state = randi([1 3],1,actions_size);

%%

% This takes the number of control family per state/step and then
% determines which control family will be associated with each state/step
% by randomly selecting a number. Each number represents a control family
% and the amount of numbers is based on the number of control families per
% state.

control_combo = cell(actions_size,1);
for i = 1:actions_size
    control_combo{i,1} = randperm(num_control,control_per_state(i));
end

%%

control_size_v1 = cell(1,1);
% This calculates the number of controls for each control family

for i = 1: num_control
    control_size_v1{i,1} = size(e_thresholds_daily{1,1}{i,1},2);
end

%%
% This determines the number of controls for each vulnerability
% Or should each vulnerability be by step??????

%first determine the number of controls per control family per
%vulnerability. Then select randsample that many controls from the control
%family. Create a separate array that stores the index for each selected
%control. Use the indeces to reference the current control.


% This for loops sorts through each vulnerability and determining the max
% amount of controls from each control family that is associated with that
% vulnerability.

vuln_control_count3 = zeros(num_control, vuln_size);

for i = 1: num_control
    for j = 1:vuln_size
        r = randi([0 control_size_v1{i,1}(1,1)],1, 1);
        vuln_control_count3(i,j) = r;
    end
end

%%

% Also not every control will
% change. It needs to be possible for some controls to remain the same
% vuln_control_count3 selects the number of controls from the control
% family that applies to the vulnerability. The vuln_control selects "vuln
% control count" amount of controls from the e_thresholds to represent the
% controls for that vulnerability.


vuln_control = cell(1, days);
for i = 1: days
    for j = 1: num_control
        for k = 1:vuln_size
            r = randsample(e_thresholds_daily{1,i}{j,1},vuln_control_count3(j,k));
            vuln_control{1,i}{j,k} = r;
        end
    end
end

vuln_num_per_step = randi([1 vuln_size],1,actions_size);


if vuln_size <= num_control
    vuln_per_state = randi([1 vuln_size],1,actions_size);
else
    vuln_per_state = randi([1 num_control],1,actions_size);
end

%%

% This takes the number of vulnerabilities per state/step and then
% calculates the total controls based on the control combination for each
% state.

vuln_combo = cell(actions_size,1);
for i = 1:actions_size
    vuln_combo{i,1} = randperm(num_control,vuln_num_per_step(i));
end

%% Merge the vulnerabilities
% This creates a single cell vector of entries that correspond to each
% step. Within each step, there is another matrix for all of the controls
% for each vulnerability. For example, vuln_merge{1,1} represents all the
% controls for step 1. Within vuln_merge{1,1}, the matrix represents all
% the controls for each vulnerability. 

%vuln_merge = cell(actions_size,vuln_size);

%vuln_idx represents the value for the particular vulnerability. For
%example, 1 represents vulnearbility 1, while 2 represents vulnereability
%2.


vuln_idx = 1;
vuln_per_step = cell(1, days);

for m = 1: days
    for n = 1:actions_size
        [vuln_per_step{1,m}{n,1}] = calculate_vuln_per_step(vuln_combo(n,1), vuln_control{1,m}, vuln_idx);
    end
end

%% Matrix for each step
% This step has single vectors of all the controls related to each
% vulnerability. This takes the matrix from the vuln_per_step and consolidates
% the controls for each control into one vector.

%vuln_matrix = cell(1,actions_size);
%for i = 1:actions_size
%    vuln_matrix{1,i} = calculate_vuln_total(vuln_merge{i,1},num_control, vuln_size, vuln_combo);
%end

vuln_matrix = cell(1,days);
for i = 1:days
    for j = 1:actions_size
            vuln_matrix{1,i}{j,1} = calculate_vuln_final(vuln_per_step{1,i}{j,1});
    end
end


vuln_matrix = cell(actions_size,1);
for i = 1:actions_size
    vuln_matrix{i,1} = calculate_vuln_final(vuln_per_step{i,1});
end

%%

vuln_matrix_sorted = cell(1,actions_size);

for i = 1:actions_size
    vuln_matrix_sorted{1,i} = sort_vuln_matrix(vuln_combo(i,1),vuln_matrix{1,i},actions_size);
end

%%
% Need to make a determination between agent_average vs individual vuln
% scores for each vulnerability in people(1,j). Make updates in determine
% incident calculations

%agent_average = .01;

% This needs to be done for each vulnerability separately. Currently this
% only addresses the vulnerabilities from each step; however, only the
% controls associated with each vulnerability within the step should be
% used to calculate the number of incidents.
vuln_idx = 1;

%This is only comparing to the environment controls for vulnerability 1
vuln_agent_average(1,1) =.80;
vuln1_scores = cell(a_size,days);

    for i = 1:a_size
        for j = 1: days
             [vuln_1{i,j}, vuln1_scores] = determine_state_vuln5(vuln_agent_average(1,1), mc_baseline{i,j},actions_size,vuln_matrix{1,j},vuln_idx);
        end
    end

%% This merges the vulnerability scores into one matrix


%% Calculate all incidents for each day (for each step) with each person
%array_incident = cell(a_size,days);

vuln_incident_total = cell(a_size,days);
    for i = 1:a_size 
        for j = 1:days
        %array_incident{i,j} = calculate_total(mc_incident{i,j},mc_baseline{i,j}, actions_size);
        vuln_incident_total{i,j} = calculate_total2(vuln_1{i,j},mc_baseline{i,j}, actions_size);
        end
    end

%% This section determines the amount of breaches based on incidents

vuln_breach = cell(a_size, days);
%the incident thresholds represent the percent that a breach will occur.

incident_intrusion = 1944/3966;
incident_threshold = size(1,vuln_size);

for i = 1: vuln_size
    incident_threshold(1,i) = rand(1,1);
end

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
      %vuln_breach{i,j} = determine_breach(vuln_incident_total{i,j},incident_threshold(1,1)); 
      vuln_breach{i,j} = determine_breach(vuln_incident_total{i,j},incident_intrusion); 

    end
end
%}
%% Training data information for state 1.

%training_data = create_training_data(e_thresholds2, a_size, vuln_size, num_control, days,1);
%% Training labels for state 1
%training_labels = create_training_label(array_breach,days,1);

%% Training data information for state 2.

%training_data2 = create_training_data(e_thresholds2, a_size, vuln_size, days,2);
%% Training labels for state 1
%training_labels2 = create_training_label(array_breach,days,2);
    %% This section determines the amount of incidents by the day
%[by_day_sum,by_day_graph] = determine_by_day(array_incident,days,1);
%[by_day_sum,by_day_graph] = determine_by_day(array_breach,days,2);

%% This sectio determines the amount of incidents by the agent
%[by_agent_sum, by_agent_graph] = determine_by_agent(array_incident, a_size,1);
%[by_agent_sum, by_agent_graph] = determine_by_agent(array_breach, a_size,2);