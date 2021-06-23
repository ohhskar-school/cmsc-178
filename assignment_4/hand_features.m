% HAND_FEATURES - extract shape features for the supplied region of
%  interest suitable for classification.
%
% F = hand_features(B)
% 
% B = binary image mask
%
% F - an 1xN row-vector of feature measurement (real numbers)

function F = hand_features(B)

% Extract features related to shape. Make use of the concepts covered
% in the lectures. MATLAB has a number of useful pre-existing feature 
% measures to try out but I suggest you also create some of your own
% if you wish to get good results.

% ---------- INSERT YOUR CODE BELOW ------------------------------------
% Get features using regionprops
features = regionprops(B, {'Solidity','MajorAxisLength', 'MinorAxisLength'},'table');

% Store selected feature
F = [features.Solidity features.MajorAxisLength/features.MinorAxisLength];

% features = regionprops(B, {'Solidity','Circularity'},'table');
% F = [features.Solidity features.Circularity];

%features = regionprops(B, {'Solidity','Area'},'table');
% F = [features.Solidity (pi / 4 * features.Area)];

% features = regionprops(B, {'Circularity','MajorAxisLength', 'MinorAxisLength'},'table');
% F = [features.Circularity features.MajorAxisLength/features.MinorAxisLength];

% ---------- INSERT YOUR CODE ABOVE ------------------------------------

return

% END OF FILE
