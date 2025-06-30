function [adjusted_baseline, transition_matrix] = create_adjusted_baseline(actions_initial)
%This function takes the initial actions vector and creates additional
%vectors to create an nxn matrix to be later used for the Markov Chain

initial_size = size(actions_initial,2);

adjusted_baseline = zeros(1,initial_size);

for i = 1: initial_size   
     min = actions_initial(1,i)-(.1*actions_initial(1,i));
     max = actions_initial(1,i)+(.1*actions_initial(1,i));
     
    % This ensures that the new value is above zero 
    if min == 0 || min < 0
        min = .1; %actions_initial(1,i);
    end

    if max == 0 || max < 0
        max = .1;actions_initial(1,i);
    end
     adjusted_baseline(1,i) = round(min + (max-min).*rand(1,1));
            
end


%%
for i = 1:initial_size
    for j = 1:initial_size
        transition_matrix(i,j) = create_transition_matrix(adjusted_baseline,1,j);
    end
end
end