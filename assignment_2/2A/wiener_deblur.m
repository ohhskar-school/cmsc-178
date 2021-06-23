function I_deblur = wiener_deblur(I,B,k)
 
if ( isa(I,'uint8') || isa(B,'uint8') )
  error('deblur: Image and blur data should be of type double.');
end

I = edgetaper(I,B);
Fi = fft2(I);
% modify the code below ------------------------------------------------

% this section is just dummy code - delete it

% Here you will need to:

% Zero pad B
[iy, ix] = size(I);
[by, bx] = size(B);

startY = ceil((iy - by)/2);
startX = ceil((ix - bx)/2);
Fb = zeros(iy,ix);
Fb(startY+1:startY+by,startX+1:startX+bx) = B;

% Compute and apply inverse filter
Fb = fft2(Fb);

Finv = (Fi./Fb).*(abs(Fb.*Fb)./(abs(Fb.*Fb) + k));

% Convert back to a real image
I_deblur = real(ifft2(Finv));

% Handle spatial delay
I_deblur = ifftshift(I_deblur);

% Deal with values near zero
I_deblur(I_deblur<0.0001) = min(I_deblur(:));

% modify the code above ------------------------------------------------

return

