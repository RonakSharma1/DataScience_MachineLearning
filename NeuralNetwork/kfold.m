function [Correlation_Value] = kfold(k,training_data,training_data_output)
training_data_kfold=training_data;
n=size(training_data_kfold,1); % Size of training data
nf=fix(n/k); % smallest integer such that k*nf<=n
mfType = char('gaussmf','gaussmf','gaussmf');
numMFs = [2 2 2];
outputMf='constant';
EpochNumber=30;

for ii=1:k 
    if ii<k
        exc=(ii-1)*nf+1 : ii*nf; % Creating the training data per fold
    else
        exc=(ii-1)*nf+1 : n; % Creating the testing data per fold
    end
    inc=setdiff(1:n,exc); % Creating the training data per fold 
    % Training the model
    fis1 = genfis1(training_data_kfold(inc,:),numMFs,mfType,outputMf);
    fis1=anfis(training_data_kfold(inc,:),fis1,EpochNumber);
    testing_data=training_data_kfold(exc,:);    
    anfis_output=evalfis(testing_data(:,1:3),fis1);
    %training_output_kfold=PCA_Data(:,3);
    training_output_kfold=training_data_output;
    corr_training=[training_output_kfold(exc,:),anfis_output];
  
    temp_training=corrcoef(corr_training);
    Correlation_Value(ii)=temp_training(1,2); 
end

