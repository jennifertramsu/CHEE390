function M = swappages(M, first, second)
% swaps two pages in a 3D matrix

tmp = M(:, :, first);
M(:, :, first) = M(:, :, second);
M(:, :, second) = tmp;

end