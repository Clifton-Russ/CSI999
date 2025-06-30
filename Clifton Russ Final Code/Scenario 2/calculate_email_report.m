function [checked_email, report_email] = calculate_email_report(vuln_incident_total,agent_email, phish_report_rate,actions_size)
%This method determines the number of phishing emails that were reported
% This forloop cycles through the emails, simulating the agent reading the
% emails in chronological order. This simulation only covers scenarios
% where the agent's threat level is higher than the control level. This
% represents a scenario where an agent opens an email with a higher chance
% of clicking the link.
report_email = zeros(1,actions_size);
checked_email = zeros(1,actions_size);
for i = 1: actions_size
    email_index = 1;
    for j = 1: vuln_incident_total(1,i)
    
        email_number = randi([1 5],1,1); % selects the number of emails
            if email_index + email_number < size(agent_email(1,:),2)
                for k = email_index: email_index +email_number
                    if agent_email(1,k) == 1
                        checked_email(1,i) = checked_email(1,i) +1;
                        temp = rand(1,1);
                            if temp < phish_report_rate % chance of reporting phishing
                                report_email(1,i) = report_email(1,i) +1;
                            end
                    end
                   
                end
                email_index = email_index +email_number;
            end
    end
end

end