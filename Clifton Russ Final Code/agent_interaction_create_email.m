function [agent_email,phish_selected] = agent_interaction_create_email()


email_population = randi([20 120],1,1);
phish_population = randi([4,7],1,1);
% This creates the email

agent_email = zeros(1,email_population);

%% Select the phishing email
phish_selected = randi([20 email_population],1,phish_population);

%% Assignd the email as phishing

    for j = 1:phish_population
        agent_email(1,phish_selected(1,j)) = 1;
    end


end