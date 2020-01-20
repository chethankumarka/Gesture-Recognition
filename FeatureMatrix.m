close all; clear all; clc;
%Read Data
filepath_EatFood = {
    'Data\EatFood1\accelerometer-1533862083.csv','Data\EatFood1\emg-1533862083.csv','Data\EatFood1\gyro-1533862083.csv','Data\EatFood1\orientation-1533862083.csv','Data\EatFood1\orientationEuler-1533862083.csv';
    'Data\EatFood2\accelerometer-1533862416.csv','Data\EatFood2\emg-1533862416.csv','Data\EatFood2\gyro-1533862416.csv','Data\EatFood2\orientation-1533862416.csv','Data\EatFood2\orientationEuler-1533862416.csv';
    'Data\EatFood3\accelerometer-1533862913.csv','Data\EatFood3\emg-1533862913.csv','Data\EatFood3\gyro-1533862913.csv','Data\EatFood3\orientation-1533862913.csv','Data\EatFood3\orientationEuler-1533862913.csv';
    'Data\EatFood4\accelerometer-1533864477.csv','Data\EatFood4\emg-1533864477.csv','Data\EatFood4\gyro-1533864477.csv','Data\EatFood4\orientation-1533864477.csv','Data\EatFood4\orientationEuler-1533864477.csv';
    };
filepath_drive = {
    'Data\drive1\accelerometer-1533665970.csv','Data\drive1\emg-1533665970.csv','Data\drive1\gyro-1533665970.csv','Data\drive1\orientation-1533665970.csv','Data\drive1\orientationEuler-1533665970.csv';
    'Data\drive1\accelerometer-1533665971.csv','Data\drive1\emg-1533665971.csv','Data\drive1\gyro-1533665971.csv','Data\drive1\orientation-1533665971.csv','Data\drive1\orientationEuler-1533665971.csv'};
plot_order = {' accelerometer',' EMG',' gyro',' orientation',' orientationEuler'};
[m,n] = size(filepath_EatFood);
[m2,n2] = size(filepath_drive);

%Variables Used
variance_EatFood_emg =[];variance_EatFood_orientation =[];variance_EatFood_euler=[];variance_EatFood_accelerometer=[];variance_EatFood_gyro=[];
variance_drive_emg =[];variance_drive_orientation =[];variance_drive_euler=[];variance_drive_accelerometer=[];variance_drive_gyro=[];

max_EatFood_emg =[];max_EatFood_orientation =[];max_EatFood_euler=[];max_EatFood_accelerometer=[];max_EatFood_gyro=[];
max_drive_emg =[];max_drive_orientation =[];max_drive_euler=[];max_drive_accelerometer=[];max_drive_gyro=[];

mean_EatFood_emg =[];mean_EatFood_orientation =[];mean_EatFood_euler=[];mean_EatFood_accelerometer=[];mean_EatFood_gyro=[];
mean_drive_emg =[];mean_drive_orientation =[];mean_drive_euler=[];mean_drive_accelerometer=[];mean_drive_gyro=[];

min_EatFood_emg =[];min_EatFood_orientation =[];min_EatFood_euler=[];min_EatFood_accelerometer=[];min_EatFood_gyro=[];
min_drive_emg =[];min_drive_orientation =[];min_drive_euler=[];min_drive_accelerometer=[];min_drive_gyro=[];

fft_EatFood_emg =[];fft_EatFood_orientation =[];fft_EatFood_euler=[];fft_EatFood_accelerometer=[];fft_EatFood_gyro=[];
fft_drive_emg =[];fft_drive_orientation =[];fft_drive_euler=[];fft_drive_accelerometer=[];fft_drive_gyro=[];


