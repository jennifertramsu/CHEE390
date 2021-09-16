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


