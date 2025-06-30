function [c_family_incident, vuln_scores, incident_input] = determine_state_vuln7(agent_compliance_average, mc_baseline,e_thresholds_daily,vuln_idx)
%% This determines which e_threshold data to use based on the current state
%c_family_input
mc_size = size(mc_baseline,1);

incident_input = cell(mc_size,1);
vuln_scores = cell(mc_size,1);
 
c_family_incident = cell(mc_size,1);
%c_family_incident(:) = {0};

c_family_input = cell(mc_size,1);
c_family_input(:) = {0};

%% Combine control attributes
%for loop determines if there is an incident        
for i = 1:mc_size

    %This determines incidents related to the controls within the 1st step
    if mc_baseline(i,1) == 1 
        
       modifier = 1.9;
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
        
        [c_family_incident{i,1},c_family_input{i,1}] = determine_incident(agent_compliance_average,e_thresholds_daily{1,1}(1,:), modifier);
            
       
        incident_input{i,1} = e_thresholds_daily{1,1}(1,vuln_idx);
        vuln_scores{i,1} = c_family_incident{i,1};
        
    %This determines incidents related to the controls within the 2nd step
    elseif mc_baseline(i,1) == 2 %
        modifier = 2.1;
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
    
         [c_family_incident{i,2}, c_family_input{i,2}] = determine_incident(agent_compliance_average,e_thresholds_daily{2,1}(1,:),modifier);

       
        incident_input{i,2} = e_thresholds_daily{2,1}(1,vuln_idx);

    %This determines incidents related to the controls within the 3rd step
    elseif mc_baseline(i,1) == 3 
       modifier = 2.2;

        [c_family_incident{i,3}, c_family_input{i,3}] = determine_incident(agent_compliance_average,e_thresholds_daily{3,1}(1,:), modifier);
       
        incident_input{i,3} = e_thresholds_daily{3,1}(1,vuln_idx);
 
     %This determines incidents related to the controls within the 4th step
    elseif mc_baseline(i,1) == 4 % 
    modifier = 1.8;
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
        
        [c_family_incident{i,4}, c_family_input{i,4}] = determine_incident(agent_compliance_average,e_thresholds_daily{4,1}(1,:), modifier);
       
        incident_input{i,4} = e_thresholds_daily{4,1}(1,vuln_idx);
  
      
     elseif mc_baseline(i,1) == 5 % 
       
    
         % This represents all the control scores for a specific
         % vulnerability at the first step. The vuln_idx represents the
         % vulnerability that is being tested against the agent
        
        c_family_incident{i,5} = [];
        c_family_input{i,5} = [];

        incident_input{i,5} = [];
  
    end
end

end