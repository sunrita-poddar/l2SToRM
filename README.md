
# Dynamic MR Image Reconstruction using SToRM 

# Publication:

Sunrita Poddar and Mathews Jacob. "Dynamic MRI using smooThness regularization on manifolds (SToRM)." IEEE transactions on medical imaging 35.4 (2016): 1106-1115. 

Please cite the above paper if you use the developed code.

# Code:

## main.m
This code generates the result in result.avi, by solving the optimization problem:

![](https://latex.codecogs.com/gif.latex?%5Cmin_%7B%5Cmathbf%20X%7D%20%5C%7C%5Cmathbf%20A%20%5Cmathbf%20X-%20%5Cmathbf%20b%5C%7C%5E2%20&plus;%20%5Clambda%20Tr%28%5Cmathbf%20X%20%5Cmathbf%20L%20%5Cmathbf%20X%27%29)

where the notation is described in the SToRM paper. In brief, ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20X) is the series of MR image frames, ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20A) is the Fourier under-sampling operator, ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20b) is the matrix of data samples, ![](https://latex.codecogs.com/gif.latex?%5Clambda) is the regularization parameter and ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20L) is the estimated manifold Laplacian.

## Functions called by main.m:
### AhAX.m
Code to compute ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20A%5EH%20%5Cmathbf%20A%20%28%5Cmathbf%20X%29) for the conjugate gradient algorithm
### Ahb.m 
Code to compute ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20A%5EH%20%5Cmathbf%20b) for the conjugate gradient algorithm
### computeWeights.m
Code to compute the weight matrix from navigator data
### XL.m
Code to compute ![](https://latex.codecogs.com/gif.latex?%5Cmathbf%20X%20%5Cmathbf%20L) for the conjugate gradient algorithm

# Data: 

Available at: https://iowa-my.sharepoint.com/personal/jcb_uiowa_edu/_layouts/15/guestaccess.aspx?folderid=0a72e5307778348e9a18a820d9fa3624d&authkey=ARlI1w22gv4KBG9EJ3p-OQo

The cardiac data was acquired in the ungated mode on a free-breathing subject using a FLASH sequence. The sampling pattern is a mix of golden angle radial lines and uniform radial navigators (refer to paper). Each frame has 10 radial lines, out of which 6 are golden angle lines and 4 are uniform radial navigator lines. Data for 1000 frames was acquired in around 40 s.

1. S.mat: Sampling pattern saved in a cell of size {1 x number_of_frames}. Example: S{1} contains k-space locations sampled for frame 1. These Cartesian locations are obtained by gridding the original non-cartesian locations. 
2. b.mat: Acquired data saved in a cell of size {number_of_frames x number_of_coils}. Example: b{10, 3} contains k-space data acquired by the 3rd coil at sampling locations in S{10}. This Cartesian data is obtained by gridding the original non-cartesian data.
3. csm.mat: Estimated coil sensitivity maps of size {image_size x number_of_coils}. Maps are obtained using ESPIRIT algorithm
4. bCom.mat: Navigator lines (in original non-cartesian co-ordinates). The data corresponds to a coil that is close to the heart. Size of the bCom is {(number_of_readouts x number_of_navigator_lines) x number_of_frames}. 

# Results:

A few frames of the result are saved in the video file result.avi.
