close all; clear all; clc;
ratio_imu = 1.68;
ratio_emg = 3.4;
fork_label = 0
spoon_label = 1
%folders_of_data = {'groundTruth','MyoData'};
actions = {'fork','spoon'};

list_of_users = dir('./Data2/MyoData')
%number_of_train_records = 0.6 * length(list_of_users) for phase 3
for j=3:length(list_of_users)
    a_user = list_of_users(j)
    a_user_name = a_user.name
    for k=1:length(actions)
        directory_name_myo = strcat('./Data2/MyoData/',a_user_name,'/',actions{k});
        directory_name_ground = dir(strcat('./Data2/groundTruth/',a_user_name,'/',actions{k}))
        ground_file = strcat(directory_name_ground(3).folder,'/',directory_name_ground(3).name);
        %fileID = fopen(ground_file,'r');
        %ground_truth_file_text = fscanf(fileID,'%d,%d')
        files = dir(directory_name_myo)
        for l=3:length(files)-1
            if contains(files(l).name,'IMU')
                fileID = fopen(ground_file,'r');
                fileDataID = fopen(strcat(files(l).folder,'/',files(l).name));
                newFileID = fopen(strcat(files(l).folder,'/','_modified_',files(l).name),'a')
                while ~feof(fileID)
                    line = fgetl(fileID)
                    if isempty(line)
                        break
                    end
                    numbers = strsplit(line,',')
                    start_frame = floor(str2num(numbers{1})*ratio_imu)
                    end_frame = floor(str2num(numbers{2})*ratio_imu)
                    C = textscan(fileDataID,'%s',end_frame - start_frame + 1,'delimiter','\n', 'headerlines',start_frame-1)
                    text = [C{:}]
                    fprintf(newFileID,'%s\n',text{:})
                    frewind(fileDataID);
                end
                fclose(fileID);
                fclose(fileDataID);
                fclose(newFileID);
            elseif contains(files(l).name,'EMG')
                fileID = fopen(ground_file,'rt');
                fileDataID = fopen(strcat(files(l).folder,'/',files(l).name));
                newFileID = fopen(strcat(files(l).folder,'/','_modified_',files(l).name),'a')
                while ~feof(fileID)
                    line = fgetl(fileID)
                    if ~ischar(line)
                        break
                    end
                    numbers = strsplit(line,',')
                    start_frame = floor(str2num(numbers{1})*ratio_emg)
                    end_frame = floor(str2num(numbers{2})*ratio_emg)
                    C = textscan(fileDataID,'%s',end_frame - start_frame + 1,'delimiter','\n','headerlines',start_frame-1)
                    
                    text = [C{:}]
                    fprintf(newFileID,'%s\n',text{:})
                    frewind(fileDataID);
                end
                fclose(fileID);
                fclose(fileDataID);
                fclose(newFileID);
            end
        end
    end
    
end