%% REDUCING DIMENSIONALITY BY PCA/LDA
load('InputData.mat')
k=4;
KFold_Correlation_Values=zeros(11,k);
%% ADDING NORMLIASED TEMPERING TEMPERATURE TO THE INPUT
tempering_temperature=[250;650;650;450;650;450;650;450;550;650;450;650;450;650;450;450;650];
InputData=[InputData(:,1:8),tempering_temperature,InputData(:,9)];
sum=0;
%% MAIN LOOP
for i=1:10 % In each run the input data is randomised by swapping rows thus diversifying the training dataset
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
    save('PCA_Data','PCA_Data')
    training_size=13;  % Reducing the number of data points significantly drops the performance
    training_data=PCA_Data(1:training_size,:);
    testing_data=PCA_Data((training_size+1):end,:);
    input=PCA_Data(:,1:3);
    training_data_output=training_data(:,4);
    testing_data_output=testing_data(:,4);
    
%% ANFIS MODELLING: LIST OF PARAMETERS MODIFIED TO DESIGN THE OPTIMAL MODEL THE BEST MODEL
    % CREATING THE MODEL
    mfType = char('gaussmf','gaussmf','gaussmf');
    numMFs = [2 2 2];
    outputMf='constant';  % Using liner degrades the performance
    fis1 = genfis1(training_data,numMFs,mfType,outputMf);
    
    % TRAINING THE MODEL
    EpochNumber=10;
    fis1=anfis(training_data,fis1,EpochNumber);
    
    % TESTING THE MODEL
    anfis_output=evalfis(input,fis1);
    
    %% CORRELATION
    corr_testing=[testing_data_output,anfis_output((training_size+1):end,:)];
    temp_testing=corrcoef(corr_testing);
    Testing_Correlation(i)=temp_testing(1,2);
    
    corr_training=[training_data_output,anfis_output(1:training_size,:)];
    temp_training=corrcoef(corr_training);
    Training_Correlation(i)=temp_training(1,2);
    
    if(Training_Correlation(i)<Testing_Correlation(i))
    sum=sum+1;
    end
    %% RMSE ERROR
    rmse_testing=sqrt(immse(testing_data_output,anfis_output((training_size+1):end,:)));
    RMSE_testing(i)=rmse_testing;
  
    rmse_training=sqrt(immse(training_data_output,anfis_output(1:training_size,:)));
    RMSE_training(i)=rmse_training;
    %% K-FOLD VALIDATION 

    Training_Correlation_Temp=kfold(k,training_data,training_data_output);
    KFold_Correlation_Values(i,:)=Training_Correlation_Temp;
    
end
%% COUNTING THE RUNS FOR WHICH THE MODEL ACHIEVED A CORRELATION > 0.7
good_Corr=find(Testing_Correlation>0.7);
count=size(good_Corr);
%% CORRELATION PLOT WITH RMSE VALUE
% x=0:1;
% y=0:1;
% figure(1)
% plot(x,y)
% hold on
% grid on
% scatter(testing_data_output,anfis_output((training_size+1):end,:))
% legend(sprintf('RMSE Value= %0.2f',rmse_testing),'location','northwest')
% xlabel('Observed Value')
% ylabel('Predicted Value')
% title('Testing Correlation Betweem Predicted and Observed Value')
% xlim([0 0.7])
% ylim([0 0.7])

% figure(2)
% plot(x,y)
% hold on
% grid on
% scatter(training_data_output,anfis_output(1:training_size,:))
% legend(sprintf('RMSE Value= %0.2f',rmse_training),'location','northwest')
% xlabel('Observed Value')
% ylabel('Predicted Value')
% title('Training Correlation Betweem Predicted and Observed Value')
% xlim([0 0.7])
% ylim([0 0.7])
%% CORRELATION PLOTS AND RMSE VALUE OF TESTING DATA
    % CORRELATION PLOT
%     corr_testing=[testing_data_output,anfis_output((training_size+1):end,:)];
%     corrplot(corr_testing,'varNames',{'Real','ANFIS'})
% %     
% %     % RMSE VALUE
%     rmse_testing=sqrt(immse(testing_data_output,anfis_output((training_size+1):end,:)));
%     disp(rmse_testing)

%% CORRELATION PLOTS AND RMSE VALUE OF TESTING DATA
% % CORRELATION PLOT
% corr_training=[training_data_output,anfis_output(1:training_size,:)];
% corrplot(corr_training,'varNames',{'Real','ANFIS'})
% 
% % RMSE VALUE
% rmse_training=sqrt(immse(training_data_output,anfis_output(1:training_size,:)));