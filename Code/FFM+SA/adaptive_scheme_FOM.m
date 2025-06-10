function [FOM] = adaptive_scheme_FOM(input_vector) % if you need to change this script into function, you need to delete the symbol of '%'

addpath(genpath('./TMM'))
addpath("./materials")
load YF3_ref.mat
load Ge_ref.mat
load ZnS_ref.mat

%input_vector = [0 0 0 0 1 0 1 1 0 0];

% first 6 numbers = thickness.
% 0 = YF3
% 1 = Ge

% Design Parameters
digital_vector = input_vector(7:end);
num_digital_vector=length(digital_vector); % number of layers 

%thickness Parameters
num_layer=num_digital_vector;
thickness_vector = input_vector(1:6);
input_thickness = bin2dec(num2str(thickness_vector));
min_bound = 80; %minimum thickness = 80nm
thickness_resolution = 5; %5nm
thickness = min_bound + thickness_resolution*input_thickness;


um=1000; % 1000 nm
sampling_number=300;
wave_region=linspace(8, 13, sampling_number)*um; % nm, the wavelength of incident EM plane wave


% Estimation radiation efficiencies of the nanophotonic structure
for wn=1:sampling_number

    % Building-up Nanophotonic Structure
    substrate_upper=1; % we assume there is no-substrate
    substrate_mode='off'; % we assume there is no-substrate
    layer(1).upper=1; % upper medium Air
    for ln=1:num_layer

        if  digital_vector(ln)==0 
            layer(ln).material=interp1(YF3_ref.wave,YF3_ref.n,wave_region(wn))+1i*interp1(YF3_ref.wave,YF3_ref.k,wave_region(wn));
            layer(ln).thickness=thickness; %nm
            Layer_tag{ln}='YF3';

        elseif digital_vector(ln)==1
            layer(ln).material=interp1(Ge_ref.wave,Ge_ref.n,wave_region(wn));
            layer(ln).thickness=thickness;
            Layer_tag{ln}='Ge';
        end
    end
    layer(num_layer).down=interp1(ZnS_ref.wave,ZnS_ref.n,wave_region(wn)); % Glass
    wavelength=wave_region(wn);
    theta=0;

    which_pol='p-pol'; % the polarization of incident EM plane wave
    output=pml_cal_fun(layer, substrate_mode ,substrate_upper ,wavelength ,theta, which_pol);
    p_pol_reflection(wn)=output.R;
    p_pol_transmission(wn)=output.T;


    clear output

end


% FOM calculation (it is the output of this function)
FOM = 1 - sum(weight_factor(wave_region/1000).*p_pol_transmission) / sum(weight_factor(wave_region/1000));

