function [vuln_breach_total] = calculate_breach_total(vuln_breach,threat_size)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

step_size = size(vuln_breach,1);
vuln_breach_total = zeros(1,threat_size);


for i = 1:step_size
    for j = 1:threat_size
       if size(vuln_breach,2)>3

        temp = sum(cell2mat(vuln_breach(i,j)),2);
       

        if temp > 0
            vuln_breach_total(1,j) = vuln_breach_total(1,j) + temp; 
        end
       end
       
    end
end
end