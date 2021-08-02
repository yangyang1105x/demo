cd('D:\PETCT Yang Yang')
files=gunzip('pet3d_resampled.nii.gz');
nii=load_nii('pet3d_resampled.nii');
files=gunzip('ascending.nii.gz');
roinii=load_nii('ascending.nii');
%view_nii(nii)
%%
mask=roinii.img==1;
num_voxels = sum(mask(:))
roi_values= nii.img(mask);
roi_mean=mean(roi_values(:))
roi_max=max(roi_values(:))
roi_min=min(roi_values(:))