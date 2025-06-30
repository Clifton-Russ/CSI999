function [attribute_selection] = determine_attribute(org_compliance,failed_percent)
%This function determines the attribute selection values. The input values
 %determine the level of hardening. 

 %All: AT-1 | AT-2| AT-2(1)| AT-2(3) | AT-2(4) | AT-2(7) | AT-2(8) 
 %All: IA-2(13) | IA-12(5) | IA-12(6) | SC-15
 all_attributes = zeros(1,11);

 %Internet_email: SC-42 | CA-8(2) | CA-9
 internet_email_attributes = zeros(1,3);

 %Internet: CA-7(3)
 internet_attributes = zeros(1,1);

 %Email: AT-2(5) | AT-2(6) | AT-3
 email_attributes = zeros(1,3);

 %mobile:  SC-18 | SC-51
 mobile_attributes = zeros(1,2);

 %Internet/email/landline: SC-42 |CA-8(2)
 internet_email_landline_attributes = zeros(1,2);

%control_size(1,1) = 11; control_size(1,2) =

%% Check for compliance level

%Fully Compliance
if org_compliance == 1
     min = .8;
     max = .95;

% Average Compliance
elseif org_compliance == 2
     min = .7;
     max = .85;

elseif org_compliance == 3
    min = .55;
    max = .75;

elseif org_compliance == 4
    min = 0;
    max = .99;
end

%% Calculate the scores

all_attributes = min+rand(1,size(all_attributes,2))*(max-min);
internet_email_attributes = min+rand(1,size(internet_email_attributes,2))*(max-min);
internet_attributes = min+rand(1,size(internet_email_attributes,2))*(max-min);
email_attributes = min+rand(1,size(email_attributes,2))*(max-min);
mobile_attributes = min+rand(1,size(mobile_attributes,2))*(max-min);
internet_email_landline_attributes = min+rand(1,size(internet_email_landline_attributes,2))*(max-min);

%% Failed scores
%{
failed_percent = failed_percent/100;

% This outlines the failed scores for 'all_attributes'
temp = round(failed_percent*size(all_attributes,2));
r = randsample(all_attributes,temp);%select the controls to "fail"
r_index = zeros(1,temp);

%determines the initial index of the chosen controls
for i = 1:temp
    r_index(1,i) = find(abs(all_attributes-r(1,i)) < 0.001);
end

% replaces the initial control with the failed controls
for i = 1: temp 
    all_attributes(1,r_index(i)) = randi([0,55],1,1)/100;   
end

temp = round(failed_percent*size(internet_email_attributes,2));
temp = round(failed_percent*size(internet_attributes,2));
temp = round(failed_percent*size(email_attributes,2));
temp = round(failed_percent*size(mobile_attributes,2));
temp = round(failed_percent*size(Internet_email_landline_attributes,2));

%}
%% Combine controls to complete the attribute selection
% Internet Browsing 15 controls
attribute_selection{1,1} = [all_attributes,internet_email_attributes,internet_attributes];
% Email 17 controls
attribute_selection{2,1} = [all_attributes,internet_email_attributes,email_attributes];
% Mobile Phone 13 controls
attribute_selection{3,1} = [all_attributes, mobile_attributes];
% Landline Phone 13 controls
attribute_selection{4,1} = [all_attributes, internet_email_landline_attributes];
end
