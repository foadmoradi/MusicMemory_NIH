cleaned_data_No999=readtable('cleaned_data_No999.xlsx');

% Get the IDs from the first column of the 'to_play' table
to_play_IDs = to_play{:, 1};

% Find the rows in 'cleaned_data_No999' that match the IDs from 'to_play'
[matching_rows, ~] = ismember(cleaned_data_No999{:, 1}, to_play_IDs);

% Create a new table 'AmountOfTraining' with the relevant rows
AmountOfTraining = cleaned_data_No999(matching_rows, :);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert string columns to numeric arrays

%% sai_p_music_perwk_l_numeric = str2double(AmountOfTraining.sai_p_music_perwk_l); changed in 2025
%% sai_p_music_tspent_l_numeric = str2double(AmountOfTraining.sai_p_music_tspent_l); changed in 2025
sai_p_music_perwk_l_numeric = AmountOfTraining.sai_p_music_perwk_l;
sai_p_music_tspent_l_numeric = AmountOfTraining.sai_p_music_tspent_l;

% Multiply values in the numeric arrays
product = sai_p_music_perwk_l_numeric .* sai_p_music_tspent_l_numeric;

% Add the new column to the table
AmountOfTraining.Product = product;

%%%%%%%%%%%Remove rows with NaN product.

% Find rows with NaN values in the specified columns
nan_rows2 = isnan(AmountOfTraining.Product) ;
% Remove rows with NaN values from the table
AmountOfTraining_NoNaN = AmountOfTraining(~nan_rows2, :);
AmountOfTraining=AmountOfTraining_NoNaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
means_to_play=to_play_features.FirstTest_mean;
std_to_play=to_play_features.FirstTest_std;
sums_to_play=to_play_features.SecondTest;

k=[length(means_to_play),length(std_to_play),length(sums_to_play)];
kk=min(k);

% product1=AmountOfTraining.Product(1:kk);
product1=AmountOfTraining.Product;

corr1=corrcoef(means_to_play(1:length(product1)),product1);
corr2=corrcoef(std_to_play(1:length(product1)),product1);
corr3=corrcoef(sums_to_play(1:length(product1)),product1);

SimilarityBetweenTimeAndScores=[corr1(1,2), corr2(1,2), corr3(1,2)];

disp(SimilarityBetweenTimeAndScores);
