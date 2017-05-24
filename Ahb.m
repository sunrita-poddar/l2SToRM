
%==============================================================
% Code to compute A'b for the conjugate gradient algorithm
%==============================================================

% Inputs:
% b: Acquired k-space data 
% S: Acquired sampling trajectory
% csm: Coil sensitivity maps
% n: Image dimension is n x n
% nf: Number of frames
% nc: Number of coils

% Output:
% res: A'b, where A is the forward operator consisting of Fourier
% under-sampling and coil-sensitivity maps.

function res = Ahb(b,S,csm,n,nf,nc)

res = zeros(n^2,nf);

tmp = zeros(n^2,1);
tmp1 = zeros(n,n);

for i=1:nf
    for k=1:nc
        tmp(S{i})= b{i,k}; % Putting the acquired samples at the sampled locations
        tmp=reshape(tmp,n,n);
        tmp1 = tmp1+conj(csm(:,:,k)).*ifft2(tmp); % IFFT followed by coil sensitivity multiplication
        tmp(:)=0;
    end
    res(:,i) = tmp1(:);
    tmp1(:) = 0;
end

res = sqrt(n^2)*res(:); % Reshaping the result to a vector
