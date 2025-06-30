%% Scenario 3:
% These are the indpendent test values used for Scenario 3. 
vuln_size = 1;
agent_compliance_average = .7;
% This resets the days to 200 to provide multiple observations as each day
% represents an observation.
days = 200;
% This data set represents the default control compliance scores that
% yields to an agent induced incident
sample_incident_score = ...
    [.7,.6,.58,.53,.85,...
    .65,.63,.92,.90,.85, ...
    .92,.75,.85,.62,.84, ... 
    .92, .68,.72,.63,.72,...
    .92, .93,.82,.65,.82 ];

% This data set represents the default control compliance scores that does
% not result in an incident
sample_no_incident_score = ... 
    [.92, 1, 1, .94, 1, ... 
      1, 1, .75, 1, 1, ... 
      1,.85, 1, .82, .64, ...
     .62, .88, .76,.68,.88, ...
    .82, .83, .72,.85,.72 ];
%% Scenario selector
%scenario = "3c1"; % 0% to 5% variance
%scenario = "3c2"; % 05% to 10% variance
%scenario = "3c3"; % 10% to 15% variance
%scenario = "3c4"; % 15% to 20% variance
%scenario = "3c5"; % 20% to 25% variance
scenario = "3c6"; % 25% to 30% variance
%scenario = "3c7"; % 30% to 35% variance
%scenario = "3c8"; % 35% to 40% variance
%scenario = "3c9"; % 40% to 45% variance
%scenario = "3c10"; % 45% to 50% variance
%% Establishing the incident data Structure

% This creates the matrix for the incidents. i_size represents the number
% of controls. i_scores is the actual matrix. The control scores change
% daily. This code splits the number of days evenly, half of the time there
% is an incident. The other half of the time, there is no incident. This
% minimizes the program from guessing "incident" because most of the
% samples are incidents or guessing "no incident" because most of the
% samples are not incidents.
i_size = size(sample_incident_score,2);
i_scores = zeros(days/2,vuln_size);
%% Create daily change of Control Compliance
% This demonstrates daily change for the controls that represent an
% incident. For this test, 50% of the data results in an incident.
% Therefore P goes from 1 to days/2. The variance is +/- 25% of the
% original control compliance score.  

% The variance is manually changed here to see the impact to the machine
% learning accuracy
%% Scenario 3c1
% This scenario looks at varaince between 0% to 5%
if scenario == "3c1"
    for P = 1: days/2 
        for Q = 1: i_size
            min = sample_incident_score(1,Q)-(.05*sample_incident_score(1,Q));
            max = sample_incident_score(1,Q)+(.05*sample_incident_score(1,Q));
            i_scores(P,Q)= min + (max-min)*rand(1,1);    
        end
    end
end
%% Scenario 3c part 2
% This scenario looks at variance between 5% to 10%.
if scenario == "3c2"  
    min = .05;
    max = .10;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 3
% This scenario looks at variance between 10% to 15%.
if scenario == "3c3"  
    min = .10;
    max = .15;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end

%% Scenario 3c part 4
% This scenario looks at variance between 15% to 20%.
if scenario == "3c4"  
    min = .15;
    max = .20;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 5
% This scenario looks at variance between 20% to 25%.
if scenario == "3c5"  
    min = .20;
    max = .25;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 6
% This scenario looks at variance between 25% to 30%.
if scenario == "3c6"  
    min = .25;
    max = .30;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 7
% This scenario looks at variance between 25% to 30%.
if scenario == "3c7"  
    min = .30;
    max = .35;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 8
% This scenario looks at variance between 35% to 40%.
if scenario == "3c8"  
    min = .35;
    max = .40;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 9
% This scenario looks at variance between 40% to 45%.
if scenario == "3c9"  
    min = .40;
    max = .45;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c part 10
% This scenario looks at variance between 45% to 50%.
if scenario == "3c10"  
    min = .45;
    max = .50;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%%
% This adds a column to represent the label of an "incident". The digit "1"
% repesents a positive incident.
temp = ones(days/2,1);

i_scores = [ i_scores,temp];

%%

no_i_size = size(sample_no_incident_score,2);
no_i_scores = zeros(days/2,vuln_size);

% This demonstrates daily change for controls that do not represent an
% incident. For this test, 50% of the data results in "no incident".
% Therefore P goes from 1 to days/2. The variance is +/- 25% of the
% original control compliance score. 

% The variance is manually changed here to see the impact to the machine
% learning accuracy
%% Scenario 3c1
% This scenario looks at varaince between 0% to 5%
for P = 1: days/2
    for Q = 1: i_size
        min = sample_no_incident_score(1,Q)-(.05*sample_no_incident_score(1,Q));
        max = sample_no_incident_score(1,Q)+(.05*sample_no_incident_score(1,Q));
        no_i_scores(P,Q)= min + (max-min)*rand(1,1);
        
    end
            
end

%% Scenario 3c Part 2
% This scenario looks at variance between 5% to 10%.
if scenario == "3c2"
    min = .05;
    max = .10;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%% Scenario 3c Part 3
% This scenario looks at variance between 10% to 15%.
if scenario == "3c3"
    min = .10;
    max = .15;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%% Scenario 3c Part 4
% This scenario looks at variance between 15% to 20%.
if scenario == "3c4"  
    min = .15;
    max = .20;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c Part 5
% This scenario looks at variance between 20% to 25%.
if scenario == "3c5"  
    min = .20;
    max = .25;
    [i_scores] = calculate_new_scores(days,i_size,sample_incident_score,min,max,i_scores);
end
%% Scenario 3c Part 6
% This scenario looks at variance between 25% to 30%.
if scenario == "3c6"
    min = .25;
    max = .30;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%% Scenario 3c Part 7
% This scenario looks at variance between 30% to 35%.
if scenario == "3c7"
    min = .30;
    max = .35;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%% Scenario 3c Part 8
% This scenario looks at variance between 35% to 40%.
if scenario == "3c8"
    min = .35;
    max = .40;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%% Scenario 3c Part 9
% This scenario looks at variance between 40% to 45%.
if scenario == "3c9"
    min = .40;
    max = .45;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%% Scenario 3c Part 10
% This scenario looks at variance between 45% to 50%.
if scenario == "3c10"
    min = .45;
    max = .50;
    [no_i_scores] = calculate_new_scores(days,i_size,sample_no_incident_score,min,max,no_i_scores);
        
end
%%
% This adds a column to represent the label of "no incident". The digit "0"
% repesents a positive incident.
temp = zeros(days/2,1);
no_i_scores = [ no_i_scores,temp];

%% Randomize the incidents and no incidents
% This combines the scores from the two groups (incident and no incident)
% into a temp array.
temp = [ i_scores; no_i_scores];

% This shuffles the rows in the temp array to mix up the controls to
% randomize which day represents an "incident" or "no incident".
combined_test_score = temp(randperm(size(temp, 1)), :);
%% Compare Agent scores to control compliance scores
% For each control/element, if the agent score is greater than the
% control's compliance score, then there is an infraction. A single
% infraction does not mean there is an incident. 

incident_test = zeros(days,i_size);
for i = 1: days
    for j = 1:i_size
        if agent_compliance_average > combined_test_score(i,j)
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
