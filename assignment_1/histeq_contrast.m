% HISTEQ_CONTRAST - histogram equalisation for contrast enhancement
%
% Usage:
%         eq_img = histeq_contrast(img)
%
%  input image data is assumed to be in range 0..1

function eq_img = histeq_contrast(img)

% ----- INSERT YOUR CODE BELOW -----

% OPTIONAL HINT to make it easier to index you can multiply the img 
%   values by 255 and use a 256 element histogram

% Create own histogram by iterating through the image. Using histcounts will
% stretch the bins. A value that has a value of 187 after multiplying by 
% 255 may be placed in 102 when using histcounts. This will result in an
% image that is darker compared to the output from the built-in function.
hist = zeros(256,1);
for i = 1:numel(img)
    val = floor(img(i) * 255);
    hist(val + 1) = hist(val + 1) +1;
end

% Preallocate the lookup table and other variables needed for its
% calculation
m = zeros(1, length(hist));
super = cumsum(hist);      % Precalculate the cumulative sum.
sub = sum(hist);           % Precalculate the sum

% Find the first non zero element
for i = 1:length(hist)
    % If the first non empty bin is found, record that it is found, and
    % subtract the sum and all cumulative sum by its value.
    if hist(i) ~= 0
        super = super - hist(1);
        sub = sub - hist(i);
        break
    end
end

% Create lookup table by dividing each cumulative sum by the total sum
m = super / sub;

% Replace the values in the image based on the lookup table

[y,x] = size(img);
eq_img = zeros(y,x);
for i = 1:y*x
    eq_img(i) = m(floor(img(i) * 255) + 1);
end

% ----- INSERT YOUR CODE ABOVE -----

return