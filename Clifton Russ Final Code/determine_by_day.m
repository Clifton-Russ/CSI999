function [by_day_sum,by_day_graph] = determine_by_day(vuln_breach_total,days, type)
% This summarizes all the incidents within by the day
by_day_sum = zeros(1,days);
for i = 1: days
    by_day_sum(1,i) = sum([vuln_breach_total{:,i}]);
end

if type == 1

by_day_graph = bar(by_day_sum);
title("Total Clicks by the day (" + days + " days)")
xlabel('Days')
ylabel('Clicks')

set(gcf, 'Name', 'By the Day')
end

if type == 2

by_day_graph = bar(by_day_sum);
title("Total breaches by the day (" + days + " days)")
xlabel('Days')
ylabel('Breaches')

set(gcf, 'Name', 'By the Day')
end
end