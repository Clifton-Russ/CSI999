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
    
min = 5;
max = 50;
actions(1,1)= min_max(1,1) + (min_max(2,1)-min_max(1,1)).*rand(1,1);

%% Replace 0 and 1 with "exploit" and "no exploit"
%{
label_name = strings(days,1);

for i = 1: i_size
    if label_final(i) == 1
        label_name(i,1) = "Exploit";
    else
        label_name(i,1) = "No Exploit";
    end
end
%}
label_size = size(label_final,1);
label_name = strings(label_size,1);

for i = 1: label_size
    if label_final(i) == 1
        label_name(i,1) = "Exploit";
    else
        label_name(i,1) = "No Exploit";
    end
end
%% Plotting nonlinear
%{
Y = tsne(input_output2);
subplot(2,2,1)
gscatter(Y(:,1),Y(:,2),label_name)
title('nonlinear plot')
%}

Y = tsne(input_data);
subplot(2,2,1)
gscatter(Y(:,1),Y(:,2),label_name)
title('nonlinear plot')
%% Plotting nonlinear v2

%{
Y = tsne(input_output2, Algorithm="barneshut", Perplexity= 300);

figure
numGroups = length(unique(label_name));
clr = hsv(numGroups);
gscatter(Y(:,1),Y(:,2),label_name, clr)
%}
Y = tsne(input_data, Algorithm="barneshut", Perplexity= 300);

figure
numGroups = length(unique(label_name));
clr = hsv(numGroups);
gscatter(Y(:,1),Y(:,2),label_name, clr)
%% Plotting PCA using matlab visualization tool
%mapcaplot(input_output2,label_name)
mapcaplot(input_data,label_name)
%% Plotting PCA using gscatter (Component 1 v 2)
% Perform PCA

%[coeff, score, ~, ~, explained] = pca(input_output2);

[coeff, score, ~, ~, explained] = pca(input_data);
% Plot first two principal components
figure;
gscatter(score(:,1), score(:,2), label_name, 'grb', 'ox', 10);
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA: Component 1 vs Component 2');
grid on;
%% Plotting PCA using gscatter (Component 1 v 3)
% Perform PCA
[coeff, score, ~, ~, explained] = pca(input_data);
%[coeff, score, ~, ~, explained] = pca(input_output2);

% Plot first two principal components
figure;
gscatter(score(:,1), score(:,3), label_name, 'grb', 'ox', 10);
xlabel('Principal Component 1');
ylabel('Principal Component 3');
title('PCA: Component 1 vs Component 3');
grid on;
%%
figure;
histogram(score(:,1), 30);
xlabel('PC1 Values');
ylabel('Frequency');
title('Distribution of Principal Component 1');
grid on;
%%
disp(coeff(:,1:2));  % Show first 3 PCs' loadings
%%
labels_features = strings(1,i_size);
for i = 1: 25
    labels_features(1,i) = "F "+ i;
end

%%

biplot(coeff(:,1:2), 'VarLabels', labels_features );
title('PCA Biplot');
grid on;
%%
markov = dtmc(agent_actions); %creates markov chain from random matrix
%%  markov chain percentages

%markov_percentages = markov.actions;
 
%% Label State names
markov.StateNames = ["Working" "Walking" "Emailing" "Web Browsing" "other"];

%% view

figure;
graphplot(markov, 'ColorEdges', true);

%%
% the overall steps is determined by taking the average of all the actions
mc_steps = round(sum(mean(agent_actions))); 
%mc_steps = 10;
%mc_sim = simulate(markov, mc_steps);
x0 = [0,1,0,0,0];
mc_sim = simulate(markov, mc_steps, 'X0',x0);

%%
figure;
simplot(markov,mc_sim);
set(gca,'YTickLabel',[]);
%%
scatter(Y(:,1), Y(:,2))
%%
rng default
gscatter(Y(:,1),Y(:,2),label_name)
%%
addpath('G:\My Drive\School\George Mason\CSI 999 Disesertation\Matlab Code\umapFileExchange (4.4)\umap');
%%
data = rand(1000, 300);
%% UMAP Command
%[reduced_data, umap] = run_umap(input_output2, 'n_components', 2);
[reduced_data, umap] = run_umap(input_data, 'n_components', 2);
%%
scatter(reduced_data(:,1), reduced_data(:,2), 100, 'filled');
title('UMAP Visualization');
xlabel('UMAP Dimension 1');
ylabel('UMAP Dimension 2');
grid on;

