close all; clear all; clc;
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
variance_EatFood_emg =[];variance_EatFood_orientation =[];variance_EatFood_euler=[];variance_EatFood_accelerometer=[];variance_EatFood_gyro=[];
variance_drive_emg =[];variance_drive_orientation =[];variance_drive_euler=[];variance_drive_accelerometer=[];variance_drive_gyro=[];
max_EatFood_emg =[];max_EatFood_orientation =[];max_EatFood_euler=[];max_EatFood_accelerometer=[];max_EatFood_gyro=[];
max_drive_emg =[];max_drive_orientation =[];max_drive_euler=[];max_drive_accelerometer=[];max_drive_gyro=[];
mean_EatFood_emg =[];mean_EatFood_orientation =[];mean_EatFood_euler=[];mean_EatFood_accelerometer=[];mean_EatFood_gyro=[];
mean_drive_emg =[];mean_drive_orientation =[];mean_drive_euler=[];mean_drive_accelerometer=[];mean_drive_gyro=[];
min_EatFood_emg =[];min_EatFood_orientation =[];min_EatFood_euler=[];min_EatFood_accelerometer=[];min_EatFood_gyro=[];
min_drive_emg =[];min_drive_orientation =[];min_drive_euler=[];min_drive_accelerometer=[];min_drive_gyro=[];

