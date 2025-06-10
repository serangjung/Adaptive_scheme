% Perform optimizer
if strcmp(optimizer,'BO')==1
    display('not supported')
elseif strcmp(optimizer,'BO_Digit')==1
    
elseif strcmp(optimizer,'FCNN')==1
    % FCNN: Neural Network with Pytorch to obtain the optimal vector
    display('not supported')

elseif strcmp(optimizer,'FCNN_Digit')==1
    % FCNN: Neural Network with Pytorch to obtain the optimal vector
    
    display('not supported')

elseif strcmp(optimizer, 'FM')==1
    % FM: Factorization Machine with Xlearn to obtain the optimal vector
    
    display('not supported')

elseif strcmp(optimizer, 'FM_Digit')==1
    ml_opt_FM_optimizer_JSR
end 