function [std_per_fold] = determine_std(trainedModel, x)
%This function determines the std

%% Setting the seed
rng("default");
%% Trained the model based on exported model
cvmodel = crossval(trainedModel.(x), 'KFold', 5);
%% Obtain error rate
error_fold = kfoldLoss(cvmodel, Mode = 'individual', LossFun = 'classiferror');
%%
std_per_fold = std(error_fold);

end