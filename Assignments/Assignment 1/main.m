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
