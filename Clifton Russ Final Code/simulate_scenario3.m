function [input_total,label_total, click_rate_final] = simulate_scenario3(vuln_controls,e_thresholds_daily, people, incident_threshold, limit)
%% Runs the test_function
test_function_v3;

%% Merge all safeguard controls for activity 1
% agent index
agent_idx = [];
vuln_input_activity_1 = [];
for i = 1: 10
    for j = 1: 50
        [temp] = create_vuln_input(vuln_controls{i,j}(:,1), e_thresholds_daily{1,j}, 1);
        temp2 = i*ones(size(temp,1),1);
        vuln_input_activity_1 = [vuln_input_activity_1;temp];
        agent_idx = [agent_idx; temp2];
    end
end
%% Determine vulnerability

vuln1_incidents = zeros(size(vuln_input_activity_1,1),size( vuln_input_activity_1,2));
 for i = 1: size(vuln_input_activity_1,1)
     [vuln1_incidents(i,:), ~] = determine_incident2(people{agent_idx(i,1),2},vuln_input_activity_1);
 end
 %% Determine breach
 %[a_breach, a_breach_total] = determine_breach3(vuln_controls,incident_threshold);
 [input_breach] = determine_breach3(vuln1_incidents,incident_threshold);

%% Determine the label

temp = sum(input_breach,2);
label_temp = zeros(size(vuln_input_activity_1,1),1);
for i = 1: size(vuln_input_activity_1,1)
    if temp(i,1) > 1
        label_temp(i,1) = 1;
    end
end

%% Combine the data
combined_data = [ vuln1_incidents label_temp];
%% Gather "True" instances
temp = 0;
for i = 1: size(combined_data,1)
    if combined_data(i,size(combined_data,2)) ==1
        temp = temp +1;
        true_data(temp,:) = combined_data(i,:);
    end
end

%% Gather "False" instances
temp = 0;
for i = 1: size(combined_data,1)
    if combined_data(i,size(combined_data,2)) == 0
        temp = temp +1;
        false_data(temp,:) = combined_data(i,:);
    end
end
%% Reduce both data sets
% This reduces the data sets to not exceed 200 rows 
clicked = size(true_data,1);
true_data(201:end,:) = [];
false_data(201:end,:)= [];

%% Combines the data sets
combined_data2 = [true_data; false_data];
%% Shuffles the data
shuffled_data = combined_data2(randperm(size(combined_data2, 1)), :);

%% Shuffles assigns the labels
label_final = shuffled_data(:,size(shuffled_data,2));
%% Removes the label at the end of the data
shuffled_data(:,16) = [];

%%

%click_rate_final = (1,actions_size);


%% Train against Action 1
idx = 1;
%limit = 2;
[input_data, label_final,click_rate_final(1,idx) ] = predict_breach(vuln_controls,e_thresholds_daily, people, idx,incident_threshold, limit);

%% Train against Action 2
idx = 2;
%limit = 2;
[input_data2, label_final2,click_rate_final(1,idx) ] = predict_breach(vuln_controls,e_thresholds_daily, people, idx,incident_threshold, limit);

%% Train against Action 3
idx = 3;
%limit = 2;
[input_data3, label_final3,click_rate_final(1,idx) ] = predict_breach(vuln_controls,e_thresholds_daily, people, idx,incident_threshold, limit);
%% Train against Action 4
idx = 4;
%limit = 2;
[input_data4, label_final4,click_rate_final(1,idx) ] = predict_breach(vuln_controls,e_thresholds_daily, people, idx,incident_threshold, limit);
%%
click_rate_final= click_rate_final*100;

input_total = [{input_data}, {input_data2}, {input_data3}, {input_data4}];
label_total = [{label_final}, {label_final2},{label_final3}, {label_final3}, {label_final4}];
end