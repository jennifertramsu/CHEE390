% Lecture 2 - Sept. 7, 2021

function n=Factorial(m)
% This returns the factorial of the integer m
if mod(m, 1) == 0
    if m == 0
        n = 1;
    else
        n = 1;
        rem=m;
        while rem>1
            n = n*rem;
            rem = rem-1;
        end
    end
else
    error('Value needs to be an integer!')
end
