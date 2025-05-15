clear;clc;close all;
% Get the current directory
current_directory = pwd;

% Set the folder name
folder_name = 'NIHTB';

% Create the full folder path
folder_path = fullfile(current_directory, folder_name);

% Get a list of all CSV files in the directory
csv_files = dir(fullfile(folder_path, '*.csv_*'));

% Set the percentage X of files to load
X = 100; % Change this value to load a different percentage

% Calculate the number of files to load based on the percentage
num_files_to_load = ceil(numel(csv_files) * X / 100);

% Initialize a cell array to store the data from each CSV file
all_data = cell(1, num_files_to_load);

%i=25375

% Iterate through the CSV files and read their content
for i = 1:num_files_to_load%1:num_files_to_load
    if(i==25375)
        continue;
    end
    % Get the file path
    
    file_path = fullfile(csv_files(i).folder, csv_files(i).name);
    
    % Get the actual file name by removing characters after ".csv_"
    actual_file_name = regexprep(csv_files(i).name, '\.csv_.*', '.csv');
    
    % Create a temporary file with the actual file name
    temp_file_path = fullfile(csv_files(i).folder, actual_file_name);
    copyfile(file_path, temp_file_path);
    
    % Read the content of the temporary CSV file
    % data = readtable(temp_file_path);
    % Read the content of the temporary CSV file
    data = readtable(temp_file_path, 'VariableNamingRule', 'preserve');

    
    % Store the data in the cell array
    all_data{i} = data;
    
    % Delete the temporary file
    delete(temp_file_path);

    % Display the current step and total steps
    fprintf('Processing file %d of %d\n', i, num_files_to_load);
end
