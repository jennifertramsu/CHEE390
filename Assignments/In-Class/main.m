% Ngan Jennifer Tram Su 260923530

clear
clc

%% Initialization

k = 0.2; % min^-1, rate constant
t1 = 5; % min, residence time
t2 = 7; % min, residence time
Ca0 = 25; % mol/L, feed concentration

f = @(C)dc(C, Ca0, k, t1, t2);

c0 = [0 0 0 0 0]'; % Initial concentrations

dx = 1e-3; % Step size
t0 = 0; % Initial time
tf = 10; % Final time

%% put everything in one function !!

t = t0:dx:tf;

% [1] euler, [2] trapezoid, [3] Butcher's

ct = rk(f, t, c0, 1e-12, 3);
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

min = mm(1, :); % Minimum
max = mm(end, :); % Maximum

fprintf('For species %d, a minimum of %.5f M is found at time %.2f min.\n', species, min(species), min(end));
fprintf('For species %d, a maximum of %.5f M is found at time %.2f min.\n', species, max(species), max(end));

%% Steady State
% Compute the concentration of each species at steady-state

ss = @(C)dc2(C, Ca0, k, t1, t2);
cg = ct(end, 1:end-1);

ssc = newtonrm(ss, cg, 1e-12);

fprintf('The steady state concentrations are C_A1 = %.5f M, C_B1 = %.5f M, C_A2 = %.5f M, C_B2 = %.5f M.\n', ssc);
