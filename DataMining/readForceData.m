function [Statistical_Features,R_Force,R_PCA] = readForceData(fileName)
%fileName='ForceB1Op1.csv';
%% DATA PATH
forceData = readtable(fileName, 'HeaderLines',20);

%% READING FORCE DATA AND SEPARATING INTO 3 AXIS DATA
Force_X=table2array(forceData(:,10));
Force_Y=table2array(forceData(:,11));
Force_Z=table2array(forceData(:,12));
Force_Components=[Force_X,Force_Y,Force_Z];
%% CORRELATION CALCULATION
R_Force=corrcoef(Force_Components);
%% APPLYING PCA ON FORCE
% PCA was applied as the 3 axis force data was highly correlated
PCA_Coff=pca(Force_Components);
PCA_Force=PCA_Coff(1,1).*(Force_X) + (Force_X.*(PCA_Coff(2,1)))+(Force_Z.*(PCA_Coff(3,1)));

%% NORMALISATION BETWEEN 0 AND 1 
range = max(PCA_Force) - min(PCA_Force);
PCA_Normalised_Data = (PCA_Force - min(PCA_Force)) / range; % Normalised between 0 and 1
%% CALCULATING MEAN AND RMS VALUE
Mean_Value=mean(PCA_Normalised_Data);
RMS_Value=rms(PCA_Normalised_Data);
Statistical_Features=[Mean_Value,RMS_Value];
%% ---------------------------ARCHIVE----------------------------%%

%% SECTION1: CHECK RESULTANT FORCE VALUE
%Resultant_Force=sqrt((Force_X.^2)+(Force_Y.^2)+(Force_Z.^2));