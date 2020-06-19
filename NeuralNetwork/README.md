# Aim
Using the Nine Input Features i.e. force, vibration and temperature predict the surface roughness of a manufactured product. An ANFIS(Artificial Neural Network Fuzzy Inference System) based model was designed to achieve this.

# Background
It was decided to use Force, Vibration and Temperature values for training the model, based on the extensive data analysis performed to understand the relationship between the inputs features and output (surface roughness)

# Setup/Installation
1. Install MATLAB 2016b or above
2. Execute 'createANFISModelCmdLine.m'

# Operation
1. Loop that runs ten times to randomise the training data by swapping rows. This provides a diverse training data
2. The Nine features are normalised b/w 0 and 1 to ensure equal weights during modelling
3. Due to a low sample size of 17 samples, PCA is applied to convert Nine Input features to 3 Input Featured dataset (PCA_Data.mat) 
4. A 3 Input 1 Output Model is created. Parameters like type and number of Membership Functions and epoch number can be modified to produce the optimal model
5. Root Mean Squared Error(RMSE) and Correlation values were used as Performance Indices. These were calculated in each run
6. For each run, 4-Fold Cross Validation was also performed
