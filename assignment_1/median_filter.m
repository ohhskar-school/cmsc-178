% MEDIAN_FILTER
%
% Usage:
%         med_img = median_filter(img,M,N)
%
% M,N size of MxN median filter to employ. 

function med_img = median_filter(img,M,N)

% ensure img is 0..1 and greyscale
img = im2double(img);
if (size(img,3)==3)
  img=rgb2gray(img);
end

% ----- INSERT YOUR OWN CODE BELOW -----

% Get the size of the image
[y,x,~] = size(img);

% Initialize final image
med_img = zeros(y,x);

% Get half of the distance from the center based on the size of the filter 
halfYDist = floor(M/2);
halfXDist = floor(N/2);

% Add correction variables. This is when a dimension of the filter is even.
% Since both sides are added with half the distance from the center, there
% can only be odd sizes when creating the vector, e.g. 2 + 1 + 2 and
% 3 + 1 + 3. This removes the extra pixel at the end making it 2 + 1 + 1
% and 3 + 1 + 2.
yCorr = 0;
xCorr = 0;
if ~mod(M,2); yCorr = 1; end
if ~mod(N,2); xCorr = 1; end

% Precalculate the index of the half and if the filter is even
half = ceil(M*N/2);
isEven = ~mod(M*N,2);

% Start going through each pixels
for i = 1:y
    for j = 1:x
        
        % Creating x and y vector indices
        ydist = i - halfYDist : i + halfYDist - yCorr;
        xdist = j - halfXDist : j + halfXDist - xCorr;
        
        % Catching if the vector indices goes out of bounds of the images
        if (min(ydist) < 1) || (max(ydist) > y) || (min(xdist) < 1) || (max(xdist) > x)
            
            % If so, simply copy the original pixel
            med_img(i,j) = img(i,j);
            continue
        end
        
        % Get the neigboring values in the original image
        vals = img(ydist,xdist);
        
        % Convert to 1d array and sort
        vals = sort(vals(:));
        
        % Check if even
        if isEven
            % Get the average of the two centers if even
            med_img(i,j) = (vals(half) + vals(half + 1)) / 2;
        else
            % Get the center value
            med_img(i,j) = vals(half);
        end
    end
end

% Hint: the simplest solution is to use for loops and the sort() function
% to solve this. Consider also how you plan to deal with values near the
% boundary.


% ----- INSERT YOUR OWN CODE ABOVE -----

return
end



