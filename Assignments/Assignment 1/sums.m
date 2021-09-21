function s = sums(M)
% Calculate the sum of the diagonal in a square matrix plane
% M = 2D array
% s = sum of diagonal

[x, y, z] = size(M);

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