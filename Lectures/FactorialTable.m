% Lecture 2 - Sept. 7, 2021
% This script generates a table listing the factorials from 0! to 10!

table = zeros(11, 2);
prev=1;
table(1, 1)=0;
table(1, 2)=1;
for i=2:11
    table(i, 1)=i-1;
    table(i, 2) = (i-1)*prev;
    prev = table(i, 2);
end
disp(table);