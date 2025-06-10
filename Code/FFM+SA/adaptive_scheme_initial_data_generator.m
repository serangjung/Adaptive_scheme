clear all
number_of_pixels=40; 
num_row = number_of_pixels + 6; %add bits for thickness 

for ttn=1:2   
        token=25;
        for it=1:1:token
            %set the range according to saturation 
            qv_random=randi([0,1],num_row,1); % you need to delete this line if you would like to use this script as a function
            clear qv_ii; % you need to delete this line if you would like to use this script as a function
            % you need to delete this line if you would like to use this script as a function
            qv_ii_array(it,:)=qv_random;

            [Figure_of_merit] = adaptive_scheme_FOM(qv_ii_array(it,:));
            % Figure of merit
            FOM(it)=(Figure_of_merit);
            qv_text=sprintf('%d',qv_ii_array(it,:));          
            display(sprintf('Itn:%d qv_i:%s FOM:%0.4e',it,qv_text,FOM(it)))
            clear qv_text;
        end
eval(sprintf('save adaptive_scheme_initial_data_%d_%d_%d qv_ii_array FOM',ttn,num_row,token)); 
end

           
