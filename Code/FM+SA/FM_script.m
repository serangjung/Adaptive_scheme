clear all
clc
addpath('.\FM_core_script')
addpath(genpath('.\TMM'))
addpath('.\materials')

input.optimizer='FM_Digit'; % 'FM_digit' : Factorization Machine
input.type='Digit';

input.filename_header='adaptive_scheme_intial_data'; %projectname 
input.FOM_script='adaptive_scheme_FOM'; %filename of TMM script, the name can be changed: you can edit the way you want. =

% binary vector length
input.number_of_variables=46; % The number of input variables to the FM surrogate function
% Optimization Options

input.fm_optimizer='simulated_annealing';
input.global_optimization_options=[2,46]; 

input.number_of_batches=1; % The number of training batches
input.number_of_initial_dataset=25; % The number of initial training dataset

input.ratio_of_cross_validation_set=0.2; % The ratio assigned to the cross-validation-set in dataset 
input.sampling_tag=100;
input.csv_mode='on';
input.number_of_optimization_cycles=3000; % The number of optimization cycles per batches with the initial dataset 

%%%%
outputlog=ml_opt_main_SWA(input);
%%%%

