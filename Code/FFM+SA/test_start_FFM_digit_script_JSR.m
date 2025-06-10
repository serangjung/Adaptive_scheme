% 
% # -*- coding: utf-8 -*-
% 
% Created on Mon Jul 31 17:34:53 2023
% 
% @author: Sangwoo An 
% 
% function : 
% 
% this is final version for release 
% feel free to ask me in detail 
% 
% e-mail : sang-wooahn@khu.ac.kr
%
%

clear all
clc
addpath('.\FM_core_script')
addpath('.\PML\PML_code_20221111\PML_code')
addpath('.\TMM_file')

input.optimizer='FFM_Digit'; % 'FM_digit' : Factorization Machine
input.type='Digit';

input.filename_header='TEST_ebeam'; %projectname
input.FOM_script='nano_IRAR_script_weight_factor_ebeam'; %filename of TMM script, the name can be changed: you can edit the way you want. =

% binary vector length
input.number_of_variables=24; % The number of input variables to the FM surrogate function
% Optimization Options

input.fm_optimizer='simulated_annealing'; %tensor_brute_force %quantum_annealing
input.global_optimization_options=[2,24]; % for tensor_brute_force, [state level, size of junk], State level: 2 = binary, Junk size = n ==> 2^n for a single junk
%input.fm_optimizer='simulated_annealing'; %simulated_annealing

input.number_of_batches=2; % The number of training batches
input.number_of_initial_dataset=25; % The number of initial training dataset

input.ratio_of_cross_validation_set=0.2; % The ratio assigned to the cross-validation-set in dataset 
input.sampling_tag=100;
input.csv_mode='on';
input.number_of_optimization_cycles=5; % The number of optimization cycles per batches with the initial dataset 

%%%%
outputlog=ml_opt_main_SWA(input);
%%%%

