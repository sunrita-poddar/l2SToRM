
%==============================================================
% Code to compute X*L for the conjugate gradient algorithm
%==============================================================

% Inputs:
% X: Image series
% L: Laplacian matrix obtained from navigator data
% n: Image dimension is n x n
% nf: Number of frames

% Output:
% res: X*L

function res = XL(X,L,n,nf)

X = reshape(X,n^2,nf);

res = X*L;

res = res(:);