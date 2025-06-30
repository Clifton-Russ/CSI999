function [input_control_temp,input_binary_temp,output_label_temp] = merge_input(exploit_idx, e_thresholds_daily,vuln_controls, vuln_exploits, idx)
% This function
exploit_size = size(exploit_idx,1);

for i = 1:exploit_size
    temp = exploit_idx(i,1);
    
    input_control_temp(i,:) = cell2mat(e_thresholds_daily(idx,:));
    input_binary_temp(i,:) = cell2mat(vuln_controls(temp,:));
    output_label_temp(i,:) = cell2mat(vuln_exploits(temp,:));


end