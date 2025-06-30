function [transition_matrix] = create_transition_matrix(actions_baseline,m,n)


% This determines creates a transition matrix from the initial actions
temp = sum(actions_baseline,2); % caluclates the sum
transition_data = 0;
for i = 1: size(actions_baseline,2)
    temp = i* ones(1,actions_baseline(1,i));
    transition_data = [transition_data, temp];
end

transition_data = nonzeros(transition_data);
%% Shuffle the transition data
%transition_data = randperm(transition_data);
transition_data=transition_data(randperm(length(transition_data)));
     

transition_matrix = 0;
temp = sum(actions_baseline,2);
for j = 1:size(temp,2)
    for k = 1:temp(j,1) %sum(temp,2)
        if k < temp(j,1) %sum(temp,2)
            if transition_data(k,1) == m && transition_data(k+1,1) == n
                transition_matrix(1,1) = transition_matrix(1,1) + 1;
            end
        end
    end
end


end