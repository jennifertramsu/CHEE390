function N = reorderpages(M, indices)
% Returns a new 3D matrix where the pages of M are ordered according to indices
% M = 3D matrix to be reordered
% indices = array containing original indices of pages where its current
% index is its new position

[x y z] = size(M);
N = zeros(x, y, z);

for i = 1:length(indices)
    N(:, :, i) = M(:, :, indices(i));
end

end