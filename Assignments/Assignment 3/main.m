% Ngan Jennifer Tram Su [260923530]

clear
clc

% Main Program - Plotting Van Laar activity coefficients

%% Initialization

Tc = 125 + 273.15; % K
T = linspace(Tc, 20 + 273.15, 500); % decreasing from 125 to 20 deg C
S = zeros(length(T), 6);
xg = [0.37, 0.37];
dx = 0.02;

k = (xg(1) * (1 + (1 - xg(2)))) / ((1 - xg(2)) * (1 + xg(1)));
a = (Tc * (xg(1) + (1 - xg(2))*k)^3) / (2*xg(1)*(1 - xg(2))*k^2);
b = a*k;

A = a ./ T;
B = b ./ T;

r = @(x) residual(x, A(1), B(1));
y = feval(r, xg);

S(1, :) = [T(1) - 273.15, xg, y', 1];
xg = [xg(1) - dx, xg(2) + dx];

%% Iterate over temperature to obtain new Van Laars constants

for t = 2:length(T)
    
    r = @(x) residual(x, A(t), B(t));
    [xn, i] = newtonrm(r, xg, 1e-2, 1e-12);
    y = feval(r, xn);
    S(t, :) = [T(t) - 273.15, xn', y', i]; % Converting temperature to deg C
    xg = xn; % Zero-order continuation
    
end

S

%% Plotting

figure(1)

subplot(2,1,1)

AX=plot(S(:,2),S(:,1),S(:,3),S(:,1));

ylabel('{T ( {}^oC )}','FontSize',12)

xlabel('x_1','FontSize',12)

title('Temperature vs x_1','FontSize',14)

set(gca,'ylim',[15 130],'box','off','TickDir', 'out','XTick',0:0.1:1)

hlegend=legend('{x_1}^\alpha', '{x_1}^\beta');

set(hlegend,'fontsize',10,'box','off','units','normalized','position',[0.8 0.8 0.05 0.1], 'fontangle','italic','orientation','vertical')

annotation('textbox',[.14 .72 .1 .2], 'String','(a)','EdgeColor','none')

subplot(2,1,2)

stem(S(:,4:5));

title('Residual','FontSize',14)

ylabel('Residual [{\it f},{\it g}]','FontSize',12)

xlabel('Data Set #','FontSize',12)

set(gca,'box','off','TickDir', 'out')

hlegend=legend('f', 'g');

set(hlegend,'fontsize',10,'box','off','units','normalized', 'position',[0.2 0.35 0.05 0.1], 'fontangle','italic','orientation','vertical')

annotation('textbox',[.14 .245 .1 .2], 'String','(b)','EdgeColor','none')

print(figure(1),'-dpng','-r600','Tx')