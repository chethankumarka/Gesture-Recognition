close all; clear all; clc;

actions = {'fork','spoon'};
%%%%Feature Matrices
variance_matrix_train = zeros(60,18);
max_matrix_train = zeros(60,18);
min_matrix_train = zeros(60,18);
mean_matrix_train = zeros(60,18);
variance_matrix_test =zeros(60,18);
max_matrix_test = zeros(60,18);
min_matrix_test = zeros(60,18);
mean_matrix_test = zeros(60,18);
entropy_matrix_train = zeros(60,18);
entropy_matrix_test = zeros(60,18);
std_matrix_train = zeros(60,18);
std_matrix_test = zeros(60,18);
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
                train_split = floor(lines*0.6);
                test_split = floor(lines*0.4);
                data = readtable(fileName);
                fileData = data(randperm(lines),:);
                train_EMG = fileData(1:train_split,2:end);
                test_EMG = fileData(train_split+1:lines,2:end);
            elseif contains(files(l).name,'modified') && contains(files(l).name,'IMU')
                fileName = strcat(files(l).folder,'/',files(l).name);
                lines = str2num(perl('countlines.pl',fileName));
                train_split = floor(lines*0.6);
                test_split = floor(lines*0.4);
                data = readtable(fileName);
                fileData = data(randperm(lines),:);
                train_IMU = fileData(1:train_split,2:end);
                test_IMU = fileData(train_split+1:lines,2:end);
            end
            
        
        %%%%%%%%%%Features Calculation for train data%%%%%%%%%%%
     
            %fclose(fileDataID);
        end
        
        %%%Convert table to array
        train_EMG = table2array(train_EMG);
        train_IMU = table2array(train_IMU);
        test_EMG = table2array(test_EMG);
        test_IMU = table2array(test_IMU);
        %%%Calculate variancce, min,max and mean for all the features
        variance_matrix_train(row,:) = horzcat(var(train_EMG,0,1),var(train_IMU,0,1));
        variance_matrix_test(row,:)  = horzcat(var(test_EMG,0,1),var(test_IMU,0,1));
        min_matrix_train(row,:)      = horzcat(min(train_EMG),min(train_IMU));
        min_matrix_test(row,:)       = horzcat(min(test_EMG),min(test_IMU));
        max_matrix_train(row,:)      = horzcat(max(train_EMG),max(train_IMU));
        max_matrix_test(row,:)       = horzcat(max(test_EMG),max(test_IMU));
        mean_matrix_train(row,:)     = horzcat(mean(train_EMG),mean(train_IMU));
        mean_matrix_test(row,:)      = horzcat(mean(test_EMG),mean(test_IMU));
        std_matrix_train(row,:)      = horzcat(std(train_EMG),std(train_IMU));
        std_matrix_test(row,:)       = horzcat(std(test_EMG),std(test_IMU));
        truth_label(row,:)           = horzcat(strcmpi('spoon',actions(k)));
        %%%calculate entropy for all features%%%
        entropy_train = []
        entropy_test = []
        for i = 1:size(train_EMG,2)    
        entropy_train  = horzcat(entropy_train,entropy(train_EMG(:,i)))
        entropy_test = horzcat(entropy_test,entropy(test_EMG(:,i)))
        end
        for i = 1:size(train_IMU,2)    
        entropy_train = horzcat(entropy_train,entropy(train_IMU(:,i)))
        entropy_test = horzcat(entropy_test,entropy(test_IMU(:,i)))
        end
        entropy_matrix_train(row,:)     = entropy_train;
        entropy_matrix_test(row,:)      = entropy_test;
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
Feature_Matrix_train = zeros(0,45);
Feature_Matrix_test = zeros(0,45);