%%
figure;
for i = 1:size(input_output2,2)
    subplot(1,3,i);
    histogram(input_output2(:,i));
    title(['Feature ', num2str(i)]);
    xlabel('Value');
    ylabel('Frequency');
end
sgtitle('Feature Distributions Before PCA');
%% Applyy PCA
[coeff, score, latent, ~, explained] = pca(input_output2);
%% Plot varaince
pareto(explained);
xlabel('Principal Components');
ylabel('Variance Explained (%)');
title('Variance Explained by PCA Components');
%% 
%vuln1_scores
sz = size(cell2mat(vuln1_scores{1,1}(4,1)),2);
%for i = 1:
%% This simulates Scenario 3 multiple times
iterations = 10;
input_total = cell(1,iterations);
label_total = cell(1,iterations);
click_rate_total = cell(1,iterations);
for i = 1: iterations
    [input_total{1,i},label_total{1,i}, click_rate_total{1,i}] = simulate_scenario3(vuln_controls,e_thresholds_daily, people, incident_threshold);
end
%%
load('trained_Model_A1_2B');

train_data = (input_data(1:100,:));
test_data = (input_data(101:end,:));
train_label = (label_final(1:100,:));
test_label = (label_final(101:end,:));
%%
k = 10;
Mdl = fitcknn(train_data, train_label, 'NumNeighbors',k);
predictedLabels = predict(Mdl, test_data);
%%
mean(predictedLabels ==test_label)
%%
accuracy_NB_G = zeros(1,iterations);

A = train_data{1,1};
B = train_label{1,1};
%%
A(:,1) = [];
%B(:,1) = [];
%%
 Mdl = fitcnb(A,B);
 predictedLabels = predict(Mdl, A, 'DistributionNames','kernel');
%%
for i = 1:iterations

    Mdl{1,i} = fitcnb(train_data{1,i},train_label{1,i});
    predictedLabels{1,i} = predict(Mdl{1,i}, test_data{1,i});

   accuracy_NB_G(1,i) = mean(predictedLabels{1,i}(:,1) == test_label{1,i}(:,1));
end
disp( "The accuracy for Naive Bayes with Gausian distribution is " + mean(accuracy_NB_G)*100 +"%" );
%%
%[yfit, scores] = trainedModel_activity1.predictFcn(input_data);
%%
train_data = input_data(1:200,:);
train_label = (label_final(1:200,:));

test_data = input_data(201:end,:);
test_label = (label_final(201:end,:));

%%
mdl = fitcsvm(train_data, train_label, 'kernelFunction', 'linear');

%%
predicted_label = predict(mdl,test_data);
%%
mean(predicted_label ==test_label)
%%
bar(coeff(:,1))
xticks(1:size(input_data,2))
xlabel('Original Feature')
ylabel('Loading on PC1')
title('Feature Contributions to Principal Component 1')
%%







%%
idx = 1;

% This determines the number of steps
steps = size(vuln_breach{1,1},1);
%vuln_size = size(cell2mat(vuln_breach(1,idx)),2);

vuln_size = size(cell2mat(e_thresholds_daily{1,1}(idx,1)),2);
temp = vuln_breach{1,1};
vuln_exploit_input = cell(steps,1);
for i = 1:steps
    if isempty(cell2mat(temp(i,1))) == 0
        %vuln_input{i,1} = e_thresholds_daily{1,1}{1,1};
        vuln_exploit_input{i,1} = cell2mat(vuln_breach{1,1}(i,idx));

    end
 end
%% Remove the empty cells

vuln_exploit_input = vuln_exploit_input(~cellfun('isempty',vuln_exploit_input));
%% Convert to double array
vuln_exploit_input = toArray(vuln_exploit_input,vuln_size);
%%

steps = size(vuln_controls,1);
vuln_size = size(cell2mat(e_thresholds_daily(idx,1)),2);

input_score = vuln_controls;
for i = 1:steps
    if isempty(cell2mat(input_score(i,1))) == 0
        %vuln_input{i,1} = e_thresholds_daily{1,1}{1,1};
        input_score{i,1} = e_thresholds_daily{idx,1};
        input_binary{i,1} = vuln_controls{i,idx};

    end
 end
