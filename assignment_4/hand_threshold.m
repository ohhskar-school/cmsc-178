% IMAGE_THRESH - estimate a suitable image threshold value using isothresh
%
function T = hand_threshold(I)

if (isa(I,'uint8'))
  I=double(I)/255;
end


% TO BE FILLED IN BY YOU (See assignment sheet)
% this should implement isothresh for at least 10 iterations. I
% suggest you use the mean of the whole image as the initial value for
% T.

% ---------- INSERT YOUR CODE BELOW ------------------------------------
T = mean(I, 'all');
for i = 1:20
    T = (mean(I>T, 'all') + mean(I<=T, 'all')) / 2;
end
% ---------- INSERT YOUR CODE ABOVE ------------------------------------

% END FO FILE
    