% Variance, max, min, mean, fft for  Eatfood
for col = 1:n
    for row = 1:m
        dataset_EatFood = xlsread(char(filepath_EatFood(row,col)));
        variance_EatFood = var(dataset_EatFood,0,1);
        max_EatFood = max(dataset_EatFood);
        mean_EatFood = mean(dataset_EatFood);
        min_EatFood = min(dataset_EatFood);
        Y = abs(fft(dataset_EatFood(:,[2:end])));
        timestamp = dataset_EatFood(:,1);
        L = length(timestamp);
        Fs = (timestamp(L)-timestamp(1)) / L - 1;
        T = 1/Fs;
        t = (0:L-1)*T;
        P2 = abs(Y/L);
        P1 = P2([1:(L/2+1)],[1:end]);
        P1([2:end-1],[1:end]) = 2*P1([2:end-1],[1:end]);
        f = Fs*(0:(L/2))/L;
        
        switch(col)
        case (1)
            switch(row)
                case(1)
                    fft_EatFood1_acc = horzcat(f.',P1);
                case(2)
                    fft_EatFood2_acc = horzcat(f.',P1);
                case(3)
                    fft_EatFood3_acc = horzcat(f.',P1);
                case(4)
                    fft_EatFood4_acc = horzcat(f.',P1);
            end
        case (2)
            switch(row)
                case(1)
                    fft_EatFood1_emg = horzcat(f.',P1);
                case(2)
                    fft_EatFood2_emg = horzcat(f.',P1);
                case(3)
                    fft_EatFood3_emg = horzcat(f.',P1);
                case(4)
                    fft_EatFood4_emg = horzcat(f.',P1);
            end
         case (3)
            switch(row)
                case(1)
                    fft_EatFood1_gyro= horzcat(f.',P1);
                case(2)
                    fft_EatFood2_gyro = horzcat(f.',P1);
                case(3)
                    fft_EatFood3_gyro = horzcat(f.',P1);
                case(4)
                    fft_EatFood4_gyro = horzcat(f.',P1);
            end
         case (4)
            switch(row)
                case(1)
                    fft_EatFood1_ori = horzcat(f.',P1);
                case(2)
                    fft_EatFood2_ori = horzcat(f.',P1);
                case(3)
                    fft_EatFood3_ori = horzcat(f.',P1);
                case(4)
                    fft_EatFood4_ori = horzcat(f.',P1);
            end
         case (5)
            switch(row)
                case(1)
                    fft_EatFood1_euler = horzcat(f.',P1);
                case(2)
                    fft_EatFood2_euler = horzcat(f.',P1);
                case(3)
                    fft_EatFood3_euler = horzcat(f.',P1);
                case(4)
                    fft_EatFood4_euler = horzcat(f.',P1);
            end
 
        end
        if strcmp(plot_order(1,col),' EMG')
            variance_EatFood_emg = [variance_EatFood_emg;variance_EatFood(1,[2:end])];
            max_EatFood_emg = [max_EatFood_emg;max_EatFood(1,[2:end])];
            mean_EatFood_emg = [mean_EatFood_emg;mean_EatFood(1,[2:end])];
            min_EatFood_emg = [min_EatFood_emg;min_EatFood(1,[2:end])];
            
        elseif strcmp(plot_order(1,col),' orientation')
            variance_EatFood_orientation = [variance_EatFood_orientation;variance_EatFood(1,[2:end])];
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
        else strcmp(plot_order(1,col),' gyro')
            variance_EatFood_gyro = [variance_EatFood_gyro;variance_EatFood(1,[2:end])];
             max_EatFood_gyro = [max_EatFood_gyro;max_EatFood(1,[2:end])];
             mean_EatFood_gyro = [mean_EatFood_gyro;mean_EatFood(1,[2:end])];
             min_EatFood_gyro = [min_EatFood_gyro;min_EatFood(1,[2:end])];
        end

    end
end
% Variance, max, min, mean, fft for Drive
for col = 1:n2
    for row = 1:m2
        dataset_drive = xlsread(char(filepath_drive(row,col)));
        variance_drive = var(dataset_drive,0,1);
        max_drive = max(dataset_drive);
        mean_drive = mean(dataset_drive);
        min_drive = min(dataset_drive);
        Y = abs(fft(dataset_drive(:,[2:end])));
        timestamp = dataset_drive(:,1);
        L = length(timestamp);
        Fs = (timestamp(L)-timestamp(1)) / L - 1;
        T = 1/Fs;
        t = (0:L-1)*T;
        P2 = abs(Y/L);
        P1 = P2([1:(L/2+1)],[1:end]);
        P1([2:end-1],[1:end]) = 2*P1([2:end-1],[1:end]);
        f = Fs*(0:(L/2))/L;
        
        switch(col)
        case (1)
            switch(row)
                case(1)
                    fft_drive1_acc = horzcat(f.',P1);
                case(2)
                    fft_drive2_acc = horzcat(f.',P1);
                end
        case (2)
            switch(row)
                
                case(1)
                    fft_drive1_emg = horzcat(f.',P1);
                case(2)
                    fft_drive2_emg = horzcat(f.',P1);
                end
         case (3)
            switch(row)
                case(1)
                    fft_drive1_gyro = horzcat(f.',P1);
                case(2)
                    fft_drive2_gyro = horzcat(f.',P1);
                end
         case (4)
            switch(row)
                case(1)
                    fft_drive1_ori = horzcat(f.',P1);
                case(2)
                    fft_drive2_ori = horzcat(f.',P1);
                end
         case (5)
            switch(row)
                case(1)
                    fft_drive1_euler = horzcat(f.',P1);
                case(2)
                    fft_drive2_euler = horzcat(f.',P1);
                end
 
        end

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
for col = 1:n    
%Plotting figures for all instance    
    if strcmp(plot_order(1,col),' EMG')
           x = {'EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8'};
           figure;
           subplot(2,1,1);
           plot(variance_EatFood_emg.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Variance of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(variance_drive_emg.');
           legend('Drive1','Drive2');
           title(strcat('Variance of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
             
            figure;
           subplot(2,1,1);
           plot(max_EatFood_emg.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('max of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(max_drive_emg.');
           legend('Drive1','Drive2');
           title(strcat('max of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            
            figure;
           subplot(2,1,1);
           plot(mean_EatFood_emg.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('mean of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(mean_drive_emg.');
           legend('Drive1','Drive2');
           title(strcat('mean of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            
              figure;
           subplot(2,1,1);
           plot(min_EatFood_emg.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('min of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(min_drive_emg.');
           legend('Drive1','Drive2');
           title(strcat('min of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
    elseif strcmp(plot_order(1,col),' orientation')
            x = {'x','','y','','z','','w',''};
            figure;
           subplot(2,1,1);
           plot(variance_EatFood_orientation.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Variance of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(variance_drive_orientation.');
           legend('Drive1','Drive2');
           title(strcat('Variance of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            
             figure;
           subplot(2,1,1);
           plot(max_EatFood_orientation.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('max of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(max_drive_orientation.');
           legend('Drive1','Drive2');
           title(strcat('max of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            
            figure;
           subplot(2,1,1);
           plot(mean_EatFood_orientation.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('mean of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(mean_drive_orientation.');
           legend('Drive1','Drive2');
           title(strcat('mean of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            
            figure;
           subplot(2,1,1);
           plot(min_EatFood_orientation.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('min of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(min_drive_orientation.');
           legend('Drive1','Drive2');
           title(strcat('min of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')

     elseif strcmp(plot_order(1,col),' orientationEuler')
            x = {'roll','','','','','pitch','','','','','yaw',''};
            figure;
           subplot(2,1,1);
           plot(variance_EatFood_euler.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Variance of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(variance_drive_euler.');
           legend('Drive1','Drive2');
           title(strcat('Variance of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            
             figure;
           subplot(2,1,1);
           plot(max_EatFood_euler.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('max of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(max_drive_euler.');
           legend('Drive1','Drive2');
           title(strcat('max of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            
              figure;
           subplot(2,1,1);
           plot(mean_EatFood_euler.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Mean of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(mean_drive_euler.');
           legend('Drive1','Drive2');
           title(strcat('mean of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            
            figure;
           subplot(2,1,1);
           plot(min_EatFood_euler.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Min of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(min_drive_euler.');
           legend('Drive1','Drive2');
           title(strcat('Min of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
     elseif strcmp(plot_order(1,col),' accelerometer')
            x = {'x','','','','','y','','','','','z',''}; 
            figure;
           subplot(2,1,1);
           plot(variance_EatFood_accelerometer.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Variance of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(variance_drive_accelerometer.');
           legend('Drive1','Drive2');
           title(strcat('Variance of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            
             figure;
           subplot(2,1,1);
           plot(max_EatFood_accelerometer.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('max of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(max_drive_accelerometer.');
           legend('Drive1','Drive2');
           title(strcat('max of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            
              figure;
           subplot(2,1,1);
           plot(mean_EatFood_accelerometer.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Mean of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(mean_drive_accelerometer.');
           legend('Drive1','Drive2');
           title(strcat('Mean of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            
             figure;
           subplot(2,1,1);
           plot(min_EatFood_accelerometer.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Min of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(min_drive_accelerometer.');
           legend('Drive1','Drive2');
           title(strcat('Min of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
     else strcmp(plot_order(1,col),' gyro')
            x = {'x','','','','','y','','','','','z',''}; 
            figure;
           subplot(2,1,1);
           plot(variance_EatFood_gyro.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Variance of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(variance_drive_gyro.');
           legend('Drive1','Drive2');
           title(strcat('Variance of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|Var|');
            set(gca,'xticklabel',x.')
            
            figure;
           subplot(2,1,1);
           plot(max_EatFood_gyro.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('max of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(max_drive_gyro.');
           legend('Drive1','Drive2');
           title(strcat('max of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|max|');
            set(gca,'xticklabel',x.')
            
            figure;
           subplot(2,1,1);
           plot(mean_EatFood_gyro.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Mean of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(mean_drive_gyro.');
           legend('Drive1','Drive2');
           title(strcat('Mean of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|mean|');
            set(gca,'xticklabel',x.')
            
             figure;
           subplot(2,1,1);
           plot(min_EatFood_gyro.');
           legend('EatFood1','EatFood2','EatFood3','EatFood4');
           title(strcat('Min of EatFood action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
            subplot(2,1,2);
           plot(min_drive_gyro.');
           legend('Drive1','Drive2');
           title(strcat('Min of Drive action for ', char(plot_order(1,col))));
            xlabel('features');
            ylabel('|min|');
            set(gca,'xticklabel',x.')
     end    
end
% Polt for FFT
for col = 1:n 
    if strcmp(plot_order(1,col),' EMG')
        figure;
           subplot(2,2,1);
           plot(fft_EatFood1_emg(:,1).',fft_EatFood1_emg(:,[2:end]));
           legend('EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8');
           title(strcat('FFT of EatFood1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,2);
           plot(fft_EatFood2_emg(:,1).',fft_EatFood2_emg(:,[2:end]));
           legend('EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8');
           title(strcat('FFT of EatFood2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,3);
           plot(fft_EatFood3_emg(:,1).',fft_EatFood3_emg(:,[2:end]));
           legend('EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8');
           title(strcat('FFT of EatFood3 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,4);
           plot(fft_EatFood4_emg(:,1).',fft_EatFood4_emg(:,[2:end]));
           legend('EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8');
           title(strcat('FFT of EatFood4 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
          figure;
           subplot(2,1,1);
           plot(fft_drive1_emg(:,1).',fft_drive1_emg(:,[2:end]));
           legend('EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8');
           title(strcat('FFT of Drive1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,1,2);
           plot(fft_drive2_emg(:,1).',fft_drive2_emg(:,[2:end]));
           legend('EMG1','EMG2','EMG3','EMG4','EMG5','EMG6','EMG7','EMG8');
           title(strcat('FFT of Drive2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')  
            
    elseif strcmp(plot_order(1,col),' orientation')
                figure;
           subplot(2,2,1);
           plot(fft_EatFood1_ori(:,1).',fft_EatFood1_ori(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z','W');
           title(strcat('FFT of EatFood1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,2);
           plot(fft_EatFood2_ori(:,1).',fft_EatFood2_ori(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z','W');
           title(strcat('FFT of EatFood2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,3);
           plot(fft_EatFood3_ori(:,1).',fft_EatFood3_ori(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z','W');
           title(strcat('FFT of EatFood3 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,4);
           plot(fft_EatFood4_ori(:,1).',fft_EatFood4_ori(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z','W');
           title(strcat('FFT of EatFood4 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
          figure;
           subplot(2,1,1);
           plot(fft_drive1_ori(:,1).',fft_drive1_ori(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z','W');
           title(strcat('FFT of Drive1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,1,2);
           plot(fft_drive2_ori(:,1).',fft_drive2_ori(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z','W');
           title(strcat('FFT of Drive2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|') 
    elseif strcmp(plot_order(1,col),' orientationEuler')
           figure;
           subplot(2,2,1);
           plot(fft_EatFood1_euler(:,1).',fft_EatFood1_euler(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('Roll','Pitch','Yaw');
           title(strcat('FFT of EatFood1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,2);
           plot(fft_EatFood2_euler(:,1).',fft_EatFood2_euler(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('Roll','Pitch','Yaw');
           title(strcat('FFT of EatFood2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,3);
           plot(fft_EatFood3_euler(:,1).',fft_EatFood3_euler(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('Roll','Pitch','Yaw');
           title(strcat('FFT of EatFood3 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,4);
           plot(fft_EatFood4_euler(:,1).',fft_EatFood4_euler(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('Roll','Pitch','Yaw');
           title(strcat('FFT of EatFood4 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
          figure;
           subplot(2,1,1);
           plot(fft_drive1_euler(:,1).',fft_drive1_euler(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('Roll','Pitch','Yaw');
           title(strcat('FFT of Drive1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,1,2);
           plot(fft_drive2_euler(:,1).',fft_drive2_euler(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('Roll','Pitch','Yaw');
           title(strcat('FFT of Drive2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|') 
    elseif strcmp(plot_order(1,col),' accelerometer')
           figure;
           subplot(2,2,1);
           plot(fft_EatFood1_acc(:,1).',fft_EatFood1_acc(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z');
           title(strcat('FFT of EatFood1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,2);
           plot(fft_EatFood2_acc(:,1).',fft_EatFood2_acc(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z');
           title(strcat('FFT of EatFood2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,3);
           plot(fft_EatFood3_acc(:,1).',fft_EatFood3_acc(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z');
           title(strcat('FFT of EatFood3 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,4);
           plot(fft_EatFood4_acc(:,1).',fft_EatFood4_acc(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z');
           title(strcat('FFT of EatFood4 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
          figure;
           subplot(2,1,1);
           plot(fft_drive1_acc(:,1).',fft_drive1_acc(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z');
           title(strcat('FFT of Drive1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,1,2);
           plot(fft_drive2_acc(:,1).',fft_drive2_acc(:,[2:end]));
           set(gca,'Xlim',[1 800]);
           legend('X','Y','Z');
           title(strcat('FFT of Drive2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|') 
    else strcmp(plot_order(1,col),' gyro')
            figure;
           subplot(2,2,1);
           plot(fft_EatFood1_gyro(:,1).',fft_EatFood1_gyro(:,[2:end]));
           legend('X','Y','Z');
           title(strcat('FFT of EatFood1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,2);
           plot(fft_EatFood2_gyro(:,1).',fft_EatFood2_gyro(:,[2:end]));
           legend('X','Y','Z');
           title(strcat('FFT of EatFood2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,3);
           plot(fft_EatFood3_gyro(:,1).',fft_EatFood3_gyro(:,[2:end]));
           legend('X','Y','Z');
           title(strcat('FFT of EatFood3 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,2,4);
           plot(fft_EatFood4_gyro(:,1).',fft_EatFood4_gyro(:,[2:end]));
           legend('X','Y','Z');
           title(strcat('FFT of EatFood4 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
          figure;
           subplot(2,1,1);
           plot(fft_drive1_gyro(:,1).',fft_drive1_gyro(:,[2:end]));
           legend('X','Y','Z');
           title(strcat('FFT of Drive1 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            subplot(2,1,2);
           plot(fft_drive2_gyro(:,1).',fft_drive2_gyro(:,[2:end]));
           legend('X','Y','Z');
           title(strcat('FFT of Drive2 action for ', char(plot_order(1,col))));
            xlabel('f (Hz)')
            ylabel('|P1(f)|') 
    end
end