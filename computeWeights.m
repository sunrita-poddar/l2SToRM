
%==============================================================
% Code to compute the weight matrix from navigator data
%==============================================================

% Inputs:
% X: Navigator data 
% nn: Number of neighbours
% sig: Sigma parameter for exponential weights

% Output:
% W: Weight matrix

function W = computeWeights(X, nn, sig)

[~, n] = size(X);

% Compute distance matrix
X2 = sum(X.*conj(X),1);
X3 = (X')*X;
d = abs(repmat(X2,n,1)+repmat(X2',1,n)-2*real(X3));

% Compute exponential weights
W = exp(-d/sig);

% Remove diagonal elements
W = W-eye(n);

% Threshold matrix to retain only nn number of neighbours
for i=1:n
    t = W(i,:);
    [~, ind] = sort(t,'descend');
    W(i,ind(nn+1:end)) = 0;
end

% Make the weight matrix symmetric
W = (W+W')/2;