%% Remove the empty cells

input_binary = input_binary(~cellfun('isempty',input_binary));
%% Convert to double array
input_binary = toArray(input_binary,vuln_size);
%%
rand(1,5,[0 .025])
%%
threat_size = 4;
% = zeros(agent_compliance_size,threat_size);
click_rate_final = zeros(agent_compliance_size,threat_size);
temp = zeros (observation_size,threat_size);%size(observation_size, agent_compliance_size);

%% Calculate the average for 70% compliance
for i = 1: observation_size
    temp(i,:) = toArray(click_percent_step_mean(i,3),threat_size);
end
click_rate_final(3,:) = mean(temp);
%%

mean(click_rate_final(3,:),2)
%% labels
agent_idx = [];
vuln_exploits_merged = [];
for i = 1: 10
    for j = 1: 50
        [temp] = create_output(vuln_exploits{i,j}(:,1), e_thresholds_daily{1,j}, activity_idx);
        temp2 = i*ones(size(temp,1),1);
        vuln_exploits_merged = [vuln_exploits_merged;temp];
        agent_idx = [agent_idx; temp2];
    end
end
%% Determine the index for all rows with exploits
idx = 1;
step_size = size(vuln_exploits{1,1},1);
%exploit_idx = cell(step_size,vuln_size);
exploit_idx = zeros(step_size,1);
vuln_size = size(e_thresholds_daily{1,1}{idx,1},2);
for i = 1: step_size % Step
    if isempty(vuln_exploits{1,1}{i,idx}) == 0
        for j = 1: vuln_size 
            if vuln_exploits{1,1}{i,idx}(1,j) == 1
                exploit_idx(i,1) = i; 
            end
        end

    end
end
%% Remove empty rows
exploit_idx( ~any(exploit_idx,2), : ) = [];
%% Determine exploit index
idx = 1;
for i = 1: a_size
    for j = 1:days
        exploit_idx{i,j} = Determine_exploit_idx(vuln_exploits{i,j},e_thresholds_daily{1,1},idx);
    end
end

%%


%% Select input rows based on exploits
%{
exploit_size = size(exploit_idx{1,1},1);
vuln_size = size(e_thresholds_daily{1,1}{idx,1},2);
for i = 1:exploit_size
    temp = exploit_idx{1,1}(i,1);
    input_control_temp(i,:) = cell2mat(e_thresholds_daily{1,1}(idx,:));
    input_binary_temp(i,:) = cell2mat(vuln_exploits{1,1}(temp,:));
end
%}

%% Merge input
input_control_temp = cell(a_size,days);
input_binary_temp = cell(a_size, days);
idx =1;

for i = 1: a_size
    for j = 1:days
        [input_control_temp{i,j},input_binary_temp{i,j}] = merge_input(exploit_idx{i,j}, e_thresholds_daily{1,1}, vuln_exploits{i,j}, idx);
    end
end
%%
input_control = [];
input_binary = [];
for i = 1: a_size
    for j = 1:days
        input_control = [input_control; cell2mat(input_binary_temp(i,j))];
        input_binary = [input_binary; cell2mat(input_control_temp(i,j))];
        temp = [];
        temp2 = [];
    end
end

%% Determine the label
% This determines labels for each instance based on the number of failed
% controls (breaches)
limit = 3;
temp = sum(output_label,2);
label_temp = zeros(size(output_label,1),1);

for i = 1: size(output_label,1)
    if temp(i,1) == limit || temp(i,1) > limit
           label_temp(i,1) = 1;
    end
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
%%
idx = 1;
[input_data, label_final,click_rate_final(1,idx) ] = predict_breach(vuln_controls,e_thresholds_daily, people, idx,incident_threshold, limit, reference);
%%
exploit_size = size(exploit_idx,1);

for i = 1:exploit_size
    temp = exploit_idx(i,1);
    
    %input_control_temp(i,:) = cell2mat(e_thresholds_daily(idx,:));
    %input_binary_temp(i,:) = cell2mat(vuln_controls(temp,:));
    %output_label_temp(i,:) = cell2mat(vuln_exploits(temp,:));

    if isempty(cell2mat(vuln_controls{i,temp}(:,idx)))== 0
        input_binary_temp(i,:) = cell2mat(vuln_controls(temp,:));
    else
        input_binary_temp(i,:) = cell2mat(e_thresholds_daily(idx,:));
    end

   if isempty(cell2mat(vuln_exploits{i,temp}(:,idx)))== 0
        input_binary_temp(i,:) = cell2mat(vuln_exploits(temp,:));
    else
        input_binary_temp(i,:) = zeros(1,size(e_thresholds_daily{1,1}{idx,1}(1,:),2));
    end
