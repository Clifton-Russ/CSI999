  %This function determines whether an incident is a breach by comparing the
%incident ratio with the predefined success threshold. If the count exceeds
%the threshold, then a breach has occurred. This means that for any given
%number of controls, the person was able to circumvent that many controls.
%The more controls the person is able to circumvent, the more likely the
%person will have a breach
function [a_breach, a_breach_total, click_forward, second_click] = determine_breach2(vuln_incident_total,incident_threshold)

% the incident threshold is a percent. Creates a forloop where threshold is
% compared to random number
actions_size = size(vuln_incident_total,2);% 4


a_breach = cell(1,actions_size);
a_breach_total = zeros(1,actions_size);
click_forward = 0;
second_click = 0;
for i = 1:actions_size 
    for j = 1: vuln_incident_total(i) 
        %The temp is used to determine the likelihood of the breach
        %occurring.
        temp = rand(1,1);

        %percent of a breach incident_threshold(1,i)
        if temp < incident_threshold 
            a_breach{1,i}(1,j) = 1; 
                a_breach_total(1,i) = a_breach_total(1,i) +1 ;
                temp2 = rand(1,1);
                if temp2 < .01
                    click_forward = click_forward +1;

                    if temp < incident_threshold
                        second_click = second_click +1;
                    end
                end
        else
            a_breach{1,i}(1,j) = 0;
        end
    end
    %a_breach_total{1,1}(1,i) = sum(a_breach{1,i}(1,:),2);
end


end