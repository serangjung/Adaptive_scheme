cp_cmd='copy';
rm_cmd='del';
dos(sprintf('%s %s_%d.mat %s_mat%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s %s_%d.mat',rm_cmd,filename,in-1));
dos(sprintf('%s %s_%d.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s %s_%d.txt ',rm_cmd,filename,in-1));
dos(sprintf('%s %s_%d_cv.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s %s_%d_cv.txt ',rm_cmd,filename,in-1));
dos(sprintf('%s %s_%d_cv.mat %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s %s_%d_cv.mat ',rm_cmd,filename,in-1));
dos(sprintf('%s rms_%s_%d.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s rms_%s_%d.txt ',rm_cmd,filename,in-1));
dos(sprintf('%s tr_%s_%d.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s tr_%s_%d.txt ',rm_cmd,filename,in-1));
dos(sprintf('%s cv_%s_%d.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s cv_%s_%d.txt ',rm_cmd,filename,in-1));
dos(sprintf('%s ini_%s_%d.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s ini_%s_%d.txt ',rm_cmd,filename,in-1));
dos(sprintf('%s opt_%s_%d.txt %s_traintxt%s',cp_cmd,filename,in-1,filename,'\'));
dos(sprintf('%s opt_%s_%d.txt ',rm_cmd,filename,in-1));