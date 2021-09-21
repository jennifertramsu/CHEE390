% Instructions to run:
    % Define the array (command window or another script)
    % Call the 'main' function by passing the defined array as an input in
    % the function.

function M = main(M)
% Takes the 3D array as an input and outputs the final sorted array
% M = 3D matrix

[x, y, z] = size(M); % Getting size of matrix

% error handling
if x == 0 || y == 0
    error('Not a matrix') % Check if matrix is matrix
end

if ~isreal(M)
    error('Imaginary values in matrix') % Check if matrix has imaginary components
end

lst = zeros(z, 2); % Initialize array to store sums and their corresponding plane

for i = 1:z % loop over matrix's planes
    lst(i, 1) = sums(M(:,:,i)); % assign diagonal sum to first column value in lst
    lst(i, 2) = i; % assign plane number to second column in lst
end

lst = sortrows(lst); % sorts rows based on the first element (sum), ascending order
indices = lst(:, 2); % grabbing original indices of plane

M = reorderpages(M, indices);

% Quicksort each page

for i = 1:z % loop over matrix's planes
    page = M(:, :, i); % Get the individual plane of matrix M
    
    [x, y] = size(page); % Get the dimensions for the plane

    M(:, :, i) = quicksort(page, 1, x*y)'; % Call quicksort on the array, bounded between 1 and the number of elements
    % Transposed as MATLAB indexes along a column
end

end

function s = sums(M)
% Calculate the sum of the diagonal in a square matrix plane
% M = 2D array
% s = sum of diagonal

[x, ~, z] = size(M);

% Error handling
if x ~= y
    error('Not a square matrix') % Check if matrix is square
end

if z ~= 1
    error('Not a 2D matrix') % Check if more than one plane was inputted
end

s = 0; % Initialize sum variable

for i = 1:x % loop over matrix rows
    s = s + M(i, i); % Add diagonal value to sum variable
end 

end 

function N = reorderpages(M, indices)
% Returns a new 3D matrix where the pages of M are ordered according to indices
% M = 3D matrix to be reordered
% indices = array containing original indices of pages where its current index is its new position

[x, y, z] = size(M);

N = zeros(x, y, z);

for i = 1:length(indices)
    N(:, :, i) = M(:, :, indices(i));
end

end

function v=quicksort(v, left, right)
% Copyright (c) 2010 - Phillip Servio
% Recursive quicksort algorithm applied to an array v
% Random pivot selection, two-sided comparison
% v = array to be sorted
% left = left index
% right = right index

if right < left
    return
end

i = left;
j = right;
s = right - left + 1; % can't use length for subarrays
pivot = left + floor(s*rand(1)); 

piv = v(pivot);

while i <= j
    while v(i) < piv % on the left, find the first value that's larger than the pivot
        i = i + 1;
    end
    while v(j) > piv % on the right, find the first value that's smaller than the pivot
        j = j-1;
    end
    if i <= j
        % swap
        vtmp = v(j);
        v(j) = v(i);
        v(i) = vtmp;
        i = i+1;
        j = j-1;
    end
end

% recursion on left side
v = quicksort(v, left, j);

% recursion on right side
v = quicksort(v, i, right);
        
end