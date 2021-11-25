% Ngan Jennifer Tram Su 260923530

clear
clc

%% Initialization

k = 0.2; % min^-1
t1 = 5; % min
t2 = 7; % min
Ca0 = 25; % mol/L

f = @(C)dc(C, Ca0, k, t1, t2);

% if integrating backwards, make h negative

%ct = butcher(zeros(5, 1), f, 0, 10, 10);

% initialize time vector -- have more control over the bounds of
% integration

t = linspace(0, 10, 50);

ct = impliciteuler(f, zeros(5, 1), 10001, 1e-3, 1e-12);
ct = ct';

t=ct(:,end);

%% Plotting
fh1=figure(1);
plot(t,ct(:,1),t,ct(:,2),t,ct(:,3),t,ct(:,4));
ylabel('Concentration (moles/L)','fontsize',15)
xlabel('Time (min)','fontsize',15)
title('Concentration vs. Time','fontsize',19)
hlegend=legend('C_{A1}','C_{B1}','C_{A2}','C_{B2}');
set(hlegend,'fontsize',14,'box','off','orientation','vertical', 'position',[0.2 0.75 0.05 0.1])
%set(gca,'box','off','xlim',[0 cf],'ylim',[0 Ca0],'TickDir','out', 'XTick',0:cf/10:cf);
print(figure(1),'-dpng','-r600','picture1')

%% Locate concentration
% Locate the concentration of any species at a given time and report all
% other species at that time

given_t = 10;

y = incpredict(t, ct(:, 1:end-1), given_t);

fprintf('At time %.2f min, the concentrations of each species are C_A1 = %.5f M, C_B1 = %.5f M, C_A2 = %.5f M, C_B2 = %.5f M.\n', given_t, y);

%% Locate max/min
% Locate the time and concentration of any species at the point that it has
% achieved its maximal or minimal value, if one exists
% It must also report the values of all other species at that time

species = 1;

mm = quicksortd(ct, 1, length(ct), species);

mm(1, :) % Minimum
mm(end, :) % Maximum

%% Steady State
% Compute the concentration of each species at steady-state

ss = @(C)dc2(C, Ca0, k, t1, t2);
cg = ct(end, 1:end-1);

ssc = newtonrm(ss, cg, 1e-12);

fprintf('The steady state concentrations are C_A1 = %.5f M, C_B1 = %.5f M, C_A2 = %.5f M, C_B2 = %.5f M.\n', ssc);
