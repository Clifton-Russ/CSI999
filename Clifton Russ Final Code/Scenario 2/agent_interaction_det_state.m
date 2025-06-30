% This class is for agent interaction
function [c_family_incident, vuln_scores, c_family_input, checked_email, reported_email] = agent_interaction_det_state(agent_compliance_average, mc_baseline,e_thresholds_daily,vuln_idx, agent_email)
%% This determines which e_threshold data to use based on the current state
mc_size = size(mc_baseline,1);

vuln_input = cell(mc_size,1);
vuln_scores = cell(mc_size,1);

c_family_incident = cell(mc_size,1);
c_family_incident(:) = {0};

c_family_input = cell(mc_size,1);
c_family_input(:) = {0};
email_index = 0;
checked_email = cell(mc_size,1);
checked_email(:) = {0};

reported_email = cell(mc_size,1);
reported_email(:) = {0};

%% Combine control attributes
%for loop determines if there is an incident        
for i = 1:mc_size

email_number = randi([1 5],1,1); % selects the number of emails
email_index = email_index + email_number;

    %This determines incidents related to the controls within the 1st step
    if mc_baseline(i,1) == 1 
        
       
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
        
        [c_family_incident{i,1},c_family_input{i,1}, email_index,checked_email{i,1},reported_email{i,1}] = ...
            agent_interaction_det_incident(agent_compliance_average,e_thresholds_daily{1,1}(1,:), email_index, agent_email);
    
        vuln_input{i,1} = e_thresholds_daily{1,1}(1,vuln_idx);
        vuln_scores{i,1} = c_family_incident{i,1};
        %vuln_scores{temp_index,1} = c_family_incident{i,1};
        %temp_index = temp_index +1;
    %This determines incidents related to the controls within the 2nd step
    end
    %{
    elseif mc_baseline(i,1) == 2 
       
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
    
         [c_family_incident{i,2}, c_family_input{i,2}] = agent_interaction_det_incident(agent_compliance_average,e_thresholds_daily{2,1}(1,:));
  
        
        vuln_input{i,1} = e_thresholds_daily{2,1}(1,vuln_idx);

    %This determines incidents related to the controls within the 3rd step
    elseif mc_baseline(i,1) == 3 
       
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent

        [c_family_incident{i,3}, c_family_input{i,3}] = agent_interaction_det_incident(agent_compliance_average,e_thresholds_daily{3,1}(1,:));
    
      
        vuln_input{i,1} = e_thresholds_daily{3,1}(1,vuln_idx);
 
     %This determines incidents related to the controls within the 4th step
    elseif mc_baseline(i,1) == 4 % 
       
    
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
        
        [c_family_incident{i,4}, c_family_input{i,4}] = agent_interaction_det_incident(agent_compliance_average,e_thresholds_daily{4,1}(1,:));
    
        vuln_input{i,1} = e_thresholds_daily{4,1}(1,vuln_idx);
  
    end
    %}
end

end