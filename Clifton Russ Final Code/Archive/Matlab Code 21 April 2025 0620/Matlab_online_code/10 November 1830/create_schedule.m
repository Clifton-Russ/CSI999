function [schedule] = create_schedule(mc_baseline)
   % This function takes in the queued actions from an agent and then
   % prunes the schedule based on an 8 hour work schedule with a 30 minute
   % lunch break. Each agent starts their workday between 5 am and 9 am (on
   % the hour) and has a 30 minute lunch break after approximately 4 hours
   % of work. 
   
   %mc_size= size(cell2mat(mc_baseline(1,1)),1);
   
  mc_size= size(mc_baseline,1);

  schedule = cell(mc_size,4);
temp = randi([5,9],1,1);
work_start = duration(hours(temp),'format','hh:mm');

execution = 0;% The time spent on an action
time_worked = 0;% The cumulative time spent working
lunch_minutes = 0;
lunch_time = 0;% The time the agent ate lunch
lunch = 0;
for i = 1:mc_size
    if time_worked < 510
    if mc_baseline(i,1) == 1
       % The first action is calculated from 1 to 6 tics, with each tic
       % representing 5 minutes. 
       temp = randi([1,6],1,1); 
       execution = 5*temp;
       
    elseif mc_baseline(i,1) == 2
       % The second action is calculated from 1 to 4 tics, with each tic
       % representing 5 minutes.        
        temp = randi([1,4],1,1);
        execution = 5*temp;
       
    elseif mc_baseline(i,1) == 3
       % The third action is calculated from 1 to 2 tics, with each tic
       % representing 5 minutes. 
        
        temp = randi([1,2],1,1);
        execution = 5*temp;
      
    else        
       % The fourth action is calculated from 1 to 3 tics, with each tic
       % representing 5 minutes.
        
        temp = randi([1,3],1,1);
        execution = 5*temp;
      
    end
  
    schedule{i,2} = time_worked; 
    schedule{i,3} = mc_baseline(i,1);% the action
    schedule{i,4} = execution;% the amount of time

    % checks to see if the agent is within the lunch window
    if time_worked >= 240 && time_worked <= 270 && lunch == 0
        execution = 30;
        lunch_minutes = time_worked;
        temp = duration(hours(lunch_minutes/60),'format','hh:mm');
        lunch_time = work_start + temp; 
        schedule{i,3} = 'Lunch' ;% identifies the agent's lunch
        schedule{i,4} = execution;
        lunch = 1;
    end
time_worked = time_worked + execution;

% Checks for the first iteration. The first step uses the start work time 
if i == 1
    schedule{i,1} = work_start;
else
  temp = duration(hours(schedule{i-1,4}/60), 'format','hh:mm');
  temp2 = hours(schedule{i-1,1} + temp);
  
    schedule{i,1} = duration(hours(temp2),'format','hh:mm');
end

    end
% calculating the end of the day
temp = duration(hours(time_worked/60),'format','hh:mm');
work_end = work_start + temp;
end


schedule= schedule(~all(cellfun(@isempty,schedule),2),:);
end