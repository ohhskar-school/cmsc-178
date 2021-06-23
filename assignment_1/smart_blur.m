% SMART_BLUR - blur image to remove noise, but attempt to preserve
%  edge details where possible
%
% USAGE:
%   image_out = smart_blut( image_in , N , tolderance )
%
%    N         - size of NxN blur to apply to data (def. 5).
%    tolerance - estimate of gradient based on noise alone. Used to
%                contol weighting between oriignal and smoothed data
%                returned by function (def. 0.015)
%
% NOTE: all image data is converted to greyscale, with values in range 
%      0.0..1.0 before filtering is applied.

function B = smart_blur(I,N,tolerance)

% convert to greyscale 0.0..1.0
I =im2double(I);
if (size(I,3)==3)
  I=rgb2gray(I);
end

% handle missing input parameters
if (nargin<2)
  N=5;
  if (nargin<3)
    tolerance=0.015; % about 4 greylevels for 8bit data
  end
  if (nargin<1)
    error('This function requires an image as input');
  end
end

% ------ INSERT YOUR CODE BELOW ------

% Create 5x5 Sobel gradient filter
sobX = [-4 -5 0 5 4; -8 -10 0 10 8; -10 -20 0 20 10; -8 -10 0 10 8; -4 -5 0 5 3];
sobY = [4 8 10 8 4 ; 5 10 20 10 5; 0 0 0 0 0; -5 -10 -20 -10 -5; -4 -8 -10 -8 -4];

% Blur Image using a simple NxN averaging filter
blur = conv2(I,ones(N,N)/(N*N),'same');

% Calculate X and Y gradients and square them in preparation for creating
% the image. The image used is the one that is blurred as this slightly
% removes noise that may affect edge detection
gradX = conv2(blur,sobX/240,'same').^2;
gradY = conv2(blur,sobY/240,'same').^2;

% Preallocate final gradient image
[y,x,~] = size(I);
grad = zeros(y,x);

% Compute gradient image based on formula.
for i = 1:y*x
    grad(i) = sqrt(gradX(i) + gradY(i));
end

% Preallocate weight
w = zeros(y,x);

% Compute weights based on formula
for i = 1:y*x
    tempW = tolerance/grad(i);
    if (tempW <= 1)
        w(i) = tempW;
    else
        w(i) = 1;
    end
end

% Preallocate final image
B = zeros(y,x);

% Generate the image
for i = 1:y*x
    B(i) = w(i)*blur(i) + (1 - w(i))*(I(i));  
end

% ------ INSERT YOUR CODE ABOVE ------

return
end
