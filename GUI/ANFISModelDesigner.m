function [fis] = ANFISModelDesigner(training_data,MFType)
%% CREATING THE MODEL
mfType = char(MFType,MFType,MFType);
numMFs = [2 2 2];
outputMf='constant';  % Using liner degrades the performance
fis = genfis1(training_data,numMFs,mfType,outputMf);