end
%%

exploit_size = size(exploit_idx,1);

for i = 1:exploit_size
    temp = exploit_idx(i,1);
    
    A = e_thresholds_daily{1,1}{idx,1}(1,:);
    B = cell2mat(vuln_controls(temp,:));
    %input_binary_temp(i,:) = cell2mat(vuln_controls(temp,:));
    %output_label_temp(i,:) = cell2mat(vuln_exploits(temp,:));

%{
     if isempty(cell2mat(vuln_controls(temp,:)))== 0
        input_binary_temp(i,:) = cell2mat(vuln_controls(temp,:));
    else
        input_binary_temp(i,:) = e_thresholds_daily{1,1}{idx,1}(1,:);
    end

   if isempty(cell2mat(vuln_exploits(temp,:)))== 0
        input_binary_temp(i,:) = cell2mat(vuln_exploits(temp,:));
   else
        input_binary_temp(i,:) = zeros(1,size(e_thresholds_daily{1,1}{idx,1}(1,:),2));
   end
%}
end
%%
temp = 1; 
A = 0;
if isempty(cell2mat(vuln_controls{1,1}{temp,1}))== 0
        %input_binary_temp(i,:) = cell2mat(vuln_controls(temp,:));
        A = 1;
    else
        input_binary_temp{2,34} = e_thresholds_daily{1,1}{idx,1}(1,:);
        A =2;
 end
%%
idx = 2; 
A = 0;
if isempty(cell2mat(vuln_controls{1,27}(:,idx)))==1
    input_control_temp{1,27} = e_thresholds_daily{1,1}{idx,1}(1,:);
    input_binary_temp{1,27} = zeros(1,size(e_thresholds_daily{1,1}{idx,1}(1,:),2));
    output_label_temp{1,27} = zeros(1,size(e_thresholds_daily{1,1}{idx,1}(1,:),2));
end
%%

for i = 1: a_size
    for j = 1: days
        if isempty(cell2mat(vuln_controls{i,j}(:,idx)))==1
            vuln_controls{1,1}(i,idx) = e_thresholds_daily{1,1}{idx,1}(1,:);
            %input_control_temp{i,j} = e_thresholds_daily{1,1}{idx,1}(1,:);
            %input_binary_temp{i,j} = zeros(1,size(e_thresholds_daily{1,1}{idx,1}(1,:),2));
            %output_label_temp{i,j} = zeros(1,size(e_thresholds_daily{1,1}{idx,1}(1,:),2));
        end
    end
end
%%
isempty(cell2mat(vuln_controls{1,29}(:,idx)))
%%
for i = 1:a_size_total
    temp(i,:) = people{i,3}(1,:);
end

average = mean(temp,1);
%%
report_rate = (report_email_total./checked_email_total);
%%
for i = 1: size(report_rate,2)
    if isnan(report_rate(1,i))==1
        report_rate(1,i) = 0;
    end
end
%%
report_rate = (report_email_total./checked_email_total);
%%

data = exploit_sum2;
% Count unique values
[uniqueVals, ~, idx] = unique(data);
counts = accumarray(idx, 1);

% Sort by frequency (descending)
[countsSorted, sortIdx] = sort(counts, 'descend');
mostFrequent = uniqueVals(sortIdx);

% Display
disp(table(mostFrequent, countsSorted))
%%
Y = tsne(input_data);
%%
gscatter(Y(:,1),Y(:,2),label_final)
%% 3D
Y_tsne = tsne(input_data, 'NumDimensions', 3);

scatter3(Y_tsne(:,1), Y_tsne(:,2), Y_tsne(:,3), 36, label_final, 'filled');
xlabel('t-SNE 1'); ylabel('t-SNE 2'); zlabel('t-SNE 3');
title('3D t-SNE Visualization');
grid on;
view(45, 25);  % Adjust view angle
%% Merge activity
activity = [activity_1, activity_2, activity_3, activity_4];
%% Scenario 1: Trial 1 (Graph Activity points)
click_size = size(agent_click,2);
agent_comp = [60, 65, 70, 75, 80, 85, 90, 95];

