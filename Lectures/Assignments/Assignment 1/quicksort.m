% Assignment 1
% Jennifer Tram Su 260923530

function sortmatrix(v)
% GIVE CREDIT?
% v = 3D matrix (row, col, page)

% This function will implement the quicksort algorithm on a 3D matrix of
% any dimension in 2 steps
% Step 1 = Sort the matric by rearranging the 2 planes such that the plane
% with the lowest sum of the diagonal elements is at the front

% QUESTIONS
% Diagonal elements --> only the first diagonal?
% What if plane is not square

% Step 2 = sort each plane

% Step 1

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

% Step 2 - Calling Quicksort for each page
end

% helper functions
