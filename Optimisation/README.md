# Aim  
To optimise the ANFIS models produced in 'NeuralNetwork' folder for achieving the user entered surface roughness value. These were optimised to essentially reverse engineer the ANFIS model. The ANFIS model was irreversible due to non-linearity and hence this approach was chosen. 

** Refer to 'Presentation' for a better understanding

** Note: Seven Pre trained model are provided in this folder to execute these scripts. However, you can create you own models following the procedure described in 'NeuralNetwork' folder.

# Setup/Installation
1. Install MATLAB 2016b or above
2. Execute 'applyOptimisation.m' for Method 1 OR 'applyOptimisationUsingPenalty.m' for Method 2

# Structure
This contains two ways of performing Multi-Objective Optimisation.

## Method 1
Uses the MATLAB inbuilt tool called 'gamultiobj' to perform this (applyOptimisation). This files also contains a commented out section describe single-objective optimisation

## Method 2
Combines the multiple objectives into a single equation and assigns weight to each of the objectives. Each objective was normalised and so the weights assigned to these objectives varied b/w 0 and 1. (applyOptimisationUsingPenalty)

* Note: For both Method 1 and 2, multiple optimisation techniques were implemented. These are attached at the end of each script in the archive section. By default they use Genetic Algorithm (GA) for optimisation

# Procedure
1. This scripts optimises for the Nine Input features required to achieve the desired surface roughness
2. The target surface roughness can be entered by user by modifying variable 'Sa_Target'
3. So number of variable was set to 9 and the search space was modified to search in positive domain as the values cannot be negative
4. Parallel Computing was used to fasten the optimisation process
5. Since GA was used by default, so the number of agents and number of iterations can be modified in the code
6. An excel sheet is created at the end containing the optimal solutions for the force vibration and temperature required to achieve the earlier entered surface roughness value