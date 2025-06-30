  %This function determines whether an incident is a breach by comparing the
%incident ratio with the predefined success threshold. If the count exceeds
%the threshold, then a breach has occurred. This means that for any given
%number of controls, the person was able to circumvent that many controls.
%The more controls the person is able to circumvent, the more likely the
%person will have a breach
function [input_breach] = determine_breach3(vuln1_incidents,incident_threshold)

% the incident threshold is a percent. Creates a forloop where threshold is
% compared to random number
e_size = size(vuln1_incidents,2);
input_size = size(vuln1_incidents,1);

input_breach = zeros(input_size, e_size);
for i = 1:input_size 
    for j = 1: e_size 
        %The temp is used to determine the likelihood of the breach
        %occurring.
        temp = rand(1,1);
%

        %percent of a breach incident_threshold(1,i)
        if temp < incident_threshold 
            input_breach(i,j) = 1; 
                   
        else
            input_breach(i,j) = 0;
        end
    end
end


end