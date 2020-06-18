function [meanValue,standardDeviation] = runANFISModel(testingData)
%% INITIALISATION
load('fis1.mat')
load('fis2.mat')
load('fis3.mat')
load('fis4.mat')
% load('fis5.mat')
load('fis6.mat')
load('fis7.mat')
addpath('/Users/ronaksharma/Desktop/ACS 6420/Metrology MATLAB Data/MATLAB Code')
addpath('/Users/ronaksharma/Desktop/ACS 6420/Metrology MATLAB Data/readTDMS')
%% NORMALISATION BETWEEN 0 AND 1
range = max(testingData) - min(testingData);
testingData = (testingData - min(testingData))./range;
zeroMatrix=zeros(1,9);
testingData=[testingData;zeroMatrix]; % Appending PCA matrix with Zero as you need a minimum matrix to do a PCA
data_Coff_Vibration=pca(testingData(:,1:4));
data_Coff_Force=pca(testingData(:,5:8));
PCA_Vibration=data_Coff_Vibration(1,1).*(testingData(:,1)) + (testingData(:,2).*(data_Coff_Vibration(2,1)))+(testingData(:,3).*(data_Coff_Vibration(3,1)))+(testingData(:,4).*(data_Coff_Vibration(4,1)));
PCA_Force=data_Coff_Force(1,1).*(testingData(:,5)) + (testingData(:,6).*(data_Coff_Force(2,1)))+(testingData(:,7).*(data_Coff_Force(3,1)))+(testingData(:,8).*(data_Coff_Force(4,1)));
% COMBINING DATA
input=[PCA_Vibration,PCA_Force,testingData(:,9)];
%% ANFIS MODEL
temp_anfis_output1=evalfis(input,fis1);
temp_anfis_output2=evalfis(input,fis2);
temp_anfis_output3=evalfis(input,fis3);
temp_anfis_output4=evalfis(input,fis4);
% temp_anfis_output5=evalfis(input,fis5);
temp_anfis_output6=evalfis(input,fis6);
temp_anfis_output7=evalfis(input,fis7);
temp_anfis_output=[temp_anfis_output1,temp_anfis_output2,temp_anfis_output3,temp_anfis_output4,temp_anfis_output6,temp_anfis_output7];
%% FUNCTION OUTPUT
temp_anfis_output_mean=mean(temp_anfis_output);
temp_standardDeviation=std(temp_anfis_output);

%% CALCULATING MEAN AND STANDARD DEVIATION
meanValue=temp_anfis_output_mean(1);
standardDeviation=temp_standardDeviation(1);

%% ARCHIVE
% load('inputValues')
% i=1;
% while(i<38)
% x=inputValues(i);
% temp=applyOptimisation(x);
% output(i)=getMeanSaValue(temp);
% i=i+1;
% end