%for i = 1:click_size
    plot(agent_comp',activity(:,1), "red");
    hold on
    plot(agent_comp',activity(:,2), "blue");
    hold on
    plot(agent_comp',activity(:,3), "green");
    hold on
    plot(agent_comp',activity(:,4), "black");
    hold on
%end
title("Agent Click Rate  (All Activities)")
xlabel('Agent Compliance')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Checking Email', 'Web-Surfing', 'Mobile Phone')
hold off
%%
 %% This section determines the amount of breaches by the day
[incident_day,~] = determine_by_day(exploit_total,days,1);
%%
control_size = [15;17;13;13,;0];
%%
cell2mat(mc_count_day(1,1)).*control_size(:,1)';
%% Calculates the incident opportunity per day
incident_opportunity_per_day = cell(1,days);
control_size = [15;17;13;13;0];
for i = 1: days
    incident_opportunity_per_day{1,i} = sum(cell2mat(mc_count_day(1,i)).*control_size(:,1)',1);
end
%% Calculate the exploits per day
exploit_per_day = cell(1,days);
temp = cell(1,threat_size);
for i = 1: days
    for j = 1:a_size
        temp = toArray(exploit_total(j,i),threat_size);
        exploit_per_day{1,i} = [cell2mat(exploit_per_day(1,i));temp];
    end
    exploit_per_day{1,i} = sum(exploit_per_day{1,i},1);
end

%% removes the last action
for i = 1: days
    temp = incident_opportunity_per_day{1,i}(1,5);
    temp(5)=[];
    incident_opportunity_per_day{1,i} = temp;
end

%% Calculate the daily click rate
daily_click_rate= cell(1,threat_size);
for i = 1: days
   daily_click_rate{1,i} = cell2mat(exploit_per_day(1,i))./cell2mat(incident_opportunity_per_day(1,i));
end

%% Stack the clickrate
total_click_rate = [];
temp = [];
for i = 1: days
    temp= cell2mat(daily_click_rate(1,i));
    total_click_rate = [total_click_rate; temp];
end


%% Plots daily click rate
n = 1:days;
for i = 1:days
    plot(n',total_click_rate(:,1), "red");
    hold on
    plot(n',total_click_rate(:,2), "blue");
    hold on
    plot(n',total_click_rate(:,3), "green");
    hold on
    plot(n',total_click_rate(:,4), "black");
    hold on
end
title("Daily Agent Click Rate  (50 days)")
xlabel('Days')
ylabel('Click Rate Percentage')
set(gcf, 'Name', 'By the Agent click Rate')
legend('Messenger','Checking Email', 'Web-Surfing', 'Mobile Phone')
hold off
%% This section determines the amount of breaches by the agent
%by_agent_forward
[by_agent_sum, by_agent_graph] = determine_by_agent(exploit_total, a_size,1);

%% Setting the seed
rng("default");
%% Trained the model based on exported model
cvmodel = crossval(trainedModel_SVM.ClassificationSVM, 'KFold', 5);
%% Obtain error rate
error_fold = kfoldLoss(cvmodel, Mode = 'individual', LossFun = 'classiferror');
%%
%save("std_results_acc.mat")
std_acc = cell(16,1);

%%
vars = who;
Acc_A1 = cell(size(vars));
for i = 1:length(vars)
    Acc_A1{i} = eval(vars{i});
end

%% Accuracy StD
clear;
load std_results_acc_A1.mat;
%% Load workspace
vars = who;
Acc_A1 = cell(size(vars));
for i = 1:length(vars)
    Acc_A1{i} = eval(vars{i});
end
%%
[std_per_fold] = determine_std_SVM(A1_SVM1)
%% Setting the seed
rng("default");
%% Trained the model based on exported model
cvmodel = crossval(trainedModel_SVM.ClassificationSVM, 'KFold', 5);
%% Obtain error rate
error_fold = kfoldLoss(cvmodel, Mode = 'individual', LossFun = 'classiferror');
%%
std_per_fold = std(error_fold);
%%
%{
for i = 1:size(temp,1)
    acc_svm{i,1} = determine_std(cell2mat(temp(i,1)), x);
end
%}
