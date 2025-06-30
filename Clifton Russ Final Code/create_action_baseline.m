function [actions_baseline] = create_action_baseline(actions_initial)
%This function takes the initial actions vector and creates additional
%vectors to create an nxn matrix to be later used for the Markov Chain

initial_size = size(actions_initial,2);

actions_baseline = zeros(initial_size,initial_size);

for i = 1: initial_size
    for j = 1:initial_size   
         min = actions_initial(1,j)-(.1*actions_initial(1,j));
         max = actions_initial(1,j)+(.1*actions_initial(1,j));
         actions_baseline(i,j) = round(min + (max-min).*rand(1,1));
            
    end
end

end