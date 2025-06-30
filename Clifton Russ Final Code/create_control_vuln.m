function [ctrl_temp] = create_control_vuln(attribute_selection, control_size)

% This creates and holds the environment compliance controls for each day.
% Each day, each control can vary up to +/-15%. This simulates the subtle
% changes a control compliance can change daily.
ctrl_temp = zeros(1,control_size); % environment thresholds
for i = 1: control_size   
        min = attribute_selection{1,1}(1,i)-(.15*attribute_selection{1,1}(1,i));
        max = attribute_selection{1,1}(1,i)+(.15*attribute_selection{1,1}(1,i));
        ctrl_temp(1,i) = min + (max-min).*rand(1,1);
end



end