function [a, b, c, d] = thomasprep(m, n)
% Extracts the a, b, c, and d coefficient vectors from a tridiagonal matrix
% m = tridiagonal matrix
% n = number of points

a = zeros(n-2, 1);
b = zeros(n-2, 1);
c = zeros(n-2, 1);

for i = 1:n-1 % Iterate through each row of the matrix
    
    if i ~= 1
        a(i) = m(i, i-1);
    else
        a(i) = 0; % Because vo is known, goes into constant matrix
    end
    
    b(i) = m(i, i);
    
    if i ~= n - 1
        c(i) = m(i, i + 1);
    else
        c(i) = 0; % Because vb is known, goes into constant matrix
    end
    
end

d = m(:, end); % Last column

end