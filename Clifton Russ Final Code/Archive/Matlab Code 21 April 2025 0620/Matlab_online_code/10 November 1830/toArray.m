function [temp] = toArray(array_incident,array_size)
% this function extracts the values from the cells and places them into an
% array
a_size = size(array_incident,1);
%vuln_size = size(incident_array,2);
temp = zeros(a_size,array_size);
for i = 1:a_size
    temp(i,:) = array_incident{i,:};
end

end