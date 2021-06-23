% CHART_CORRECTION - calculate RGB mappings to correct for color imbalance 
%                    between values measured from reference and test charts 
% Usage:
%         RGB_map = chart_correction(RGB_reference,RGB_measured)
%
% RGB_reference - Mx3 list of reference RGB samples 
% RGB_measured  - Mx3 list of actual RGB samples 
%
% RGB_map - 256x3 lookup table of R,G and B colour corrections
%

function RGB_map = chart_correction(RGB_reference,RGB_measured)

% Here we need to use the difference between the measured RGB values
% and the reference RGB values to create a lookup tables for RGB which will
% map the measured values back into the reference.

% Here the result is result is to be returned as a 256x3 table which contains the
% correction for the red,green and blue values


% ---- INSERT YOUR CODE BELOW -----

% Setup variables

% Create the x values that will be repeatedly passed to polyval
values = 0:255;

% Preallocate array for final RGB_map
RGB_map = zeros(256,3);

for i = 1:3
   % Generate coefficients for the polynomial that is 
   % the best fit for the values, with x as the bad values and y as the
   % correct values
   p = polyfit(RGB_measured(:,i), RGB_reference(:,i), 3);
   
   % Use the output above to generate the missing values. Cut off all
   % fitted values that is greater than 255 and less than 0
   fit = polyval(p, values);
   fit(fit>=255) = 255;
   fit(fit<=0) = 0;
      
   RGB_map(:,i) = fit;
end

% REPLACE THIS LINE WITH YOUR OWN CODE
% RGB_map = round(255*rand(256,3)); % <--- for now this returns a dummy result

% HINT  - you can try and work these out from first principles or use interp1 or 
% polyfit/polyval to estimate the corrections from the measured to reference
% measurements for each of the values 0..255. Any fitted values outside 0..255 
% should be adjusted accordingly. Map values should be integers too.

% ---- INSERT YOUR CODE ABOVE -----

return