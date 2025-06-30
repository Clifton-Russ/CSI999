function [a_incidents, incident_input] = determine_incident3(agent_compliance,vuln_input_activity)
%% Determine the size of the thresholds for each control

e_size = size(vuln_input_activity,2);
temp = 1-agent_compliance;

agent_threat_average = temp*2;
incident_input = cell(e_size,2);
a_incidents = zeros(1,e_size);% preallocate
%% This removes the count for controls.
 for j = 1:e_size % number of incident type
      if agent_threat_average > vuln_input_activity(1,j) 
             a_incidents(1,j) = 1;
             incident_input{j,1} = vuln_input_activity(1,:);
       end
 end
    
 end