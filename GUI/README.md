# Aim
Generate Pareto-Optimal solutions for surface metrology parameters  (i.e. force, vibration and temperature), that are required to achieve the desired surface roughness of a manufactured product.

#  Setup/Installation
1. Install MATLAB2016b or above
2. Run 'SurfaceMetrology.mlapp' file by just double clicking on it
3. Follow the procedure below

# Procedure
Note: A [video demonstration](https://drive.google.com/file/d/1DwhilSpGJ7m-QFqzESTuALE71QPhHa10/view?usp=sharing) has been provided as well 
1. Load Training Data: Press this if you have new data to train the seven ANFIS models. For starters, you can use the mock data i.e. 'InputData.mat'(Nine Featured Dataset)
2. Train Model: Press this to train the models with the new dataset
3. Sa Target Value: Enter the target surface roughness value, you desire to achieve. Range is limited between (0.25 and 0.61). Choose any value between this range
4. Optimise: Press this to produce an excel sheet containing the pareto-optimal input values of force, vibration and temperature. As expected, multiple solution sets are produced where each row in the excel sheet is a solution set.

# GUI Snapshot
![GUI](https://user-images.githubusercontent.com/34181525/85017093-d532a980-b162-11ea-8e85-1e42e5ec62db.png)

# General Information
1. Training Data - 'InputData.mat' (Nine Features: Check Presentation). This dataset had to be created which involved sanitising and then analysing the dataset. The raw vibration and force data in X,Y and Z axes was used to perform data mining
2. For the purpose of GUI demonstration, seven pre-designed ANFIS Models were trained. However, these were designed from scratch by the author using the real training data
