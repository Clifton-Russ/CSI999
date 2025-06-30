function [a_incidents, incident_input, email_index, checked_email, report_email] = agent_interaction_det_incident(agent_compliance_average,e_thresholds_daily, email_index, agent_email)
%% Determine the size of the thresholds for each control

e_size = size(e_thresholds_daily,2);
temp = 1-agent_compliance_average;

agent_threat_average = temp*2;
incident_input = cell(e_size,2);
a_incidents = zeros(1,e_size);% preallocate
email_number = randi([1 5],1,1);
checked_email = 0;
report_email = 0;
%% This removes the count for controls.
 for j = 1:e_size % number of incident type
      if agent_threat_average > e_thresholds_daily(1,j) 
             a_incidents(1,j) = 1;
             incident_input{j,1} = e_thresholds_daily(1,:);
             %incident_input{j,2} = j;

     if email_index + email_number < size(agent_email{1,1}(1,:),2)
             for i = email_index: email_index + email_number %email_index
                if agent_email{1,1}(1,i) == 0 %1
                    checked_email = checked_email +1;
                    temp = rand(1,1);
                        if temp < .70 % 70% chance of reporting phishing
                            report_email = report_email +1;
                        end
                end
             end
     end


       end
 end
    
 end