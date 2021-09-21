% Lecture 6 - Sept. 21, 2021

function fp = der(fun, x, h)
% Calculates the derivative of a function numerically based
% on the 5-pt Stencil
% (c) 2011 Phillip Servio

fp = (-feval(fun,x+2*h) + 8*feval(fun,x+h) - 8*feval(fun,x-h)...
    + feval(fun,x-2*h))/(12*h);

end