load(sprintf('%s.mat',fntd))

% FM parameters
 get_size_qv=size(qv_ii_array);
 qv_length=get_size_qv(2);
 inputFM.data=qv_ii_array;
 inputFM.FOM=FOM;
 inputFM.k_space=8;
 inputFM.lr=0.0001;
 inputFM.b=0.0001;
 inputFM.epoch=20000;
 inputFM.fntd=fntd;    
 
% Learn FM
FM_time = tic;
inputFM=FM_xlearn_cv_ml_JSR(inputFM);
caltime_fm=toc(FM_time);
caltime_fm_array(in-24)=caltime_fm;

if strcmp(input.fm_optimizer,'simulated_annealing')
    % Predict Global minimum with Simulated Annealing
    [QUBO_for_qlm,Bias_for_qlm]=formulate_QUBO_FM_JSR(inputFM);
    SA_time = tic;
    [os,oi]=system(sprintf('C:\\Users\\user\\miniconda3\\envs\\JSR_jupyter_desktop\\python -c "from simul_annealing_matlab import d_simul; d_simul(%s)"',[char(39) fntd char(39)]));        %% Predict Global minimum 
    caltime_SA=toc(SA_time);
    caltime_SA_array(in-24)=caltime_SA;
    caltime=[caltime_fm_array;caltime_SA_array];
    SA_name = sprintf('%s_cal_fm_SA_time_.mat',filename);
    save(SA_name, 'caltime');

    QA_answer= x0_txtimport_SWA(sprintf('simul_OptimizedData.txt'),qv_length);
    FOM_predict_gmin_qa= dlmread('simul_FOM.txt');
    qv_gmin_qa=QA_answer;

    opt_file = fopen(sprintf('opt_%s.txt',fntd),'w');
    labelvalue=num2cell(([FOM_predict_gmin_qa, qv_gmin_qa]));
    labeltext='%12.8f \n';
    fprintf(opt_file,labeltext,labelvalue{:});
    fclose(opt_file);

    if ismac
        dos(sprintf('rm x0_%s_qubo_qlm.txt ',fntd));
        dos(sprintf('rm %s_qubo_qlm.txt ',fntd));
    elseif isunix
        % Code to run on Linux platform
    elseif ispc
        [oi,oy]=system(sprintf('del x0_%s_qubo_qlm.txt',fntd));
        [oi,oy]=system(sprintf('del %s_qubo_qlm.txt',fntd));
        [oi,oy]=system(sprintf('del %s_bias.txt',fntd));
        [oi,oy]=system(sprintf('del simul_FOM.txt'));
        [oi,oy]=system(sprintf('del simul_OptimizedData.txt'));
    else
        disp('Platform not supported')
    end
end
