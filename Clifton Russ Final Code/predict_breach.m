function [shuffled_data, label_final,click_rate_Scenario_3 ] = predict_breach(vuln_controls,e_thresholds_daily,people, activity_idx,incident_threshold, limit, reference)


%% Merge all safeguard controls for activity 1
% agent index
%{
agent_idx = [];
vuln_input_activity = [];
for i = 1: 10
    for j = 1: 50
        [temp] = create_input(vuln_controls{i,j}(:,1), e_thresholds_daily{1,j}, idx);
        temp2 = i*ones(size(temp,1),1);
        vuln_input_activity = [vuln_input_activity;temp];
        agent_idx = [agent_idx; temp2];
    end
end
%}
agent_idx = [];
vuln_activity = [];
for i = 1: 10
    for j = 1: 50
        [temp] = create_input(vuln_controls{i,j}(:,1), e_thresholds_daily{1,j}, activity_idx);
        temp2 = i*ones(size(temp,1),1);
        vuln_activity = [vuln_activity;temp];
        agent_idx = [agent_idx; temp2];
    end
end
%% Determine vulnerability
%{
vuln_incidents = zeros(size(vuln_input_activity,1),size( vuln_input_activity,2));
 for i = 1: size(vuln_input_activity,1)
     [vuln_incidents(i,:), ~] = determine_incident2(people{agent_idx(i,1),2},vuln_input_activity);
 end
%}

vuln_incidents = zeros(size(vuln_activity,1),size( vuln_activity,2));
 for i = 1: size(vuln_activity,1)
     [vuln_incidents(i,:),~, vuln_exploits(i,:),exploit_total(i,:) ] = determine_incident2(people{agent_idx(i,1),2},people{agent_idx(i,1),3}(1,activity_idx),vuln_activity,activity_idx);

 end
 %% Determine breach
 %[a_breach, a_breach_total] = determine_breach3(vuln_controls,incident_threshold);
 %[input_breach] = determine_breach3(vuln_incidents,incident_threshold);

%% Determine the label
% This determines labels for each instance based on the number of failed
% controls (breaches)
%{
temp = sum(input_breach,2);
label_temp = zeros(size(vuln_input_activity,1),1);
for i = 1: size(vuln_input_activity,1)
    if temp(i,1) == limit || temp(i,1) > limit
        label_temp(i,1) = 1;
    end
end
%}
temp = sum(vuln_exploits,2);
label_temp = zeros(size(vuln_exploits,1),1);

for i = 1: size(vuln_exploits,1)
    if temp(i,1) == limit || temp(i,1) > limit
        label_temp(i,1) = 1;
    end
end

%% Combine the data
% This determines to whether to use the actual scores or breaches as input
if reference == 1
    combined_data = [ vuln_incidents label_temp];% incident binary
elseif reference == 2
    combined_data = [ vuln_activity label_temp];% vuln scores
end
%% Gather "True" instances
temp = 0;
true_data = [];
for i = 1: size(combined_data,1)
    if combined_data(i,size(combined_data,2)) ==1
        temp = temp +1;
        true_data(temp,:) = combined_data(i,:);
    end
end

%% Gather "False" instances
temp = 0;
false_data = [];
for i = 1: size(combined_data,1)
    if combined_data(i,size(combined_data,2)) == 0
        temp = temp +1;
        false_data(temp,:) = combined_data(i,:);
    end
end
%% Reduce both data sets
% This reduces the data sets to not exceed 200 rows 
clicked = size(true_data,1);
%if isempty(false_data) == 0 && isempty(true_data) == 0 
    true_data(201:end,:) = [];
    false_data(201:end,:)= [];

%% Combines the data sets


    combined_data2 = [true_data; false_data];
%% Shuffles the data
    shuffled_data = combined_data2(randperm(size(combined_data2, 1)), :);

%% Shuffles assigns the labels
    label_final = shuffled_data(:,size(shuffled_data,2));
%% Removes the label at the end of the data
    shuffled_data(:,end) = [];
%% Determine the clickrate
    opportunities = size(vuln_activity,1) *size(vuln_activity,2);
    click_rate_Scenario_3 = clicked/opportunities;



end