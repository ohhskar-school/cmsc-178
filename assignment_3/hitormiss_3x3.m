function Imatch = hitormiss_3x3(I,M)

if (ndims(I)==3)
  I=I(:,:,2);
end
if (isa(I,'uint8'))
  I=double(I)/255;
end

% --------------- INSERT YOUR CODE BELOW -----------------

% note use the erode_3x3 function call as part of your solution

% Separate single matching template into set and unset template
set = zeros(size(M));
unset = zeros(size(M));

for i = 1:numel(M)
    if M(i) == 1
        set(i) = 1;
    elseif M(i) == -1
        unset(i) = 1;
    end
end

[y, x] = size(I);
Imatch = zeros(size(I));

% Iterate through all pixels except edge pixels since those are
% automatically 0
for i = 2:y-1
    for j = 2:x-1
        
        % Get 3x3 region
        sample = I(i-1:i+1, j-1:j+1);
        
        % Erode 3x3 region with both set and unset template
        if erode_3x3(sample, set) && erode_3x3(~sample, unset)
            Imatch(i,j) = 1;
        end
    end
end



% --------------- INSERT YOUR CODE ABOVE -----------------

return


% erode_3x3(I,S) - apply erosion using the 3x3 structure element S

function E = erode_3x3(I,S)
% --------------- INSERT YOUR CODE BELOW -----------------

% Assume erosion is succesful at the start
E = 1;

% Check if there are any pixel that are not set, and the template requires
% them to be.
for i = 1:numel(I)
    if S(i) == 1 && I(i) ~= 1
        E = 0;
    end
end
    
% --------------- INSERT YOUR CODE ABOVE -----------------
return




