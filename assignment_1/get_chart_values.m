% GET_CHART_VALUES(chart_image) - extract the 6x4 color values from the
% supplied colour chart image.
%
% Usage:
%         RGB_list = get_chart_values(chart_image)
%
% chart_image - NxMx3 array of uint8
% RGB_list - 24x3 element list of rgb values


function RGB_list = get_chart_values(chart_image)

% chart_image is assumed to be an RGB (0..255) image of the color test
% chart. The chart should consist of 4 rows of 6 color patches equally
% spaced. Here you simply need to obtain an RGB value for each patch and
% store it in an Nx3 table

% ---- INSERT YOUR CODE BELOW -----

% Get size of array
[y,x,~] = size(chart_image);

% Get approximate size of patches and center of patches. Constant numbers
% are used since the rows and columns are known beforehand.
h = round(y/4);
l = round(x/6);
halfH = round(h/2);
halfL = round(l/2);

% Get x and y values for each patch

% Start with the center of the first patch and end at the center of the 
% last patch. Increment by the size of a patch to go to the next center.
% +2 is added as the upper bound to account for rounding errors.
column = repmat(halfL:l:x - halfL + 2, 1, 4);

% reshape + repmat hacks to create repeating digits for each column such
% that each x coordinate in the column vector is paired with the correct
% y coordinate
row = reshape(repmat((halfH:h:y - halfH + 2).', 1, 6).',1,[]);

% Generate RGB List
RGB_list = zeros(24,3);
for i = 1:numel(column)
    RGB_list(i,1) = chart_image(row(i), column(i), 1);
    RGB_list(i,2) = chart_image(row(i), column(i), 2);
    RGB_list(i,3) = chart_image(row(i), column(i), 3);
end

% ---- INSERT YOUR CODE ABOVE -----

return
end





