%% Runs Scenario test_function v5
test_function_v5;
    %% Train against Activity 1
activity_idx = 1;
reference = 2;
limit = 3;
[input_data, label_final, exploit_sum] = predict_exploit(a_size, days,vuln_controls,vuln_exploits, e_thresholds_daily, activity_idx, limit, reference);

 %% Train against Activity 2
activity_idx = 2;
reference = 2;
limit = 3;
[input_data2, label_final2, exploit_sum2] = predict_exploit(a_size, days,vuln_controls,vuln_exploits, e_thresholds_daily, activity_idx, limit, reference);

 %% Train against Activity 3
activity_idx = 3;
reference = 2;
limit = 3;
[input_data3, label_final3, exploit_sum3] = predict_exploit(a_size, days,vuln_controls,vuln_exploits, e_thresholds_daily, activity_idx, limit, reference);

 %% Train against Activity 4
activity_idx = 4;
reference = 2;
limit = 3;
[input_data4, label_final4, exploit_sum4] = predict_exploit(a_size, days,vuln_controls,vuln_exploits, e_thresholds_daily, activity_idx, limit, reference);
%}
%% Finds the clickrate
%click_rate_final= click_rate_final*100;

%% Converts labels into Strings
label_size = size(label_final,1);
label_name = strings(label_size,1);

for i = 1: label_size
    if label_final(i) == 1
        label_name(i,1) = "Exploit";
    else
        label_name(i,1) = "No Exploit";
    end
end
%}
%   
%% convert shuffled_data to input data
    %input_data = shuffled_data;
%% PCA for Activity 1
%{
[coeff, score, latent, ~, explained] = pca(input_data);
%% Plot varaince for Activity 1 PCA
close all
pareto(explained);
xlabel('Principal Components');
ylabel('Variance Explained (%)');
title('Variance Explained by PCA Components');
%% PCA Component 1 vs Component 2
figure;
gscatter(score(:,1), score(:,2), label_name, 'grb', 'ox', 10);
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA: Component 1 vs Component 2');
grid on;
%% PCA Component 1 vs Component 3
figure;
gscatter(score(:,1), score(:,3), label_name, 'grb', 'ox', 10);
xlabel('Principal Component 1');
ylabel('Principal Component 3');
title('PCA: Component 1 vs Component 3');
grid on;
%% UMAP
addpath('G:\My Drive\School\George Mason\CSI 999 Disesertation\Matlab Code\umapFileExchange (4.4)\umap');
%% Plot UMAP
[reduced_data, umap] = run_umap(input_data, 'n_components', 2);
%% View Feature contributions
close all
bar(coeff(:,1))
xticks(1:size(input_data,2))
xlabel('Original Feature')
ylabel('Loading on PC1')
title('Feature Contributions to Principal Component 1')
%}