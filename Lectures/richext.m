function [dydx,n]=richext(fun,x,tol) 
%Richardson extrapolation for calculating the derivative
%of a function, fun, at a point, x, with a given tolerance,
%tol.
%(c) 2013, Phillip Servio

h=0.2;
kmax=10;
n=zeros(kmax);
n(1,1)=(feval(fun,x+h)-feval(fun,x-h))/(2*h);

for k=2:kmax
    
    h=h/2;
    n(k,1)=(feval(fun,x+h)-feval(fun,x-h))/(2*h);
    
    for j=2:k
        p=4^(j-1);
        n(k,j)=(p*n(k,j-1)-n(k-1,j-1))/(p-1);
    end
    
    if n(k,k)>=1
        check=abs((n(k,k)-n(k-1,k-1))/n(k,k));
    else
        check=abs(n(k,k)-n(k-1,k-1));
    end
    
    if check<=tol
        dydx=n(k,k);
        n(k+1:kmax,:)=[];
        n(:,k+1:kmax)=[];
        break
    end
end
