%% INITIALISAION
Sa_Target=0.43;

%% MULTI OBJECTIVE OPTIMISATION
SD_Estimate=1000;
objective = @(x)[((Sa_Target-getMeanSaValue(x))/Sa_Target)^2,(getSTDSaValue(x)/SD_Estimate)^2];

%% SINGLE OBJECTIVE OPTIMISATION
% objective = @(x)(Sa_Target-getMeanSaValue(x))^2;

%% INITIALISATION
nvars = 9;    % Number of variables
% LB = [0 0 0 0 0 0 0 0 100];  % Lower bound
% UB = [];  % Upper bound
LB = [0 0 0 0 50 50 50 50 200];   % Lower bound
UB = [2 2 2 2 400 400 400 400 800];  % Upper bound
%% PARALLEL COMPUTING SETUP
if max(size(gcp)) == 0 % parallel pool needed
    parpool % create the parallel pool
end

%% MULTIOBJECTIVE GA OPTIMISATION: MODIFY THESE PARAMETERS TO CHANGE OPTIMISATION APPROACH
rng default % to get the same evaluations as the previous run
ObjectiveFunction = objective;
options = optimoptions('gamultiobj','PlotFcn',@gaplotpareto,'MaxGenerations',7,'PopulationSize',20,'Display','iter','UseParallel',true);
% options = optimoptions('gamultiobj','MaxGenerations',7,'PopulationSize',20,'Display','iter','UseParallel',true);
predictedInputValue= gamultiobj(ObjectiveFunction,nvars,[],[],[],[],LB,UB,options);

%% SINGLE OBJECTIVE GA OPTIMISATION MODIFY THESE PARAMETERS TO CHANGE OPTIMISATION APPROACH
% rng default % to get the same evaluations as the previous run
% ObjectiveFunction = objective;
% options = optimoptions('ga','MaxGenerations',7,'PopulationSize',20,'Display','iter','UseParallel',true);
% predictedInputValue= ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB,[],options);
% save('result.mat')
%% EXCEL File Generation
x1=predictedInputValue;
Vibration_RMSOp1 =x1(:,1);
Vibration_MeanOp1 =x1(:,2);
Vibration_RMSOp2 =x1(:,3);
Vibration_MeanOp2 =x1(:,4);
Force_RMSOp1=x1(:,5);
Force_MeanOp1=x1(:,6);
Force_RMSOp2=x1(:,7);
Force_MeanOp2=x1(:,8);
Temperature_Kelvin=x1(:,9);
T = table(Vibration_RMSOp1,Vibration_MeanOp1,Vibration_RMSOp2,Vibration_MeanOp2,Force_RMSOp1,Force_MeanOp1,Force_RMSOp2,Force_MeanOp2,Temperature_Kelvin);
writetable(T,'Predicted_Surface_Parameters.xls')

%% ARCHIVE
%% SINGLE OBJECTIVE SA OPTIMISATION
% ObjectiveFunction = objective;
% x0 = [1 1 1 1 65 65 65 65 400];    % Number of variables
% options = optimoptions('simulannealbnd','MaxIterations',50);
% predictedInputValue= simulannealbnd(ObjectiveFunction,x0,LB,UB,options);
%% SINGLE OBJECTIVE PSO OPTIMISATION
% ObjectiveFunction = objective; 
% options = optimoptions('particleswarm','SwarmSize',20,'MaxIterations',7);
% predictedInputValue= particleswarm(ObjectiveFunction,nvars,LB,UB,options);