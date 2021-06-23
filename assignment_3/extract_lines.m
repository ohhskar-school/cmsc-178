function RT = extract_lines(H,rhos,thetas,N)

% H - hough transforms
% rhos - related rho values
% thetas - related theta values
% N - number of peaks to identify
%
% RT - a N rows by 2 columns array of the peak rho and theta values

RT = zeros(N,2);

% -------------------- put your code in below ---------------------------

% NOTES: the peaks appear as elongated reagions of large values in the
% hough data. Simply identifying local maxima may not be enough as the
% central peak is sometimes slightly reduced if the lines are not exactly
% straight. You will also need to make sure you do not pick multiple
% peaks which are associated with the same line estimate.

% The suggested method of approach is to look for a global maxima over a
% region LARGER than a simple 5x5 neighbourhood. This maxima is then
% treated as the strongest line and the rho,theta value recorded. The
% region around this point is then zeroed, and the process repeated for
% the next brightest line. ie.


% for i=1 to N
%    1. find brightest maxima using local neigbourhood estimates (this will 
%        probably require a double for loop etc)
%    2. record the rho,theta value
%    3. blank out the neighbourhood around the identified maxima
%

% Store temp H
tempH = H;

% Y is rho, X is theta
[y,x] = size(H);

% Find N amounts of maxima
for i = 1:N
    
    % Initialize maximum values
    maxH = H(1,1);
    maxRho = 1;
    maxTheta = 1;
    
    % Loop through each item in H to find the maxima. tempH cannot be
    % accessed as one vector since both j and k are needed. 
    for j = 1:y
        for k = 1:x
            if tempH(j,k) > maxH
                maxH = tempH(j,k);
                
                % index positions are stored instead of the actual value
                % since the index positions are to be used to remove
                % adjacent values
                maxRho = j;
                maxTheta = k;
            end
        end
    end
    
    % Get actual max rho and max theta
    RT(i,1) = rhos(maxRho);
    RT(i,2) = thetas(maxTheta);
    
    % Region around the current maximum point is zeroed so that multiple
    % peaks which are associated with the same line estimate are not taken
    % as maxima again
    tempH(maxRho - 2:maxRho + 2,maxTheta - 2:maxTheta + 2) = 0;
end

% dummy code - return N random estimates - NOTE: remove the two lines below
% RT(:,1) = rhos( max(1,round(length(rhos)*rand(1,N))))';
% RT(:,2) = thetas( max(1,round(length(thetas)*rand(1,N))) )';

% ---------------------put your code in above ---------------------------

figure;

imagesc(thetas,rhos,H); %axis equal tight;
colormap(gray);
title('Hough Transform - Detected Maximas');
xlabel('Theta');
ylabel('Rho');
hold on;
plot(RT(:,2),RT(:,1),'bo');
hold off;
drawnow;

return

% -----------
% END OF FILE
