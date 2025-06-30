function [input] = create_input(vuln_controls, e_thresholds_daily,idx)

% This determines the number of steps
steps = size(vuln_controls,1);
vuln_size = size(cell2mat(e_thresholds_daily(idx,1)),2);

input = vuln_controls;
for i = 1:steps
    if isempty(cell2mat(input(i,1))) == 0
        %vuln_input{i,1} = e_thresholds_daily{1,1}{1,1};
        input{i,1} = e_thresholds_daily{idx,1};
    end
 end
%% Remove the empty cells

input = input(~cellfun('isempty',input));
%% Convert to double array
input = toArray(input,vuln_size);
end