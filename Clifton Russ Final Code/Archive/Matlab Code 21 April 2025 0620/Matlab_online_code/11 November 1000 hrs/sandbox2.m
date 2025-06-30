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
mc = dtmc(actions_baseline); %creates markov chain from the actions baseline
mc.StateNames = ["Emailing" "Web Browsing" "Text Messaging" "Phone Messenging"];
mc_sum = sum(actions_baseline,2);% Calculates the total steps 
mc_steps = round(mean(mc_sum,1)); % determines the average steps a day

mc_baseline = simulate(mc, mc_steps);%simulates the steps for each day

actions_initial_size = sum(actions_initial,2);
%% Determine initial transition Matrix
% This determines the initial baseline {transition Matrix}
temp = sum(actions_initial,2); % caluclates the sum
transition_data = 0;
for i = 1: actions_size
    temp = i* ones(1,actions_initial(1,i));
    transition_data = [transition_data, temp];
end

transition_data = nonzeros(transition_data);
%% Shuffle the transition data
%transition_data = randperm(transition_data);
transition_data=transition_data(randperm(length(transition_data)));


%% Creates the initial transition matrix

[transition_matrix] = create_transition_matrix(actions_initial,transition_data, actions_size,1,1);
%%
for i = 1:actions_size
    for j = 1:actions_size
        transition_matrix(i,j) = create_transition_matrix(actions_initial,transition_data, actions_size,i,j);
    end
end
%%
%Determine the sum of each row
temp = sum(transition_matrix,2);
temp = transition_matrix./temp;
temp2 = round(temp*100);