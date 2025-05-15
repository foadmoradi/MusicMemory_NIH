lengthOfData=length(all_data);
% Preallocate arrays for the columns
FirstTest_mean_col = zeros(lengthOfData, 1);
FirstTest_std_col = zeros(lengthOfData, 1);
SecondTest_col = zeros(lengthOfData, 1);
Name_col = cell(lengthOfData, 1);

for i=1:lengthOfData
    try
        u=all_data{1,i};%all_data{1,i};%Check if all_data.all_data{1,i} ...
        
        Name=u.PIN(1);%Number is not important. All values in first column are PIN.
        
        Name=Name{1,1};
        
        if(Name=="No line items included in this export.")
            continue;
        end
        
        % Find the row indexes where the Inst column contains the desired string as a 
        % part of its value
        row_indexes1 = find(contains(u.Inst, 'NIH Toolbox Picture Sequence Memory Test'));
        
        % Extract the values from the Score column based on the row_indexes
        score_values1 = u.Score(row_indexes1);
        
        FirstTest_mean=mean(score_values1(~isnan(score_values1)));
        
        if(isnan(FirstTest_mean))
            Name
            i
        end
        
        FirstTest_std=std(score_values1(~isnan(score_values1)));
        
        row_indexes2 = find(contains(u.Inst, 'NIH Toolbox List Sorting Working Memory Test'));
        
        score_values2 = u.Score(row_indexes2);
        
        SecondTest=sum(score_values2);        
        
        % Iterate through the loop and save the values in the corresponding columns
        FirstTest_mean_col(i) = FirstTest_mean;
        FirstTest_std_col(i) = FirstTest_std;
        SecondTest_col(i) = SecondTest;
        Name_col{i} = Name;        
        
    catch exception
        continue;
    end
    
    %disp('Error!');
end
% Create the table "Data1" with the specified columns
Data1 = table(FirstTest_mean_col, FirstTest_std_col, SecondTest_col, Name_col, ...
    'VariableNames', {'FirstTest_mean', 'FirstTest_std', 'SecondTest', 'Name'});

%%%%%%In some rows, features have NaN values. Reject them, because in the
%%%%%%correlation test, they cause problems!

% Find rows with NaN values in the specified columns
nan_rows = isnan(Data1.FirstTest_mean) | isnan(Data1.FirstTest_std) | isnan(Data1.SecondTest);
% Remove rows with NaN values from the table
Data1_NoNaN = Data1(~nan_rows, :);
Data1=Data1_NoNaN;

writetable(Data1, 'Data1.xlsx');
