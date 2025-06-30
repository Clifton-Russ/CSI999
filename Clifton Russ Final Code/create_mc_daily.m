function [daily, mc_daily] = create_mc_daily(actions_initial,days)

daily = cell(1,days);
mc_daily = cell(1,days);

for i = 1: days
    daily{1,i} = create_action_baseline(actions_initial);
    mc_daily{1,i} = create_mc_baseline(daily{1,i});
end


end