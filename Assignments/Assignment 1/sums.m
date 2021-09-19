function s = sums(M) % M is a plane-component of the multi-dimensional array
% Calculate the sum of the diagonal in a square matrix plane

[x, ~, ~] = size(M);

s = 0; % Initialize sum variable

for i = 1:x % loop over matrix rows
    s = s + M(i, i); % Add diagonal value to sum variable
end 

end 


