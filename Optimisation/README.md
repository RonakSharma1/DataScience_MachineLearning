# Aim  
To optimise the ANFIS models produced in 'NeuralNetwork' folder for achieving the user entered surface roughness value. This involved reverse engineering the earlier developed ANFIS models. Due to non-linearity, these models were irreversible and thus 'optimisation' was applied for this purpose.

*Refer to 'Presentation.pdf' for a better understanding

**Note: Seven Pre trained ANFIS models are provided in this folder to execute these scripts. However, you can create you own models following the procedure described in 'NeuralNetwork' folder.

# Setup/Installation
Two methods for performing Multi-Objective Optimisation were explored in this project i.e. Method 1 and Method 2. Installation as follows:
1. Install MATLAB 2016b or above
2. Execute 'applyOptimisation.m' for Method 1 OR 'applyOptimisationUsingPenalty.m' for Method 2

## Method 1(applyOptimisation.m)
Used the MATLAB inbuilt tool called 'gamultiobj' to perform optimisation . This file also contains a commented out section that describes single-objective optimisation

## Method 2(applyOptimisationUsingPenalty.m)
This combined the multiple objectives into a single equation and assigned a weight to each of the objectives. Since each objective was normalised, hence the weights assigned to these objectives varied b/w 0 and 1

# General Information
1. This script computes the optimal values of the Nine Input features required for achieving the desired surface roughness of the manufactured product
2. The desired surface roughness value of the manufactured product can be modified using the variable 'Sa_Target'
3. The number of variables was set to 9 
4. The search space was restricted to search in positive domain as none of the features could have a negative value
4. Parallel Computing was used to fasten the optimisation process
5. The number of agents and iterations used for optimisation can be easily modified in the code
6. An excel sheet is created at the end containing the optimal solutions for the force, vibration and temperature
