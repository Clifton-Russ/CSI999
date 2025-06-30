function [output] = create_output(vuln_exploits, e_thresholds_daily,idx)

% This determines the number of steps
steps = size(vuln_exploits,1);
exploit_size = size(cell2mat(e_thresholds_daily(idx,1)),2);

output = vuln_exploits;
for i = 1:steps
    if isempty(cell2mat(output(i,1))) == 0
        %vuln_input{i,1} = e_thresholds_daily{1,1}{1,1};
        output{i,1} = vuln_exploits{idx,1};
    end
 end
%% Remove the empty cells

output = output(~cellfun('isempty',output));
%% Convert to double array
output = toArray(output,exploit_size);
end