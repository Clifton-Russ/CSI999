function [days,outputArg2] = determine_days(a_incidents, count,inputArg2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%

a_incidents = cell(a_size,a_vuln_size);

xmin = 0;
xmax = 1;
absent= xmin + (xmax-xmin).*rand(1,1);

days = zeros(count, 1);

for i = 1: count
    if absent > .9
        days(i,1) = 0;
    end
end

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end