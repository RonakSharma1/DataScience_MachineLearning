function [Statistical_Features] = readVibrationData(dataName)
%% Collecting the TDMS Data
[currentVibrationData,metaStruct]= TDMS_readTDMSFile(dataName);
finalData=currentVibrationData.data;
%% CHOOSING AN APPROPRIATE SAMPLE SIZE
% The rest of the sample sizes were ignored as they were sampled at a
% slower rate, thus loosing information
cDAQ1Mod1_X=finalData(3); % X
cDAQ1Mod1_Y=finalData(4);% Y 
cDAQ1Mod1_Z=finalData(5);% Z 
%% CONVERT TO ARRAY
% Removed the command for taking an average of all the values like in
% (x+y+z)/3
cDAQ1Mod1_X = cell2mat(cDAQ1Mod1_X);
cDAQ1Mod1_Y = cell2mat(cDAQ1Mod1_Y);
cDAQ1Mod1_Z = cell2mat(cDAQ1Mod1_Z);

%% COMBINING X,Y AND Z AXIS DATA
% Removed the correlation for average axis value
cDAQ1Mod1_X=cDAQ1Mod1_X'; % X
cDAQ1Mod1_Y=cDAQ1Mod1_Y';% Y 
cDAQ1Mod1_Z=cDAQ1Mod1_Z';% Z
cDAQ1Mod1_final=[cDAQ1Mod1_X,cDAQ1Mod1_Y,cDAQ1Mod1_Z];

%% PCA IMPLEMENTATION
% Rows of PCA_Coff defines the corresponding Principal Components
PCA_Coff=pca(cDAQ1Mod1_final);
PCA_Vibration=PCA_Coff(1,1).*(cDAQ1Mod1_X) + (cDAQ1Mod1_Y.*(PCA_Coff(2,1)))+(cDAQ1Mod1_Z.*(PCA_Coff(3,1)));

%% NORMALISATION BETWEEN 0 AND 1 
 range = max(PCA_Vibration) - min(PCA_Vibration);
 PCA_Normalised_Data = (PCA_Vibration - min(PCA_Vibration)) / range; % Normalised between 0 and 1
% % PCA_Normalised_Data = (2 * PCA_Normalised_Data) - 1; %Normliased between -1 and 1
%% Calculating RMSE and Mean
Mean_Value=mean(PCA_Normalised_Data);
RMS_Value=rms(PCA_Normalised_Data);
Statistical_Features=[Mean_Value,RMS_Value];

%% CENTRING
% Putting mean to zero. Both PCA_Vibration and Remapped have a correlation
% of 1 and thus we can use this one insted of using the other older one
% PCA_Vibration_ReMap=PCA_Vibration-repmat(mean(PCA_Vibration),size(PCA_Vibration,1),1);
% PCA_Vibration_ReMap=PCA_Vibration_ReMap./repmat(std(PCA_Vibration_ReMap),size(PCA_Vibration_ReMap,1),1);

%% CORRELATION COEFFICIENT
%resultant_Vibration=[cDAQ1Mod1_final,PCA_Vibration_ReMap];
%R = corrcoef(resultant_Vibration);
% stats_PCA_Vibration=datastats(PCA_Vibration);

%% FILTERING THE DATA USING FILTER FUNCTION
% No more filtering the data as did not generate a good result

%% DIVIDE THE FINAL FUNCTION INTO BUCKETS AND TAKE THE AVERAGE OF THESE BUCKETS
% No more division into buckets as this led to duplicating the values of
% Sq. Hence a new approach is being looked into
%% -----------------------ARCHIVED WORK---------------------------------%%

%% FIRST: Probability Density Function
% Show the distribution of data. Which values occur the most or are
% repeated
% stats_cDAQ1Mod1_X=datastats(cDAQ1Mod1_X'); % Calculating the mean and median
% stats_cDAQ1Mod1_Y=datastats(cDAQ1Mod1_Y'); % Calculating the mean and median
% stats_cDAQ1Mod1_Z=datastats(cDAQ1Mod1_Z'); % Calculating the mean and median

% stats_test=datastats(Vibration_1');
% mean=Vibration_1.mean;
% std=Vibration_1.std;
% y=pdf('Normal',cDAQ1Mod1_X,mean,std);
% plot(cDAQ1Mod1_X,y);

%% SECOND

% stats_test=datastats(Vibration_1);
% mean=Vibration_1.mean;
% std=Vibration_1.std;
% y=pdf('Normal',Vibration_1,mean,std);
% plot(Vibration_1,y);

%% THIRD:Write the table to a CSV file
%csvwrite('cDAQ1Mod1_X.csv', cDAQ1Mod1_X')