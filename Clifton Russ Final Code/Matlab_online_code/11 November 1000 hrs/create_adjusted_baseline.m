function [adjusted_baseline, transition_matrix] = create_adjusted_baseline(actions_initial)
%This function takes the initial actions vector and creates additional
%vectors to create an nxn matrix to be later used for the Markov Chain

initial_size = size(actions_initial,2);

adjusted_baseline = zeros(1,initial_size);
%{
for i = 1: initial_size
    for j = 1:initial_size   
         min = actions_initial(1,j)-(.1*actions_initial(1,j));
         max = actions_initial(1,j)+(.1*actions_initial(1,j));
         adjusted_baseline(i,j) = round(min + (max-min).*rand(1,1));
            
    end
end
%}

for i = 1: initial_size   
     min = actions_initial(1,i)-(.1*actions_initial(1,i));
     max = actions_initial(1,i)+(.1*actions_initial(1,i));
     adjusted_baseline(1,i) = round(min + (max-min).*rand(1,1));
            
end
%}

%%
%{
for i = 1:initial_size
    for j = 1:initial_size
        %if j < initial_size
            transition_matrix(i,j) = create_transition_matrix(actions_baseline,i,j);
        %end
    end
end
%}
for i = 1:initial_size
    for j = 1:initial_size
        %if j < initial_size
            transition_matrix(i,j) = create_transition_matrix(adjusted_baseline,1,j);
        %end
    end
end


end