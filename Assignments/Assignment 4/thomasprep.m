function [a, b, c, d] = thomasprep(m, n)
% Extracts the a, b, c, and d vectors from a tridiagonal matrix
% m = tridiagonal matrix
% n = number of points
a = zeros(n-2, 1);
b = zeros(n-2, 1);
c = zeros(n-2, 1);

j = 1; % Keep track of index in a, b, c

for i = 1:n-1 % Iterate through each row of the matrix
    
    if i ~= 1
        a(j) = m(i, i-1);
    else
        a(j) = 0; % Because vo is known, goes into constant matrix
    end
    
    b(j) = m(i, i);
    
    if i ~= n - 1
        c(j) = m(i, i + 1);
    else
        c(j) = 0; % Because vb is known, goes into constant matrix
    end
    
    j = j + 1; % Update index
    
end

d = m(:, end); % Last column

end