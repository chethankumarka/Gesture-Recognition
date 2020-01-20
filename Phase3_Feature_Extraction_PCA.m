close all; clear all; clc;

actions = {'fork','spoon'};
%%%%Feature Matrices
variance_matrix = zeros(60,18);
max_matrix = zeros(60,18);
min_matrix = zeros(60,18);
mean_matrix = zeros(60,18);
entropy_matrix_users = zeros(60,18);
std_matrix = zeros(60,18);
truth_label = zeros(60,1);
%%%%%%%Reading users and making train test split for IMU and EMG file
list_of_users = dir('./Data2/MyoData');
row = 0;
for j=3:length(list_of_users)
    a_user = list_of_users(j);
    a_user_name = a_user.name;
    for k=1:length(actions)
        row = row+1;
        directory_name_myo = strcat('./Data2/MyoData/',a_user_name,'/',actions{k});
        files = dir(directory_name_myo);
        for l=3:length(files)
            %fileDataID = fopen(strcat(files(l).folder,'/',files(l).name));
            if contains(files(l).name,'modified') && contains(files(l).name,'EMG')
                fileName = strcat(files(l).folder,'/',files(l).name);
                lines = str2num(perl('countlines.pl',fileName));
                data = readtable(fileName);
                fileData = data(randperm(lines),:);
                EMG_data = fileData(:,2:end);
            elseif contains(files(l).name,'modified') && contains(files(l).name,'IMU')
                fileName = strcat(files(l).folder,'/',files(l).name);
                lines = str2num(perl('countlines.pl',fileName));
                data = readtable(fileName);
                fileData = data(randperm(lines),:);
                IMU_data = fileData(:,2:end);
            end
            
        
        %%%%%%%%%%Features Calculation for train data%%%%%%%%%%%
     
            %fclose(fileDataID);
        end
        
        %%%Convert table to array
        EMG_data = table2array(EMG_data);
        IMU_data = table2array(IMU_data);
        %%%Calculate variancce, min,max and mean for all the features
        variance_matrix(row,:) = horzcat(var(EMG_data,0,1),var(IMU_data,0,1));
        min_matrix(row,:)      = horzcat(min(EMG_data),min(IMU_data));
        max_matrix(row,:)      = horzcat(max(EMG_data),max(IMU_data));
        mean_matrix(row,:)     = horzcat(mean(EMG_data),mean(IMU_data));
        std_matrix(row,:)      = horzcat(std(EMG_data),std(IMU_data));
        truth_label(row,:)           = horzcat(strcmpi('spoon',actions(k)));
        %%%calculate entropy for all features%%%
        entropy_matrix = []
        for i = 1:size(EMG_data,2)    
        entropy_matrix  = horzcat(entropy_matrix,entropy(EMG_data(:,i)))
        end
        for i = 1:size(IMU_data,2)    
        entropy_matrix = horzcat(entropy_matrix,entropy(IMU_data(:,i)))
        end
        entropy_matrix_users(row,:)     = entropy_matrix;
    end
end

%%%%%%%%%%Filter the required features into the feature matrix
%features = {'EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8','ORX','ORY','ORZ','ORW','ACCX','ACCY','ACCZ','GYX','GYY','GYZ'};
F_Mean = [1,4,5,6,9,10,11,12,16,17,18];
%F_FFT = [1,2,5,6,7,8];
F_Min = [2,8,9,10,14,16,17,18];
F_Max = [1,4,11,12,13,14,15,16,17];
F_STD = [5,9,10,11,13,15,16,17];
F_Var = [1,8,9,10,13,15,16,17,18];
F_Entropy = [4,5,10,11,12,14,15,16,17,18];
n = 45;
Feature_Matrix = zeros(0,45);

%%%Feature Matrix Construction
for method = ["Mean","FFT","Min","Max","STD","Var","Entropy"]
    switch method
        
        case "Mean"
            temp = zeros(60,0);
            count =1;
            for i = F_Mean
                temp(:,count:count) = mean_matrix(:,i:i);
                count=count+1;
            end
            Feature_Matrix = horzcat(Feature_Matrix,temp);
        case "Min"
            temp = zeros(60,0);
            count = 1;
            for i = F_Min
                temp(:,count:count) = min_matrix(:,i:i);
                count = count+1
            end
            Feature_Matrix = horzcat(Feature_Matrix,temp);
        case "Max"
            temp = zeros(60,0);
            count = 1;
            for i = F_Max
                temp(:,count:count) = max_matrix(:,i:i);
                count = count+1
            end
            Feature_Matrix = horzcat(Feature_Matrix,temp);
        case "Var"
            temp = zeros(60,0);
            count = 1;
            for i = F_STD
                temp(:,count:count) = variance_matrix(:,i:i)
                count = count+1;
            end
            Feature_Matrix = horzcat(Feature_Matrix,temp);
            case "STD"
            temp = zeros(60,0);
            count = 1;
            for i = F_Var
                temp(:,count:count) = std_matrix(:,i:i)
                count = count+1;
            end
            Feature_Matrix = horzcat(Feature_Matrix,temp);
            case "Entropy"
            temp = zeros(60,0);
            count = 1;
            for i = F_Entropy
                temp(:,count:count) = entropy_matrix_users(:,i:i); 
                count = count+1;
            end
            Feature_Matrix = horzcat(Feature_Matrix,temp);
        otherwise
        continue
    end       
end
%%%%%%%%Perform PCA
[coeff,score] = pca(Feature_Matrix);
split_ratio = 0.6;

%%% Method 1 87%
%Feature_Matrix = horzcat(Feature_Matrix,truth_label);
%%% Train-Test split
%X_train = Feature_Matrix(1:int32(floor(split_ratio * length(Feature_Matrix))),1:end-1);
%X_test = Feature_Matrix(int32(floor(split_ratio * length(Feature_Matrix)))+1:end,1:end-1);
%y_train = Feature_Matrix(1:int32(floor(split_ratio * length(Feature_Matrix))),end);
%y_test = Feature_Matrix(int32(floor(split_ratio * length(Feature_Matrix)))+1:end,end);

%%% Method 2 44%
%coeff_train = horzcat(coeff_train,truth_label(1:length(coeff_train),:));
%coeff_test = horzcat(coeff_test,truth_label(1:length(coeff_test),:));
%PCA_Matrix = vertcat(coeff_train,coeff_test);
%%% Spliting into 0.6 train and 0.4 test
%X_train = PCA_Matrix(1:int32(floor(0.6 * length(PCA_Matrix))), 1:end-1);
%X_test = PCA_Matrix(int32(floor(0.6 * length(PCA_Matrix)))+1:end, 1:end-1);
%y_train = PCA_Matrix(1:int32(floor(0.6 * length(PCA_Matrix))), end);
%y_test = PCA_Matrix(int32(floor(0.6 * length(PCA_Matrix)))+1:end, end);

%%% Method 3 33%
coeff = horzcat(coeff,truth_label(1:length(coeff),:));
%%% Train-Test split
X_train = coeff(1:int32(floor(split_ratio * length(coeff))),1:end-1);
X_test = coeff(int32(floor(split_ratio * length(coeff)))+1:end,1:end-1);
y_train = coeff(1:int32(floor(split_ratio * length(coeff))),end);
y_test = coeff(int32(floor(split_ratio * length(coeff)))+1:end,end);

save('data2/X_train_Phase3.mat','X_train');
save('data2/X_test_Phase3.mat','X_test');
save('data2/y_train_Phase3.mat','y_train');
save('data2/y_test_Phase3.mat','y_test');

