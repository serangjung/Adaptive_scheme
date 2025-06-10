function outputFM=FFM_xlearn_cv_ml_JSR(inputFM)
k_space=inputFM.k_space;
fntd=inputFM.fntd;
lr=inputFM.lr; % the learning rate
b=inputFM.b;
epoch=inputFM.epoch; % the number of epoch

%this is for FFM.(-s 5)
flag_text=sprintf(' ./%s_LIBFFM.txt -s 5 --no-norm -k %d -p sgd -r %f -b %f -e %d -m %s.model -t %s_model.txt -v ./%s_cv_LIBFFM.txt',fntd,k_space,lr,b,epoch,fntd,fntd,fntd);
[a,b]=dos(sprintf('xlearn_train %s --quiet',flag_text)); % run xlearn to train data
[a,b]=dos(sprintf('xlearn_predict ./%s_LIBFFM.txt ./%s.model -o tr_%s.txt --no-norm',fntd,fntd,fntd)); % predict

xlearn_prediction=import_xlearn_prediction_SWA(sprintf('tr_%s.txt',fntd));
xlearn_fom=import_xlearn_prediction_SWA(sprintf('%s.txt',fntd));
tr_rms=sqrt(sum((xlearn_prediction-xlearn_fom).^2)/length(xlearn_prediction));
tr_data=[xlearn_prediction, xlearn_fom];
tr_name=sprintf('tr_%s.txt',fntd);
save(tr_name,'tr_data','-ascii');

[a,b]=dos(sprintf('xlearn_predict ./%s_cv_LIBFFM.txt ./%s.model -o cv_%s.txt --no-norm',fntd,fntd,fntd)); % predict

cv_xlearn_prediction=import_xlearn_prediction_SWA(sprintf('cv_%s.txt',fntd));
cv_xlearn_fom=import_xlearn_prediction_SWA(sprintf('%s_cv.txt',fntd));
cv_rms=sqrt(sum((cv_xlearn_prediction-cv_xlearn_fom).^2)/length(cv_xlearn_prediction));
cv_data=[cv_xlearn_prediction, cv_xlearn_fom];
cv_name=sprintf('cv_%s.txt',fntd);
save(cv_name,'cv_data','-ascii');

rms_film = fopen(sprintf('rms_%s.txt',fntd),'w');
labelvalue=num2cell(([tr_rms, cv_rms]));
fprintf(rms_film,('%12.8f \n'),labelvalue{:});
fclose(rms_film);

model_name=sprintf('%s_model.txt',fntd);
%eval(sprintf('hyperparameters=xlearn2FM_main_k%d(model_name);',k_space));
eval(sprintf("hyperparameters=split_model_JSR(model_name,k_space)"));

%before wvmat,w0 -> w2,w1,w0.
inputFM.w2=hyperparameters.w2;
inputFM.w1=hyperparameters.w1;
inputFM.w0=hyperparameters.w0;

if ismac
    dos(sprintf('rm %s_model.txt',fntd));
    dos(sprintf('rm %s.txt.bin',fntd));
    dos(sprintf('rm %s_cv.txt.bin',fntd));
elseif isunix
    % Code to run on Linux platform
elseif ispc
    [oi,oy]=system(sprintf('del %s_model.out',fntd));
    [oi,oy]=system(sprintf('del %s.txt.bin',fntd));
    [oi,oy]=system(sprintf('del %s_cv.txt.bin',fntd));

    [oi,oy]=system(sprintf('del %s.model',fntd));
    [oi,oy]=system(sprintf('del %s_LIBFFM.txt.bin',fntd));
    [oi,oy]=system(sprintf('del %s_cv_LIBFFM.txt.bin',fntd));

    [oi,oy]=system(sprintf('del %s_cv_LIBFFM.txt',fntd));
    [oi,oy]=system(sprintf('del %s_LIBFFM.txt',fntd));
    [oi,oy]=system(sprintf('del %s_model.txt',fntd));

    system('del xlearn_log*');
    system('del *.model');
    system('del *model.txt');
else
    disp('Platform not supported')
end

outputFM=inputFM;
