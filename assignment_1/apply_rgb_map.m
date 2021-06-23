% APPLY_RGB_MAP - replace R,G and B values in an image based
%  on the supplied lookup table
%
% Usage:
%          adjusted_image = apply_rgb_map(img,map)
%
% img -  NxMx3 uint8 image
% map -  256x3 lookup table for R,G,B values in range 0..255
%
% note R,G and B values are mapped independently. The RGB triples
% do not represent actual colours in the image (this is not a colormap).

function adjusted_image = apply_rgb_map(RGB_image,RGB_map)

% remap each RGB value in the current image onto a new image. Remember
% to treat each RGB channel separately. Also entry 1 in the table is
% colorlevel 0 and entry 256 is colorlevel 255

% ----- ADD YOUR CODE BELOW -----

% Copy given image to output variabl
adjusted_image = RGB_image;

% Get the size of the matrix
[y,x,z] = size(adjusted_image);

% Loop through the different color layers
for i = 1:z    
    % Get the image of this page
    channel = adjusted_image(:,:,i);
    
    % Loop through all pixels in this page using linear indexing and
    % replace values based on the corresponding lookup table
    for j = 1:x*y
        channel(j) = RGB_map(channel(j) + 1, i);
    end
    
    % Replace the original page with the fixed page based on the lookup
    % table
    adjusted_image(:,:,i) = channel;
end

% ----- ADD YOUR CODE ABOVE -----

% resulting image must be uint8 with values in range 0..255
adjusted_image = uint8(adjusted_image);
return

end