%%%Feature Matrix Construction
for method = ["Mean","FFT","Min","Max","STD","Var","Entropy"]
    switch method
        
        case "Mean"
            temp_train = zeros(60,0);
            temp_test = zeros(60,0);
            count =1;
            for i = F_Mean
                temp_train(:,count:count) = mean_matrix_train(:,i:i);
                temp_test(:,count:count) = mean_matrix_test(:,i:i);
                count=count+1;
            end
            Feature_Matrix_train = horzcat(Feature_Matrix_train,temp_train)
            Feature_Matrix_test = horzcat(Feature_Matrix_test,temp_test)
        case "Min"
            temp_train = zeros(60,0);
            temp_test = zeros(60,0);
            count = 1;
            for i = F_Min
                temp_train(:,count:count) = min_matrix_train(:,i:i);
                temp_test(:,count:count) = min_matrix_test(:,i:i);
                count = count+1
            end
            Feature_Matrix_train = horzcat(Feature_Matrix_train,temp_train);
            Feature_Matrix_test = horzcat(Feature_Matrix_test,temp_test);
        case "Max"
            temp_train = zeros(60,0);
            temp_test = zeros(60,0);
            count = 1;
            for i = F_Max
                temp_train(:,count:count) = max_matrix_train(:,i:i);
                temp_test(:,count:count) = max_matrix_test(:,i:i);
                count = count+1
            end
            Feature_Matrix_train = horzcat(Feature_Matrix_train,temp_train);
            Feature_Matrix_test = horzcat(Feature_Matrix_test,temp_test);
        case "Var"
            temp_train = zeros(60,0);
            temp_test = zeros(60,0);
            count = 1;
            for i = F_STD
                temp_train(:,count:count) = variance_matrix_train(:,i:i)
                temp_test(:,count:count) = variance_matrix_test(:,i:i) 
                count = count+1;
            end
            Feature_Matrix_train = horzcat(Feature_Matrix_train,temp_train);
            Feature_Matrix_test = horzcat(Feature_Matrix_test,temp_test);
            case "STD"
            temp_train = zeros(60,0);
            temp_test = zeros(60,0);
            count = 1;
            for i = F_Var
                temp_train(:,count:count) = std_matrix_train(:,i:i)
                temp_test(:,count:count) = std_matrix_test(:,i:i) 
                count = count+1;
            end
            Feature_Matrix_train = horzcat(Feature_Matrix_train,temp_train);
            Feature_Matrix_test = horzcat(Feature_Matrix_test,temp_test);
            case "Entropy"
            temp_train = zeros(60,0);
            temp_test = zeros(60,0);
            count = 1;
            for i = F_Entropy
                temp_train(:,count:count) = entropy_matrix_train(:,i:i)
                temp_test(:,count:count) = entropy_matrix_test(:,i:i) 
                count = count+1;
            end
            Feature_Matrix_train = horzcat(Feature_Matrix_train,temp_train);
            Feature_Matrix_test = horzcat(Feature_Matrix_test,temp_test);
        otherwise
        continue
    end       
end
%%%%%%%%Perform PCA
[coeff_train,score_train] = pca(Feature_Matrix_train);
[coeff_test,score_test] = pca(Feature_Matrix_test);
%%% Method 1 87%
Feature_Matrix_train = horzcat(Feature_Matrix_train,truth_label)
Feature_Matrix_test = horzcat(Feature_Matrix_test,truth_label)

%%% Train-Test split
%X_train = Feature_Matrix_train(:,1:end-1);
%X_test = Feature_Matrix_test(:,1:end-1);
%y_train = Feature_Matrix_train(:,end);
%y_test = Feature_Matrix_test(:,end);

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
coeff_train = horzcat(coeff_train,truth_label(1:length(coeff_train),:));
coeff_test = horzcat(coeff_test,truth_label(1:length(coeff_test),:));

%%% Train-Test split
X_train = coeff_train(:,1:end-1);
X_test = coeff_test(:,1:end-1);
y_train = coeff_train(:,end);
y_test = coeff_test(:,end);

save('data2/X_train.mat','X_train');
save('data2/X_test.mat','X_test');
save('data2/y_train.mat','y_train');
save('data2/y_test.mat','y_test');

