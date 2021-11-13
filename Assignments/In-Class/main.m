% Ngan Jennifer Tram Su 260923530

clear
clc

%% Initialization

k = 0.2; % min^-1
t1 = 5; % min
t2 = 7; % min

Ca0 = 25; % mol/L

f = @(C)dc(C, Ca0, k, t1, t2);

%[xs, sol] = butcher([0, 0, 0, 0, 0]', f, 0, 10, 51);

ct = trapezoid(f, [0, 0, 0, 0, 0]', 10, 1001, 1e-2, 1e-12);
ct = ct';

%% Plotting
fh1=figure(1);
t=ct(:,end);
plot(t,ct(:,1),t,ct(:,2),t,ct(:,3),t,ct(:,4));
ylabel('Concentration (moles/L)','fontsize',15)
xlabel('Time (min)','fontsize',15)
title('Concentration vs. Time','fontsize',19)
hlegend=legend('C_{A1}','C_{B1}','C_{A2}','C_{B2}');
set(hlegend,'fontsize',14,'box','off','orientation','vertical', 'position',[0.2 0.75 0.05 0.1])
%set(gca,'box','off','xlim',[0 cf],'ylim',[0 Ca0],'TickDir','out', 'XTick',0:cf/10:cf);
print(figure(1),'-dpng','-r600','picture1')

%% Locate concentration



%% Locate max/min



%% Steady State