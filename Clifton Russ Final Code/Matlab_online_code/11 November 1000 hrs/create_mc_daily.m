function [daily, mc_daily] = create_mc_daily(actions_initial,days)
%mc_size = size(actions_initial,1);
daily = cell(1,days);
mc_daily = cell(1,days);

for i = 1: days
    daily{1,i} = create_action_baseline(actions_initial);
    mc_daily{1,i} = create_mc_baseline(daily{1,i});
end


%action_size = size(mc_baseline{1,1},2);

%{
mc_day = cell(mc_size,action_size);
mc_daily = cell(mc_size,1);

%mc_daily = cell(action_size,action_size);
%mc_daily = {mc_size,action_size};
%mc_daily = [mc_baseline,mc_daily];


for k = 1:days
    for i = 1: mc_size
        for j = 1:action_size   
            min = mc_baseline{i,1}(1,j)-(.1*mc_baseline{i,1}(1,j));
            max = mc_baseline{i,1}(1,j)+(.1*mc_baseline{i,1}(1,j));
            mc_day{i,j} = round(min + (max-min).*rand(1,1));
            mc_daily{i,k} = [mc_day{i,:}];
        end
    end
end
%}

end