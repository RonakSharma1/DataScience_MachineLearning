function [mean_Sa_Target] = getMeanSaValue(optimisationData)
    [mean_Sa_Target,~]=runANFISModel(optimisationData);
    
