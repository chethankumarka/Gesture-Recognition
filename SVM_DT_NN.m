close all; clear all; clc;
x_train = importdata('Data2/X_train.mat');
y_train = importdata('Data2/y_train.mat');
x_test = importdata('Data2/X_test.mat');
y_test = importdata('Data2/y_test.mat');
%%% SVM with Gaussian kernel with parameter 1 %%%
labels=zeros(size(x_test,1),size(y_train,2));

model_svm = fitcsvm(x_train, y_train, 'KernelFunction', 'Gaussian', 'KernelScale', 'auto');
labels_svm = predict(model_svm, x_test);
%%% Decision Tree
model_dt=fitctree(x_train,y_train);
labels_dt = predict(model_dt,x_test);
% Neural Network
%net = fitnet(10,'trainbr');
%net = train(net,x_train);
%y = net(x_test);

%%% Calculation of Precesion, Recall, F1 score and accuracy for SVM
accuracy =0;sensitivity=0;specificity=0;f_score=0;
TP=0;TN=0;FP=0;FN=0;
[confumatrix,gorder] = confusionmat(y_test,labels_svm);



TN = confumatrix(1,1);
TP = confumatrix(2,2);
FP = confumatrix(1,2);
FN = confumatrix(2,1);


 accuracy = (TP + TN) / sum(sum(confumatrix));
 recall = TP / (TP + FN);
 specificity = TN / (FP + TN);
 precision = TP / (TP + FP);
 f_score = 2*TP/(2*TP + FP + FN);

fprintf('SVM with Gaussian kernel, Precision = %.4f ,Accuracy = %.4f, Recall =  %.4f, f_score = %.4f    ',precision,accuracy,recall,f_score);

%%% Calculation of Precesion, Recall, F1 score and accuracy for Decision
%%% Tree
accuracy =0;sensitivity=0;specificity=0;f_score=0;
TP=0;TN=0;FP=0;FN=0;
[confumatrix,gorder] = confusionmat(y_test,labels_dt);



TN = confumatrix(1,1);
TP = confumatrix(2,2);
FP = confumatrix(1,2);
FN = confumatrix(2,1);


 accuracy = (TP + TN) / sum(sum(confumatrix));
 recall = TP / (TP + FN);
 specificity = TN / (FP + TN);
 precision = TP / (TP + FP);
 f_score = 2*TP/(2*TP + FP + FN);

fprintf('\nDecision Tree, Precision = %.4f ,Accuracy = %.4f, Recall =  %.4f, f_score = %.4f    ',precision,accuracy,recall,f_score);

%%%% Phase 3 %%%%

fprintf('\n\n------------------------Phase 3 ------------------------\n\n');
x_train_ph3 = importdata('Data2/X_train_Phase3.mat');
y_train_ph3 = importdata('Data2/y_train_Phase3.mat');
x_test_ph3 = importdata('Data2/X_test_Phase3.mat');
y_test_ph3 = importdata('Data2/y_test_Phase3.mat');

%%% SVM with Gaussian kernel with parameter 1 %%%
labels=zeros(size(x_test_ph3,1),size(y_train_ph3,2));

model_svm = fitcsvm(x_train_ph3, y_train_ph3, 'KernelFunction', 'Gaussian', 'KernelScale', 'auto');
labels_svm = predict(model_svm, x_test_ph3);
%%% Decision Tree
model_dt=fitctree(x_train_ph3,y_train_ph3);
labels_dt = predict(model_dt,x_test_ph3);
% Neural Network
%net = fitnet(10,'trainbr');
%net = train(net,x_train);
%y = net(x_test);

%%% Calculation of Precesion, Recall, F1 score and accuracy for SVM
accuracy =0;sensitivity=0;specificity=0;f_score=0;
TP=0;TN=0;FP=0;FN=0;
[confumatrix,gorder] = confusionmat(y_test_ph3,labels_svm);



TN = confumatrix(1,1);
TP = confumatrix(2,2);
FP = confumatrix(1,2);
FN = confumatrix(2,1);


 accuracy = (TP + TN) / sum(sum(confumatrix));
 recall = TP / (TP + FN);
 specificity = TN / (FP + TN);
 precision = TP / (TP + FP);
 f_score = 2*TP/(2*TP + FP + FN);

fprintf('SVM with Gaussian kernel, Precision = %.4f ,Accuracy = %.4f, Recall =  %.4f, f_score = %.4f    ',precision,accuracy,recall,f_score);

%%% Calculation of Precesion, Recall, F1 score and accuracy for Decision
%%% Tree
accuracy =0;sensitivity=0;specificity=0;f_score=0;
TP=0;TN=0;FP=0;FN=0;
[confumatrix,gorder] = confusionmat(y_test_ph3,labels_dt);



TN = confumatrix(1,1);
TP = confumatrix(2,2);
FP = confumatrix(1,2);
FN = confumatrix(2,1);


 accuracy = (TP + TN) / sum(sum(confumatrix));
 recall = TP / (TP + FN);
 specificity = TN / (FP + TN);
 precision = TP / (TP + FP);
 f_score = 2*TP/(2*TP + FP + FN);

fprintf('\nDecision Tree, Precision = %.4f ,Accuracy = %.4f, Recall =  %.4f, f_score = %.4f    ',precision,accuracy,recall,f_score);

