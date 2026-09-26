%Classification using SVM 

clc;
clear all;
close all;

load trainm.mat;
load testm.mat;


%%  Train ECOC-SVM Classifier with Training Set Features and Targets

t = templateSVM('KernelFunction','rbf');     %Linear - 89.583, polynomial - 95.833

Mdl = fitcecoc(train_datam, train_targetm, 'Learners',t)
                                                                           %    ECOC-SVM Classifier Model
%cvmdl = crossval(Mdl);
                                                                           %    ECOC-SVM Classifier Cross-Validation Model
%cvmdloss = kfoldLoss(cvmdl);
                                                                           %    Computation of Cross-Validation Loss

%%  Test the Trained ECOC-SVM Classfier Model with Testing Set Features and Targets and Evaluate the Classification (Prediction or Recognition) Performance

predict_label = predict(Mdl, test_datam);
                                                                           %    Testing of Classifier Model (Prediction)

plotconfusion(test_targetm,predict_label)


Evaluation_results = confusionmatStats(test_targetm, predict_label); 


