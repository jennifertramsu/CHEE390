function M = main(M)

[x y z] = size(M); % Getting size of matrix
lst = zeros(z, 2); % Initialize array to store sums and their corresponding plane

for i = 1:z % loop over matrix's planes
    lst(i, 1) = sums(M(:,:,i)); % assign diagonal sum to first column value in lst
    lst(i, 2) = i; % assign plane number to second column in lst
end

lst = sortrows(lst); % sorts rows based on the first element (sum), ascending order
indices = lst(:, 2); % grabbing original indices of plane

for i=1:length(indices)
    
    if indices(i) < i % already swapped
        continue
    end
    
    M = swappages(M, i, indices(i));
end

end