%FeatureExtraction for Eatfood
for col = 1:n
    for row = 1:m
        dataset_EatFood = xlsread(char(filepath_EatFood(row,col)));
        %dataset_drive = xlsread(char(filepath_drive(i,1)));
        variance_EatFood = var(dataset_EatFood,0,1);
        max_EatFood = max(dataset_EatFood);
        mean_EatFood = mean(dataset_EatFood);
        min_EatFood = min(dataset_EatFood);

        if strcmp(plot_order(1,col),' EMG')
            variance_EatFood_emg = [variance_EatFood_emg;variance_EatFood(1,[2:end])];
            max_EatFood_emg = [max_EatFood_emg;max_EatFood(1,[2:end])];
            mean_EatFood_emg = [mean_EatFood_emg;mean_EatFood(1,[2:end])];
            min_EatFood_emg = [min_EatFood_emg;min_EatFood(1,[2:end])];
        elseif strcmp(plot_order(1,col),' orientation')
            variance_EatFood_orientation = [variance_EatFood_orientation;variance_EatFood(1,[2:end])]; %#ok<*AGROW>
            max_EatFood_orientation = [max_EatFood_orientation;max_EatFood(1,[2:end])];
            mean_EatFood_orientation = [mean_EatFood_orientation;mean_EatFood(1,[2:end])];
            min_EatFood_orientation = [min_EatFood_orientation;min_EatFood(1,[2:end])];
        elseif strcmp(plot_order(1,col),' orientationEuler')
            variance_EatFood_euler = [variance_EatFood_euler;variance_EatFood(1,[2:end])];
            max_EatFood_euler = [max_EatFood_euler;max_EatFood(1,[2:end])];
            mean_EatFood_euler = [mean_EatFood_euler;mean_EatFood(1,[2:end])];
            min_EatFood_euler = [min_EatFood_euler;min_EatFood(1,[2:end])];
        elseif strcmp(plot_order(1,col),' accelerometer')
            variance_EatFood_accelerometer = [variance_EatFood_accelerometer;variance_EatFood(1,[2:end])];
            max_EatFood_accelerometer = [max_EatFood_accelerometer;max_EatFood(1,[2:end])];
            mean_EatFood_accelerometer = [mean_EatFood_accelerometer;mean_EatFood(1,[2:end])];
            min_EatFood_accelerometer = [min_EatFood_accelerometer;min_EatFood(1,[2:end])];
        elseif strcmp(plot_order(1,col),' gyro')
            variance_EatFood_gyro = [variance_EatFood_gyro;variance_EatFood(1,[2:end])];
             max_EatFood_gyro = [max_EatFood_gyro;max_EatFood(1,[2:end])];
             mean_EatFood_gyro = [mean_EatFood_gyro;mean_EatFood(1,[2:end])];
             min_EatFood_gyro = [min_EatFood_gyro;min_EatFood(1,[2:end])];
        end

    end
end
%FeatureExtraction for Drive
for col = 1:n2
    for row = 1:m2
        dataset_drive = xlsread(char(filepath_drive(row,col)));
        variance_drive = var(dataset_drive,0,1);
        max_drive = max(dataset_drive);
        mean_drive = mean(dataset_drive);
        min_drive = min(dataset_drive);
    %     disp(variance_drive);
        if strcmp(plot_order(1,col),' EMG')
            variance_drive_emg = [variance_drive_emg;variance_drive(1,[2:end])];
             max_drive_emg = [max_drive_emg;max_drive(1,[2:end])];
            mean_drive_emg = [mean_drive_emg;mean_drive(1,[2:end])];
            min_drive_emg = [min_drive_emg;min_drive(1,[2:end])];
        elseif strcmp(plot_order(1,col),' orientation')
            variance_drive_orientation = [variance_drive_orientation;variance_drive(1,[2:end])];
             max_drive_orientation = [max_drive_orientation;max_drive(1,[2:end])];
            mean_drive_orientation = [mean_drive_orientation;mean_drive(1,[2:end])];
            min_drive_orientation = [min_drive_orientation;min_drive(1,[2:end])];
        elseif strcmp(plot_order(1,col),' orientationEuler')
            variance_drive_euler = [variance_drive_euler;variance_drive(1,[2:end])];
            max_drive_euler = [max_drive_euler;max_drive(1,[2:end])];
            mean_drive_euler = [mean_drive_euler;mean_drive(1,[2:end])];
            min_drive_euler = [min_drive_euler;min_drive(1,[2:end])];
        elseif strcmp(plot_order(1,col),' accelerometer')
            variance_drive_accelerometer = [variance_drive_accelerometer;variance_drive(1,[2:end])];
            max_drive_accelerometer = [max_drive_accelerometer;max_drive(1,[2:end])];
            mean_drive_accelerometer = [mean_drive_accelerometer;mean_drive(1,[2:end])];
            min_drive_accelerometer = [min_drive_accelerometer;min_drive(1,[2:end])];
        else strcmp(plot_order(1,col),' gyro')
            variance_drive_gyro = [variance_drive_gyro;variance_drive(1,[2:end])];
            max_drive_gyro = [max_drive_gyro;max_drive(1,[2:end])];
            mean_drive_gyro = [mean_drive_gyro;mean_drive(1,[2:end])];
            min_drive_gyro = [min_drive_gyro;min_drive(1,[2:end])];
        end

    end
