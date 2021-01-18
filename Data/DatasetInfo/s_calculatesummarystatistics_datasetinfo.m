function s_calculatesummarystatistics_datasetinfo

% Calculate statistical summary statistics for participants's information. This
% script aims to reproduce information in a following paper: 
%
% Amemiya, K., Naito, E. & Takemura, H. (2021)
%  Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. In revision.
%
% This codes use functions derived from this repository (by Jason Yeatman): https://github.com/jyeatman/lifespan
%
% Hiromasa Takemura, NICT CiNet BIT

load DatasetInformation.mat

% Summary statistics in each group
mean_age(1) = mean(age.CH);
mean_age(2) = mean(age.ADO);
mean_age(3) = mean(age.ADU);
mean_age(4) = mean(age.SEN);

% Range of age in each group
range_age(1,1) = min(age.CH);
range_age(1,2) = max(age.CH);
range_age(2,1) = min(age.ADO);
range_age(2,2) = max(age.ADO);
range_age(3,1) = min(age.ADU);
range_age(3,2) = max(age.ADU);
range_age(4,1) = min(age.SEN);
range_age(4,2) = max(age.SEN);

% Count male/female participant in each group
malefemale_count(1,1) = length(find(sex.CH == 1));
malefemale_count(1,2) = length(find(sex.CH == 2));
malefemale_count(2,1) = length(find(sex.ADO == 1));
malefemale_count(2,2) = length(find(sex.ADO == 2));
malefemale_count(3,1) = length(find(sex.ADU == 1));
malefemale_count(3,2) = length(find(sex.ADU == 2));
malefemale_count(4,1) = length(find(sex.SEN == 1));
malefemale_count(4,2) = length(find(sex.SEN == 2));

% Count left/right handers
handedness_count(1,1) = length(find(handedness.CH == 1));
handedness_count(1,2) = length(find(handedness.CH == 2));
handedness_count(2,1) = length(find(handedness.ADO == 1));
handedness_count(2,2) = length(find(handedness.ADO == 2));
handedness_count(3,1) = length(find(handedness.ADU == 1));
handedness_count(3,2) = length(find(handedness.ADU == 2));
handedness_count(4,1) = length(find(handedness.SEN == 1));
handedness_count(4,2) = length(find(handedness.SEN == 2));

% Calculcate summary statistics for age subgroups
adosubgroup_index = find(age.ADO > 11);
age_mean_adosubgroup = mean(age.ADO(adosubgroup_index));
malefemale_adosubgroup(1) = length(find(sex.ADO(adosubgroup_index) == 1));
malefemale_adosubgroup(2) = length(find(sex.ADO(adosubgroup_index) == 2));

sensubgroup_index_1 = find(age.SEN < 63);
sensubgroup_index_2 = find(age.SEN > 63);

age_mean_sensubgroup(1) = mean(age.SEN(sensubgroup_index_1));
age_mean_sensubgroup(2) = mean(age.SEN(sensubgroup_index_2));
malefemale_sensubgroup(1,1) = length(find(sex.SEN(sensubgroup_index_1)==1));
malefemale_sensubgroup(1,2) = length(find(sex.SEN(sensubgroup_index_1)==2));
malefemale_sensubgroup(2,1) = length(find(sex.SEN(sensubgroup_index_2)==1));
malefemale_sensubgroup(2,2) = length(find(sex.SEN(sensubgroup_index_2)==2));