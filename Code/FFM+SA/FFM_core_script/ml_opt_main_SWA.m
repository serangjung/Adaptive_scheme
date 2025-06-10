function output=ml_opt_main_SWA(input)
if strcmp(input.optimizer,'Direct')==1
           
        %output=ml_opt_per_batch_direct(input);
        display('not supported');
elseif strcmp(input.type,'Digit')==1
    
    number_of_batches=input.number_of_batches; % The number of initial training batches

    for ttn=1:number_of_batches
        close all
        output(ttn)=ml_opt_per_batch_digit_FFM_JSR(input,ttn);
    end

else

        display('not supported');
end