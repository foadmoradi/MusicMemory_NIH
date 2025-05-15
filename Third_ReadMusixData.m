% % clear;clc;close all;
%%Clean Musician datasets.
dd=readtable('MusicActivityClean.xlsx');
% Find the unique IDs and their row indexes
[unique_IDs, unique_row_indexes] = unique(dd.src_subject_id, 'stable');
% Extract the data for the unique IDs
cleaned_data = dd(unique_row_indexes, :);
% Save the cleaned data to a new Excel file
% writetable(cleaned_data, 'cleaned_data.xlsx'); %%Error for no reason!

%%read data of std, mean, sums.
Data1=readtable('Data1.xlsx');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find rows where 'Name' column is not an empty string
rows_with_values = ~strcmp(Data1.Name, '');

% Use the logical array to keep only rows where 'Name' is not an empty string
Data2 = Data1(rows_with_values, :);

Data1=Data2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find the rows to remove
%% to etrcmp, string added in 2025
rows_to_remove = strcmp(string(cleaned_data.sai_p_music_perwk_l), '999') | strcmp(string(cleaned_data.sai_p_music_tspent_l), '999');
% Remove the rows
cleaned_data_No999 = cleaned_data(~rows_to_remove, :);
% Save the new table to an Excel file
writetable(cleaned_data_No999, 'cleaned_data_No999.xlsx');


% Find the row indexes where the column "sai_p_activities_l___23" is '1'
rows_to_select_ToPlay = strcmp(string(cleaned_data.sai_p_activities_l___23), '1');
% Extract the corresponding "src_subject_id" values
selected_subject_ids = cleaned_data.src_subject_id(rows_to_select_ToPlay);
% Create a new table with the selected subject IDs
to_play_table = table(selected_subject_ids);
% Save the new table to an Excel file
writetable(to_play_table, 'ToPlay.xlsx');

% Find the row indexes where the column "sai_p_activities_l___23" is '0'
rows_to_select_NotToPlay = strcmp(string(cleaned_data.sai_p_activities_l___23), '0');
% Extract the corresponding "src_subject_id" values
selected_subject_ids = cleaned_data.src_subject_id(rows_to_select_NotToPlay);
% Create a new table with the selected subject IDs
Notto_play_table = table(selected_subject_ids);
% Save the new table to an Excel file
writetable(Notto_play_table, 'NotToPlay.xlsx');

%%%%%%%%%%%%%%%%%
% Load the 'ToPlay.xlsx' file as a table
to_play = readtable('ToPlay.xlsx');
% Read all the values in the first column
to_play_names = to_play{:, 1};
% Find the row indexes in the "Name" column of the "Data1" table
[~, row_indexesA] = ismember(Data1.Name, to_play_names);
% Extract all rows specific to the derived indexes
to_play_features = Data1(row_indexesA > 0, :);

% Load the 'NotToPlay.xlsx' file as a table
Not_to_play = readtable('NotToPlay.xlsx');
% Read all the values in the first column
Not_to_play_names = Not_to_play{:, 1};
% Find the row indexes in the "Name" column of the "Data1" table
[~, row_indexesB] = ismember(Data1.Name, Not_to_play_names);
% Extract all rows specific to the derived indexes
Not_to_play_features = Data1(row_indexesB > 0, :);

% Remove the last column
Not_to_play_features(:, end) = [];
to_play_features(:, end) = [];


% Initialize a vector to store p-values
p_values = zeros(1, 3);

% Perform t-test for each column
for i = 1:3
    [~, p_values(i)] = ttest2(Not_to_play_features{:, i}, to_play_features{:, i});
end

% Display the p-values
disp(p_values);