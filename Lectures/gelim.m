% Lecture 7 - Sept. 23, 2021

function [x] = gelim(a)

% Gaussian elimination
% a = matrix for the left hand side.
% b = vector for the right hand side
% x = solution
% copyright 2010 - Phillip Servio

% k = pivot row

% Checking dimensions

mn=size(a);
m=mn(1);
n=mn(2);

if n ~= m+1 % Because last column is constant matrix
    error('a matrix is not square')
end

% Perform Gaussian elimination

for k = 1:m-1 % There's no pivot in the last row
    for i = k+1:m % Starting with row below pivot row
        p = a(i,k)/a(k,k);
        a(i,:) = a(i,:) - a(k,:)*p; % Takes care of all elements in row
    end
end

% Separate matrix a from vector b

b = a(:,n);
a(:,n) = [];

% Perform back substitution

x = zeros(m,1);
x(m) = b(m)/a(m,m); % Saving all x values in row vector

for j=m-1:-1:1
    x(j) = (b(j)-a(j,j+1:m)*x(j+1:m))/a(j,j);
end

end