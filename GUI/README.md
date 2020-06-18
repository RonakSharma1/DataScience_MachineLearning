# Aim
Generate Pareto-Optimal Solutions for surface metrology parameters  (i.e. force, vibration and temperature), that are required to achieve the desired surface roughness of a manufactured product.

#  Setup/Installation
1 .Install MATLAB2016b or above
2. Run 'SurfaceMetrology.mlapp' file
3. Follow the procedure below

# Procedure
1. Load Training Data: Press this if you have new data to train the seven ANFIS models. For starters, you can use 'InputData.mat'(Nine Featured Dataset)
2. Train Model: Press this to train the models with the new dataset
3. Sa Target Value: The target surface roughness value, you desire to achieve. Range is limited between (0.35 and 0.61). Choose any value between this range
4. Optimise: Press this to produce an excel sheet containing the optimal input values of force vibration and temperature. Multiple solution sets are presented. Each row contains a solution set.

# GUI Snapshot
![GUI](https://user-images.githubusercontent.com/34181525/85017093-d532a980-b162-11ea-8e85-1e42e5ec62db.png)

# General Information
1. Training Data - 'InputData.mat' (Nine Features: Check Presentation). This dataset had to be created. This involved data cleaning and analysis. The raw vibration and force data in X,Y and Z axes was used to perform data mining.
2. Trains seven pre designed ANFIS Models(These were designed from scratch by author using this training data)

# Errors
You can ignore any warning that MATLAB throws. This is because of the version of the file that I had uploaded to GitHub. If you struggle, please feel free to email me.