end


%%%Feature Matrix Creation

%features = {'EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8','ACCX','ACCY','ACCZ','GYX','GYY','GYZ','ORX','ORY','ORZ','ORW','OREX','OREY','OREZ'};
mean_vals = {[mean_drive_emg,mean_drive_accelerometer,mean_drive_gyro,mean_drive_orientation,mean_drive_euler]}
mean_vals{2} = [mean_EatFood_emg,mean_EatFood_accelerometer,mean_EatFood_gyro,mean_EatFood_orientation,mean_EatFood_euler]
min_vals = {[min_drive_emg,min_drive_accelerometer,min_drive_gyro,min_drive_orientation,min_drive_euler]}
min_vals{2} = [min_EatFood_emg,min_EatFood_accelerometer,min_EatFood_gyro,min_EatFood_orientation,min_EatFood_euler]
fft_vals = {[fft_drive_emg,fft_drive_accelerometer,fft_drive_gyro,fft_drive_orientation,fft_drive_euler]}
fft_vals{2} =[fft_EatFood_emg,fft_EatFood_accelerometer,fft_EatFood_gyro,fft_EatFood_orientation,fft_EatFood_euler]
max_vals = {[max_drive_emg,max_drive_accelerometer,max_drive_gyro,max_drive_orientation,max_drive_euler]}
max_vals{2} = [max_EatFood_emg,max_EatFood_accelerometer,max_EatFood_gyro,max_EatFood_orientation,max_EatFood_euler]
variance_vals = {[variance_drive_emg,variance_drive_accelerometer,variance_drive_gyro,variance_drive_orientation,variance_drive_euler]}
variance_vals{2} = [variance_EatFood_emg,variance_EatFood_accelerometer,variance_EatFood_gyro,variance_EatFood_orientation,variance_EatFood_euler]

% %%%Features Extracted from Feature Extraction Methods
%%%FFT,Mean,Min,Max,RMS(Variance)
F_Mean = [15,17,18]
F_FFT = [1,2,5,6,7,8]
F_Min = [1,2,8,12,13,14]
F_Max = [2,3,8,12,13,14]
F_RMS = [3,4,7,12,13,14,15,17,19]
action = {'drive','EatFood'}
Feature_Matrix_drive = []
Feature_Matrix_EatFood = []
%Mean
for activity = action
        if strcmp(activity,'drive')
            for column = F_Mean
                Feature_Matrix_drive = [Feature_Matrix_drive,mean_vals{1}(:,column)]
            end
        else
            for column = F_Mean
                Feature_Matrix_EatFood = [Feature_Matrix_EatFood,mean_vals{2}(:,column)]
            end
           
        end
end

%Min
for activity = action
    if strcmp(activity,'drive')
            for column = F_Min
                Feature_Matrix_drive = [Feature_Matrix_drive,min_vals{1}(:,column)]
            end
    else
            for column = F_Min
                Feature_Matrix_EatFood = [Feature_Matrix_EatFood,min_vals{2}(:,column)]
            end
    end
end

%Max
for activity = action
    if strcmp(activity,'drive')
            for column = F_Max
                Feature_Matrix_drive = [Feature_Matrix_drive,max_vals{1}(:,column)]
            end
    else
            for column = F_Max
                Feature_Matrix_EatFood = [Feature_Matrix_EatFood,max_vals{2}(:,column)]
            end
    end
end

%RMS
for activity = action
    if strcmp(activity,'drive')
            for column = F_RMS
                Feature_Matrix_drive = [Feature_Matrix_drive,variance_vals{1}(:,column)]
            end
    else
            for column = F_RMS
                Feature_Matrix_EatFood = [Feature_Matrix_EatFood,variance_vals{2}(:,column)]
            end
    end
