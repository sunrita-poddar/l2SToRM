
%==============================================================
% Code to compute A'A(X) for the conjugate gradient algorithm
%==============================================================

% Inputs:
% X: Image series
% S: Acquired sampling trajectory
% csm: Coil sensitivity maps
% n: Image dimension is n x n
% nf: Number of frames
% nc: Number of coils

% Output:
% res: A'A(X), where A is the forward operator consisting of Fourier
% under-sampling and coil-sensitivity maps.

function res = AhAX(X,S,csm,n,nf,nc)

X = reshape(X,n,n,nf);
res = zeros(n,n,nf);
tmp = zeros(n^2,nf);

for k=1:nc  
    
    % Multiplying coil sensitivities and taking FFT
    tmp1 = reshape(fft2(bsxfun(@times,X,csm(:,:,k))),n^2,nf);
    
    % Keeping only acquired locations
    for i=1:nf       
        tmp(S{i},i) = tmp1(S{i},i);
    end
    
    % Taking IFFT and multiplying by coil sensitivities
    res = res+bsxfun(@times,ifft2(reshape(tmp,n,n,nf)),conj(csm(:,:,k)));
    tmp(:)=0;
    
end

res = res(:); % Reshaping the result to a vector
