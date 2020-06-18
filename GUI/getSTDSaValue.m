function [SD_Sa_Target] = getSTDSaValue(optimisationData)
    [~,SD_Sa_Target]=runANFISModel(optimisationData);
    
