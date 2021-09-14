% Lecture 4 - Sept. 14, 2021

function [z]=linscan(v, vs, tol, n)
% v = array to be scanned
% vs = value to find
% tol = absolute tolerance search condition
% n = number of values want to search for
% --> will return all values within tolerance

% linear scanner
% (c) 2010 - Phillip Servio

i = 1; % searching index
j = 0; % storing index
z = zeros(n, 2);

while i <= length(v)
    if abs(v(i) - vs) < tol
        j = j + 1;
        z(j, :) = [i v(i)]; % suppose we want to find the value and the index
    end
    i = i + 1;
end

if j == 0
    error('No value found')
else
    z(j + 1: end, :) = []; % destroying memory of unused elements in array
end

end