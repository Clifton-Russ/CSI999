%% Loads Precision models
%save("std_results_Precision.mat")
load std_results_Precision.mat;

%% This collects all the NB models for Precision Scores
precision_NB = cell(3,4);
temp = {A1_NB1, A2_NB1, A3_NB1, A4_NB1; ...
        A1_NB2, A2_NB2, A3_NB2, A4_NB2; ...
        A1_PCA_NB, A2_PCA_NB, A3_PCA_NB, A4_PCA_NB};

% For loop to determine std for NB (Precision scores) 
x = "ClassificationNaiveBayes";

for i = 1:size(temp,1)
    for j = 1:size(temp,2)
        precision_NB{i,j} = determine_std(cell2mat(temp(i,j)), x);
    end
end

%% This collects all the SVM models for Precision Scores
precision_SVM = cell(3,4);
temp = {A1_SVM1, A2_SVM1, A3_SVM1, A4_SVM1; ...
        A1_SVM2, A2_SVM2, A3_SVM2, A4_SVM2; ...
        A1_PCA_SVM, A2_PCA_SVM, A3_PCA_SVM, A4_PCA_SVM};

% For loop to determine std for SVM (Precision Scores) 
x = "ClassificationSVM";

for i = 1:size(temp,1)
    for j = 1:size(temp,2)
        precision_SVM{i,j} = determine_std(cell2mat(temp(i,j)), x);
    end
end

%% This collects all the KNN models for Precision Scores
precision_KNN = cell(4,4);
temp = {A1_KNN1, A2_KNN1, A3_KNN1, A4_KNN1; ...
        A1_KNN2, A2_KNN2, A3_KNN2, A4_KNN2; ...
        A1_KNN2, A2_KNN2, A3_KNN2, A4_KNN2; ...
        A1_PCA_KNN, A2_PCA_KNN, A3_PCA_KNN, A4_PCA_KNN};

% For loop to determine std for KNN (Accuracy) 
x = "ClassificationKNN";

for i = 1:size(temp,1)
    for j = 1:size(temp,2)
        precision_KNN{i,j} = determine_std(cell2mat(temp(i,j)), x);
    end
end

%% This collects all the ANN models for Precision Scores
precision_ANN = cell(6,4);
temp = {A1_ANN1, A2_ANN1, A3_ANN1, A4_ANN1; ...
        A1_ANN2, A2_ANN2, A3_ANN2, A4_ANN2; ...
        A1_ANN3, A2_ANN3, A3_ANN3, A4_ANN3; ...
        A1_ANN4, A2_ANN4, A3_ANN4, A4_ANN4; ...
        A1_ANN5, A2_ANN5, A3_ANN5, A4_ANN5;
        A1_PCA_ANN, A2_PCA_ANN, A3_PCA_ANN, A4_PCA_ANN};

% For loop to determine std for ANN (Accuracy) 
x = "ClassificationNeuralNetwork";

for i = 1:size(temp,1)
    for j = 1:size(temp,2)
        precision_ANN{i,j} = determine_std(cell2mat(temp(i,j)), x);
    end
end
