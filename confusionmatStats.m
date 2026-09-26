function stats = confusionmatStats(group,grouphat)
% INPUT
% group = true class labels
% grouphat = predicted class labels
%
% OR INPUT
% stats = confusionmatStats(group);
% group = confusion matrix from matlab function (confusionmat)
%
% OUTPUT
% stats is a structure array
% stats.confusionMat
%               Predicted Classes
%                    p'    n'
%              ___|_____|_____| 
%       Actual  p |     |     |
%      Classes  n |     |     |
%
% stats.accuracy = (TP + TN)/(TP + FP + FN + TN) ; the average accuracy is returned
% stats.precision = TP / (TP + FP)                                      % for each class label
% stats.sensitivity = TP / (TP + FN)                                    % for each class label
% stats.specificity = TN / (FP + TN)                                    % for each class label
% stats.recall = sensitivity                                            % for each class label
% stats.Fscore = 2*TP /(2*TP + FP + FN)                                 % for each class label
% stats.mcc = ((TP*TN) - (FP*FN))/(sqrt((TP+FP)(TP+FN)(TN+FP)(TN+FN)))  % for each class label
% mcc - Mathews Correlation Coefficient.

% TP: true positive, TN: true negative, 
% FP: false positive, FN: false negative
% 

field1 = 'confusionMat';
if nargin < 2
    value1 = group;
else
    [value1,gorder] = confusionmat(group,grouphat);
end
value1 = value1';
numOfClasses = size(value1,1);
totalSamples = sum(sum(value1));

[TP,TN,FP,FN,accuracy,sensitivity,specificity,precision,f1_score] = deal(zeros(numOfClasses,1));
for class = 1:numOfClasses
   TP(class) = value1(class,class);
   tempMat = value1;
   tempMat(:,class) = []; % remove column
   tempMat(class,:) = []; % remove row
   TN(class) = sum(sum(tempMat));
   FP(class) = sum(value1(class,:))-TP(class);
   FN(class) = sum(value1(:,class))-TP(class);
end

accuracy = trace(value1) / totalSamples;
classificationerror = [sum(sum(value1)) - trace(value1)]/ totalSamples;

for class = 1:numOfClasses
    idaccuracy(class) = (TP(class) + TN(class))/(TP(class) + FP(class) + FN(class) + TN(class));
    sensitivity(class) = TP(class) / (TP(class) + FN(class));
    specificity(class) = TN(class) / (FP(class) + TN(class));
    precision(class) = TP(class) / (TP(class) + FP(class));
    f1_score(class) = 2*TP(class)/(2*TP(class) + FP(class) + FN(class));
    mcc(class) = ((TP(class)*TN(class))-(FP(class)*FN(class)))/(sqrt((TP(class)+FP(class))*(TP(class)+FN(class))*(TN(class)+FP(class))*(TN(class)+FN(class))));
end

TotTP = sum(TP);
TotFP = sum(FP);
TotFN = sum(FN);
MicroF1_score = 2*TotTP/(2*TotTP + TotFP + TotFN);

MacroF1_score = mean(f1_score);

weight = sum(value1');

totf1 = 0;
for class = 1:numOfClasses
    totf1 = totf1 + (f1_score(class) * weight(class));
end
weightedF1_score = totf1/sum(weight);

Mean_mcc = mean(mcc);

field2 = 'accuracy';  value2 = accuracy;
field3 = 'sensitivity';  value3 = sensitivity;
field4 = 'specificity';  value4 = specificity;
field5 = 'precision';  value5 = precision;
field6 = 'ClassificationError';  value6 = classificationerror;
field7 = 'F1score';  value7 = f1_score;
field8 = 'MicroF1score';  value8 = MicroF1_score;
field9 = 'MacroF1score';  value9 = MacroF1_score;
field10 = 'WeightedF1score';  value10 = weightedF1_score;
field11 = 'Mathews_Corrcoef'; value11 = mcc;
field12 = 'Mean_MCC'; value12 = Mean_mcc;
field13 = 'Id_accuracy'; value13 = idaccuracy;
stats = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7,field8,value8,field9,value9,field10,value10,field11,value11,field12,value12,field13,value13);
% if exist('gorder','var')
%     stats = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7,'groupOrder',gorder);
end
    