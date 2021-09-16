% Assignment 1
% Jennifer Tram Su 260923530

function sortmatrix(v)
% GIVE CREDIT?
% v = 3D matrix (row, col, page)
% assume square for diagonal

% This function will implement the quicksort algorithm on a 3D matrix of
% any dimension in 2 steps
% Step 1 = Sort the matric by rearranging the 2 planes such that the plane
% with the lowest sum of the diagonal elements is at the front

% Step 2 = sort each plane

% NOTES
% implementing quicksort 
% (1) turn plane into 1D array
% (2) use quicksort to sort 1D array
% (3) turn 1D array back into plane?
% nvm we want in-place sorting

% other partitioning methods
% two indices
% on left of pivot, find value that's large
% on right, find value that's smaller
% swap the two
% --> more efficient

end

% helper functions
function s = sums(M) % M is a plane-component of the multi-dimensional array
% Calculate the sum of the diagonal in a square matrix plane

[x y z] = size(M);

if x ~= y
    error('Not a square matrix') % Check if matrix is square
end

if x == 0
    error('Not a matrix') % Check if matrix is matrix
end

if z ~= 1
    error('Not a 2D matrix') % Check if more than one plane was inputted
end

if ~isreal(M)
    error('Imaginary values in matrix') % Check if matrix has imaginary components
end

s = 0 % Initialize sum variable

for i = 1:x % loop over matrix rows
    s = s + M(i, i) % Add diagonal value to sum variable
end 
end 



