%% REDUCING DIMENSIONALITY BY PCA/LDA
load('InputData.mat')
%% ADDING NORMLIASED TEMPERING TEMPERATURE TO THE INPUT
tempering_temperature=[250;650;650;450;650;450;650;450;550;650;450;650;450;650;450;450;650];
InputData=[InputData(:,1:8),tempering_temperature,InputData(:,9)];

Randomised_InputData = InputData(randperm(size(InputData, 1)), :);
Output_Data=Randomised_InputData(:,10);
Randomised_InputData(:,10)=[];
%% NORMALISATION BETWEEN 0 AND 1
range = max(Randomised_InputData) - min(Randomised_InputData);
Randomised_InputData = (Randomised_InputData - min(Randomised_InputData))./range;  
Randomised_InputData=[Randomised_InputData,Output_Data];

%% PCA
data_Coff_Vibration=pca(Randomised_InputData(:,1:4));
data_Coff_Force=pca(Randomised_InputData(:,5:8));
PCA_Vibration=data_Coff_Vibration(1,1).*(Randomised_InputData(:,1)) + (Randomised_InputData(:,2).*(data_Coff_Vibration(2,1)))+(Randomised_InputData(:,3).*(data_Coff_Vibration(3,1)))+(Randomised_InputData(:,4).*(data_Coff_Vibration(4,1)));
PCA_Force=data_Coff_Force(1,1).*(Randomised_InputData(:,5)) + (Randomised_InputData(:,6).*(data_Coff_Force(2,1)))+(Randomised_InputData(:,7).*(data_Coff_Force(3,1)))+(Randomised_InputData(:,8).*(data_Coff_Force(4,1)));
%% COMBINING DATA
PCA_Data=[PCA_Vibration,PCA_Force,Randomised_InputData(:,9:10)];
training_size=13;  % Reducing the number of data points significantly drops the performance
training_data=PCA_Data(1:training_size,:);
testing_data=PCA_Data((training_size+1):end,:);
input=PCA_Data(:,1:3);
training_data_output=training_data(:,4);
testing_data_output=testing_data(:,4);

%% ANFIS MODELLING
% CREATING ANFIS MODEL
fis1=ANFISModelDesigner(training_data,'gaussmf');
fis2=ANFISModelDesigner(training_data,'gauss2mf');
fis3=ANFISModelDesigner(training_data,'gbellmf');
fis4=ANFISModelDesigner(training_data,'trimf');
% fis5=ANFISModelDesigner(training_data,'trapmf');
fis6=ANFISModelDesigner(training_data,'dsigmf');
fis7=ANFISModelDesigner(training_data,'psigmf');

% TRAINING ANFIS MODEL
EpochNumber=10;
fis1=anfis(training_data,fis1,EpochNumber);
fis2=anfis(training_data,fis2,EpochNumber);
fis3=anfis(training_data,fis3,EpochNumber);
fis4=anfis(training_data,fis4,EpochNumber);
% fis5=anfis(training_data,fis5,EpochNumber);
fis6=anfis(training_data,fis6,EpochNumber);
fis7=anfis(training_data,fis7,EpochNumber);

%% CORRELATION CALCULATION
temp_anfis_output1=evalfis(input,fis1);
temp_anfis_output2=evalfis(input,fis2);
temp_anfis_output3=evalfis(input,fis3);
temp_anfis_output4=evalfis(input,fis4);
% temp_anfis_output5=evalfis(input,fis5);
temp_anfis_output6=evalfis(input,fis6);
temp_anfis_output7=evalfis(input,fis7);

corr_testing1=[testing_data_output,temp_anfis_output1((training_size+1):end,:)];
corr_testing2=[testing_data_output,temp_anfis_output2((training_size+1):end,:)];
corr_testing3=[testing_data_output,temp_anfis_output3((training_size+1):end,:)];
corr_testing4=[testing_data_output,temp_anfis_output4((training_size+1):end,:)];
% corr_testing5=[testing_data_output,temp_anfis_output5((training_size+1):end,:)];
corr_testing6=[testing_data_output,temp_anfis_output6((training_size+1):end,:)];
corr_testing7=[testing_data_output,temp_anfis_output7((training_size+1):end,:)];

corr_result1=corrcoef(corr_testing1);
corr_result2=corrcoef(corr_testing2);
corr_result3=corrcoef(corr_testing3);
corr_result4=corrcoef(corr_testing4);
% corr_result5=corrcoef(corr_testing5);
corr_result6=corrcoef(corr_testing6);
corr_result7=corrcoef(corr_testing7);

%% SAVING ANFIS MODELS
save('fis1.mat','fis1')
save('fis2.mat','fis2')
save('fis3.mat','fis3')
save('fis4.mat','fis4')
% save('fis5.mat','fis5')
save('fis6.mat','fis6')
save('fis7.mat','fis7')