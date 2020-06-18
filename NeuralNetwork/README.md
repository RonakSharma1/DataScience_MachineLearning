# Aim
Using the Nine Input Features(force, vibration and temperature), determine the optimal ANFIS based model. This model was to predict the surface roughness of a manufactured product, using the Nine features

# Background
It was decided to use Force, Vibration and Temperature values for training the model, based on the extensive data analysis performed to understand the relationship between the inputs features and output (surface roughness)

# Setup/Installation
1. Install MATLAB 2016b or above
2. Execute 'createANFISModelCmdLine.m'

# Operation
1. Loop that runs ten times to randomise the training data by swapping rows. This provides a diverse training data
2. The Nine features are normalised b/w 0 and 1 to ensure equal weights during modelling
3. Due to a low sample size of 17 samples, PCA is applied to convert Nine Input features to 3 Input Featured dataset (PCA_Data.mat) 
4. A 3 Input 1 Output Model is created. Parameters like MF type, number of MFs and epoch number can be modified to determine the optimal model
5. RMSE and Correlation are used as Performance Indices. These were calculated in each run
6. For each run, 4-Fold Cross Validation is also performed
