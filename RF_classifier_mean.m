%Classification using Random Forest - Ensembles Bagging Algorithm
% The use of NumVariablesToSample as all says the method bag is
% Random Forest algorithm

clc;
clear all;
close all;

load trainm.mat;
load testm.mat;

t = templateTree('Surrogate','on','NumVariablesToSample','all','MaxNumSplits',4)


Mdl = fitcensemble(train_datam, train_targetm, 'Method','Bag','Learners',t)

% cvmdl = crossval(Mdl);
                                                                           %    Fitcensemble Classifier Cross-Validation Model
% cvmdloss = kfoldLoss(cvmdl);
                                                                                                                                                    
predict_label = predict(Mdl, test_datam);

plotconfusion(test_targetm,predict_label)

Evaluation_results = confusionmatStats(test_targetm, predict_label);

