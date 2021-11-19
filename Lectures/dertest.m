% Program that creates a table of the derivative of the function y=e^x
% using the 5-pt stencil with varying step size and Richardson 
% extrapoloation. The program also displays and plots the error vs h
% (c) 2011 Phillip Servio

clear 
clc
clf
format longe
%addpath('/Users/servio/My Drive/MatProgs/Roots/richardson')
fun= @(x) fundertest(x);
h=1;
n=16;
hv=ones(1,n);
x=1;
fp=ones(n,1);
for i=1:n
    hv(i)=h;
    fp(i)=der(fun,x,h);
    h=h/10; 
end
z(1:n,1)=feval(fun,x);
z(1:n,2)=fp;
z(1:n,3)=hv;
z(1:n,4)=abs(z(:,1)-z(:,2));
z(1:n,5)=abs((z(:,1)-z(:,2))./z(:,1));
disp('           Real Value                   5-Pt                       h                   Absolute Error            Relative Error')
disp('     -----------------------------------------------------------------------------------------------------------------------------')
disp(z)
%% Richardson
[dydx, n]=richext(fun,x,1e-8);
hr=.2/2^(length(n)-1);
disp('           Real Value              Richardson Ext.                 h                   Absolute Error            Relative Error')
disp('     -----------------------------------------------------------------------------------------------------------------------------')
zR=[z(1,1) dydx hr abs(z(1,1)-dydx) abs((z(1,1)-dydx)/z(1,1))];
disp(zR)

%% Plotting
fh1=figure(1);
loglog(flip(hv),flip(abs(z(:,4))))
set(gca,'TickDir','out')
legend({'Total Error'},'Location','west')
legend boxoff
box off
ylabel('Total Error')
xlabel('Step Size, h')
title('Total error in 5-Pt Stencil vs. Step Size')
subtitle('{f(x)=e^x @ x=1}')
print(figure(1),'-dpng','-r600','Error')
