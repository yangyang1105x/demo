function output = roi(image, mask)
    roi_values = image(mask);
    output.mean = mean(roi_values(:));
    output.std = std(roi_values(:));
    output.max = max(roi_values(:));
    output.min = min(roi_values(:));
    
    % determine the 1st slice of the mask
    ind = find(mask(:)); % find non-zero indices of mask
    [i1,i2,i3] = ind2sub(size(mask), ind); % find coordinates of non-zero indices
    slice1 = i3(1); % value of first coordinate in z
    
    % calculate the max value in each of the 5 slices
    for i=1:5
        slice=image(:,:,i+slice1-1);
        roi_slice = mask(:,:,i+slice1-1);
        roi_values = slice(roi_slice);
        slice_max(i)=max(roi_values);
    end
    output.slice_max = slice_max;
    % calculate the mean of the max values
    output.slices_mean=mean(slice_max); 
    
end


