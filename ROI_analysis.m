% loop through patients
% loop through VOIs
% unzip data

path = "/Users/francescaleek/OneDrive - University College London/Vasculitis/";
patientname = "Patient1";
path_data = "/Users/francescaleek/OneDrive - University College London/Vasculitis/data/" + patientname +"/";

%regions = ["ascending aorta", "aortic arch", "descending aorta", "subclavian artery (left)", "subclavian artery (right)"];

pet = niftiread(path_data + "pet3d_resampled.nii");
ct = niftiread(path_data + "CTWHOLEBODY_H_1001.nii");
segment = niftiread(path_data + "DesAorta.nii");

% view images
%figure(1), imshowpair(pet_resampled(:,:,209), roi(:,:,209), "blend") %[-1200,800]);
%figure(2), imshowpair(ct(:,:,209), roi(:,:,209), "blend") %[-1200,800]);

% find ROI values
mask = segment == 1;
num_voxels = sum(mask(:));

pet_values = roi(pet, mask);
ct_values = roi(ct, mask);

pet_table = struct2table(pet_values);

writetable(struct2table(pet_values), path + "PatientData.xlsx")

