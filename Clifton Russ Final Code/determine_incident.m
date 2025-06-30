function [a_incidents, incident_input] = determine_incident(agent_compliance_average,e_thresholds_daily,modifier)
%% Determine the size of the thresholds for each control
%modifier = 2;
e_size = size(e_thresholds_daily,2);
temp = 1-agent_compliance_average;

agent_threat_average = temp*modifier;
incident_input = cell(e_size,2);
a_incidents = zeros(1,e_size);% preallocate
%% This removes the count for controls.
 for j = 1:e_size % number of incident type
      if agent_threat_average > e_thresholds_daily(1,j) 
             a_incidents(1,j) = 1;
             incident_input{j,1} = e_thresholds_daily(1,:);
       end
 end
    
 end