end

%FFT
actions = {'EatFood1','EatFood2','EatFood3','EatFood4','drive1'}

files = {'emg','accelerometer','gyro','euler','orientation'}
features = {'EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8','ACCX','ACCY','ACCZ','GYX','GYY','GYZ','ORX','ORY','ORZ','ORW','OREX','OREY','OREZ'};
mean_features = {}
featmat1 = zeros(4,15);
featmat2 = zeros(2,15);

datapoint1 = 1;
datapoint2 = 1;
for i = 1:length(actions)
    dire = strcat('./Data/',actions{i});
    
    directoryList = dir(dire);
    for j = 3:length(directoryList)
        
        files = directoryList(j);
        file = directoryList(j).name;
        file_parts = strsplit(file,'-');
        file_part = file_parts{1};
        switch file_part
            case 'emg'
                offset = 0;
                fftEx= 1:8;
                file = xlsread(fullfile(directoryList(j).folder,directoryList(j).name));
                timestamp = file(:,1);
                disp('emg');
                for column=2:9
                    emg = file(:,column);
                    emg_fft = abs(fft(emg));
                    Fs = (timestamp(length(timestamp))-timestamp(1)) / length(timestamp) - 1;
                    diff = (timestamp(length(timestamp))-timestamp(1));
                    T = 1/Fs;
                    L = length(timestamp);
                    t = (0:L-1)*T;
                    P2 = abs(emg_fft/L);
                    P1 = P2(1:(L/2+1));
                    f = Fs*(0:(L/2))/L;
                    P1(2:end-1) = 2*P1(2:end-1);          
                    temp = sort(P1,'descend');
                    if contains(actions{i}, 'Eat')
           
                        peaks = 1:3;
                        for p = peaks
                            featmat1(datapoint1,offset + p) = temp(p);         
                        end
                    else
                        peaks = 2:4;
                        for p = peaks
                            featmat2(datapoint2,offset + (p-1)) = temp(p);         
                        end
                    end
                    offset = offset + 3;
                    disp(actions{i})
                end
                if contains(actions{i}, 'Eat')
                    datapoint1 = datapoint1 + 1
                else
                    datapoint2 = datapoint2 + 1
                end
            otherwise
                disp(file_part);
        end
    end
end

%Feature Matrices
Feature_Matrix_EatFood = [Feature_Matrix_EatFood,featmat1]
Feature_Matrix_drive = [Feature_Matrix_drive,featmat2]

%Co-Efficient Matrix Creation Using PCA
[coeff_drive,score_drive,latent_drive,tsquared_drive,explained_drive] = pca(Feature_Matrix_drive);
[coeff_EatFood,score_EatFood,latent_EatFood,tsquared_EatFood,explained_EatFood] = pca(Feature_Matrix_EatFood);

%Plotting the Eigen Vectors 
features = {'EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8','ACCX','ACCY','ACCZ','GYX','GYY','GYZ','ORX','ORY','ORZ','ORW','OREX','OREY','OREZ'};
labels = {'ORX_Mean','ORY_Mean','ORZ_Mean','GYX_Min','GYY_Min','GYZ_Min','EMG1_Min','EMG2_Min','EMG8_Min','GYX_Max','GYY_Max','GYZ_Max','EMG2_Max','EMG3_Max','EMG8_Max','OREX_Var','GYX_Var','GYY_Var','GYZ_Var','ORX_Var','ORZ_Var','EMG3_Var','EMG4_Var','EMG7_Var','FFT11','FFT12','FFT13','FFT21','FFT22','FFT23','FFT31','FFT32','FFT33','FFT41','FFT42','FFT43','FFT51','FFT52','FFT53','FFT61','FFT62','FFT63','FFT71','FFT72','FFT73','FFT81','FFT82','FFT83'}
figure;
biplot(coeff_EatFood,'Scores',score_EatFood);
title(strcat('Plot of Eigen Vectors for Eating'));

figure;
plot(coeff_drive)
title(strcat('Plot of Eigen Vectors for Driving'));
xlabel('features');
ylabel('Eigen Vector');

