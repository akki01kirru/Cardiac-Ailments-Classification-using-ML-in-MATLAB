%Classification using KNN 

clc;
clear all;
close all;

load trainm.mat;
load testm.mat;


Mdl = fitcknn(train_datam, train_targetm, 'NumNeighbors',65)
                  
%cvmdl = crossval(Mdl);
                                                                           %    K-NN Classifier Cross-Validation Model
%cvmdloss = kfoldLoss(cvmdl);
                                                                           %    Computation of Cross-Validation Loss
predict_label = predict(Mdl, test_datam);

plotconfusion(test_targetm,predict_label)

Evaluation_results = confusionmatStats(test_targetm, predict_label);           


