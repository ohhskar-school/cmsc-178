% HAND_EXTRACT - auto extract the "hand" region of interest from the training
%   image using thresholding, morphological cleaning etc.
%
%  B = hand_extract(I);
%
% I = an NxM gresyscale image (values range 0..1)
% B = Binary mask of extracted region

function B = hand_extract(I)

if (nargin<1)
  error('This function requires an image as input');
end
if (isa(I,'uint8'))
  I = double(I(:,:,1))/255;
end

% estimate a threshold using the isothresh function you have created.
threshold = hand_threshold(I); 

% 1. Threshold the image based on the isothresh estimate. Given that the
%    hand contains significant shadowing uou may need to scale up/down the
%    threshold estimate given by image_thresh(). 
%
% 2. Clean up the thresholded image. Remove isolated points, fill holes
%    in the etc... You can use any of the function in the image processing
%    toolbox to do this such as imerode,imdilate,imopen,imclose,imfill etc.
%    Make sure you test this on serval images from the dataset to be sure it works.
%    Again shadowing across the hand is likely to be an issue.
%
% 3. Return a binary image containing only the "hand", preferably as a single region. 
%    If you have multiple regions in the output (caused by fragmentation of the hand or
%    from noise not removed during the clean up stage) some of the feature estimation 
%    functions which you will use later on may return odd results. 
%
% IMPORTANT - the better this section is at cleaning up the imagery the better the 
% feature estimates are likely to be and hence the performance of the classifier. Also
% make sure you discuss how you came up with these steps in your report and include
% examples etc.
% ----------- FILL IN THE SECTION BELOW ------------------------------

% Adjust threshold. .45 seems to be the most acceptable middle ground. 0.4
% creates areas with a lot of noise while 0.5 removes greater chunk of shadows
% that is still part of the image..
B = I >= threshold * 0.45;

% Use imclose to try connect instances where outlines do not connect and
% try to close small holes.
S = strel('disk', 6);
B = imclose(B, S);

% Imfill to fill all the remaining holes after closing
B = imfill(B, 'holes');

% Label all connected regions in the image
[L,n] = bwlabel(B);

objIndex = 1;
% If there is only 1 object, no need to check what is the largest object
% since by default it is the largest
if n ~= 1
    % Find the most common object index, except 0, since 0 means no object
    % was found in that pixel in the labeled image
    objIndex = mode(L(L>0));
end

% Get the biggest object back. This is done by element wise binary 
% operation where if that pixel is equal to the index of the largest
% object, it returns a logical 1. If it isn't it returns a logical 0. This
% works perfectly for our use case as bw images have logical 1 as white and
% logical 0 as black.
B = L == objIndex;

% ----------- FILL IN THE SECTION ABOVE ------------------------------

return

% -------------------------------------------------------------------
% END OF FILE