% loop through patients
% loop through VOIs

path = "/Users/francescaleek/OneDrive - University College London/Vasculitis/demo/";
patientname = "Patient1";
path_data = "/Users/francescaleek/OneDrive - University College London/Vasculitis/data/" + patientname +"/";

images = ["CTWHOLEBODY_H_1001", "pet3d_resampled"];
regions = ["ascending aorta", "aortic arch", "descending aorta", "subclavian artery (left)", "subclavian artery (right)"];

for region = 1:length(regions)
    voi = regions{region}; 
    if isfile(voi)
        segment = niftiread(path_data + voi + ".nii");
    else
        file = gunzip(path_data + voi + ".nii.gz");
        segment = niftiread(path_data + voi + ".nii");
    end
    
    for image = 1:length(images)
        im = images{image};
        if isfile(im)
            petct(:,:,:,image) = niftiread(path_data + im + ".nii");
        else
            file = gunzip(path_data + im + ".nii.gz");
            petct(:,:,:,image) = niftiread(path_data + im + ".nii");
        end
    end


    %pet = niftiread(path_data + "pet3d_resampled.nii");
    %ct = niftiread(path_data + "CTWHOLEBODY_H_1001.nii");
    %segment = niftiread(path_data + "DesAorta.nii");

    % view images
    %figure(1), imshowpair(petct(:,:,244,2), segment(:,:,244), "blend") %[-1200,800]);
    %figure(2), imshowpair(petct(:,:,244,1), segment(:,:,244), "blend") %[-1200,800]);

    % find ROI values
    mask = segment == 1;
    num_voxels = sum(mask(:));

    pet_values = roi(petct(:,:,:,2), mask);
    ct_values = roi(petct(:,:,:,1), mask);

    pet = struct2cell(pet_values);
    ct = struct2cell(ct_values);
    output = [pet.', ct.'];

    writecell(output, path + 'PatientData.xlsx', 'WriteMode', 'append')
end
