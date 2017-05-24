
% Code for the publication:
% Sunrita Poddar and Mathews Jacob. "Dynamic MRI using smooThness
% regularization on manifolds (SToRM)." IEEE transactions on medical 
% imaging 35.4 (2016): 1106-1115.

% Author: Sunrita Poddar, The University of Iowa
% Date: 24 May 2017

% Code solves the l2-SToRM problem described in the above publication.
% Example here reconstructs a free-breathing ungated cardiac dataset 
% using a radial trajectory with navigators.

%%
%==============================================================
% Set the parameters for the dataset
%==============================================================

% Dimension of the data is: n x n x nf x nc
n = 512; % Image dimension is n x n
nf = 1000; % Number of frames
nc = 15; % Number of coils
lambda = 0.5; % Regularization parameter
nn = 2; % Number of neighbours retained in weight matrix
sig = 0.3*10^-4; % Parameter for weight computation
cmn = 4; % Number of navigator lines per frame

%%
%==============================================================
% Load the data
%============================================================== 

% S.mat: Sampling pattern saved in a cell of size {1 x nf}
% Example: S{1} contains k-space locations sampled for frame 1
% These Cartesian locations are obtained by gridding the original
% non-cartesian locations
load ('S.mat'); 

% b.mat: Acquired data saved in a cell of size {nf x nc}
% Example: b{10, 3} contains k-space data acquired by the 3rd coil
% at sampling locations in S{10}
% This Cartesian data is obtained by gridding the original
% non-cartesian data
load ('b.mat');

% csm.mat: Estimated coil sensitivity maps of size {n x n x nc}
% Maps are obtained using ESPIRIT algorithm
load ('csm.mat');

% bCom.mat: Navigator lines (in original non-cartesian co-ordinates)
% The data corresponds to a coil that is close to the heart
% Size of the data is {(n x cmn) x nf} 
load ('bCom.mat');

%%
%==============================================================
% Compute the weight matrix
%============================================================== 

% Computing the weights using navigator lines
W = computeWeights(bCom,nn,sig); 

% Add some small temporal regularization
t = 0.05*(circshift(eye(nf),[0 1]) + circshift(eye(nf),[1 0]));
W = max(W,t);

% Compute the Laplacian matrix as L = D - W
L = sparse(diag(sum(W,1))-W);

clear W bCom

%%
%==============================================================
% Solve the optimization problem: min_X { ||AX-b||^2 + lambda*trace(XLX')}
%============================================================== 
% We use the conjugate gradient algorithm to solve:
% A'A(X) + lambda*XL = A'b
% where A is the forward operator consisting of Fourier under-sampling and
% coil-sensitivity maps.

% Compute c = A'b
c = Ahb(b,S,csm,n,nf,nc);

clear b

% Compute the function handle: A'A(X) + lambda*XL
gradX = @(z)(AhAX(z,S,csm,n,nf,nc)+lambda*XL(z,L,n,nf));

% Run the Conjugate Gradient algorithm 
X= pcg(gradX,c(:),10^-10,40);

%%
%==============================================================
% Reshape the images for viewing and save
%============================================================== 

X = abs(reshape(X,n,n,nf));
X = fftshift(fftshift(X,1),2);

save('result.mat', 'X', '-v7.3');

