function M = main(M)

[x, y, z] = size(M); % Getting size of matrix

% error handling
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
    page = M(:, :, i);
    M(:, :, i) = quicksort(page);
end

end

