function [a_incidents,incident_input, a_exploit,a_exploit_total ] = determine_incident2(agent_threat,vuln_input_activity,activity_idx)
%% Determine the size of the thresholds for each control

e_size = size(vuln_input_activity,2);

incident_input = cell(e_size,2);
a_incidents = zeros(1,e_size);% preallocate
a_exploit = zeros(1,e_size);% preallocate
a_exploit_total = zeros(1,e_size);
%% This removes the count for controls.
 for j = 1:e_size % number of incident type
      
        
     if agent_threat > vuln_input_activity(1,j)
         a_incidents(1,j) = 1;
         incident_input{j,1} = vuln_input_activity(1,:);
         
         
         temp = agent_threat/(agent_threat+vuln_input_activity(1,j));
         
        
         if temp  > .50
         %temp = rand(1,1);
         %if temp  < .20 %.043 
            a_exploit(1,j) = 1;
            a_exploit_total(1,activity_idx) = a_exploit_total(1,activity_idx) +1 ;
         end
  
     end


 end
    
 end