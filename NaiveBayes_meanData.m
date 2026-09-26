%Classification using Naive Bayes Theorem

clc;
clear all;
close all;

load trainm.mat;
load testm.mat;

Mdl = fitcnb(train_datam, train_targetm, 'DistributionNames', 'kernel')

%cvmdl = crossval(Mdl);

%cvmdloss = kfoldLoss(cvmdl);
                                                                           
                                                                                                                                                     
predict_label = predict(Mdl, test_datam);

plotconfusion(test_targetm,predict_label)

Evaluation_results = confusionmatStats(test_targetm, predict_label);

