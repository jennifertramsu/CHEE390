% Ngan Jennifer Tram Su 260923530
% Main Program that solves for the velocity profile of a Newtonian fluid
% undergoing laminar, pressure-driven flow between two infinite parallel
% flat plates separated by a distance B

% Instructions to run: Press Run, and input vo, vb, and dpdx in command
% window as prompted

clear
clc

%% Inputting conditions

p = 1e3; % kg/m^3
mu = 1e-3; % Pa s
B = 1e-3; % m 
vo = input('Please input the velocity at y = 0 (m/s): ');
vb = input('Please input the velocity at y = B (m/s): ');
dpdx = input('Please input the pressure gradient (Pa/m): ');

%% Initialization
n = 50;
dx = B / n; % 50 - 1 = 49 points

% Tridiagonal  -- matrix | constant matrix
m = zeros(n-1, n);

% First row

m(1, [1:2, end]) = [-2*mu/(dx^2), mu/(dx^2), dpdx - (mu*vo)/(dx^2)];

% Last row

m(end, end-2:end) = [mu/(dx^2), -2*mu/(dx^2), dpdx - (mu*vb)/(dx^2)];

% All other rows

for i = 2:n-2
    m(i, [i-1, i, i + 1, end]) = [mu/(dx^2), -2*mu/(dx^2), mu/(dx^2), dpdx];
end

% Extracting, a, b, c, d

[a, b, c, d] = thomasprep(m, n);

% Call Thomas Algorithm
tic
v = thomas(a, b, c, d);
toc

% Comparing time elapsed with Gaussian Elimination
tic
gelim(m(:, 1:end-1), m(:, end));
toc

v = [vo v vb]; % Appending boundary conditions

%% Calculating Average Velocity

% After some simplification, v_av = integral(vx) dy / B

av = simpson(v, 0, B, n+1) / B;

fprintf('The average velocity is %.3e m/s.\n', av);

%% Calculating Reynold's number

Re = p*av*B/mu;

fprintf('The Reynold''s numbers is %.5f.\n', Re);

%% Plotting
% Phillip Servio (c) 2021

x = linspace(0, B, n+1);

ymin=min(v);

ymax=max(v);

dym=.05*abs(ymin-ymax);

fh=figure(1);

whitebg('w');

set(fh,'color','w')

AX=plot(x,v,[0 B],[av av],'--b');

xlabel('y (m)','fontsize',10)

ylabel('V_x(y) (m/s)','fontsize',10)

title('Velocity Profile', 'fontsize',12)

%hlegend=legend('V_x','V_{avg}');

%set(hlegend,'fontsize',12,'box','off','orientation','vertical')

set(gca,'box','off','TickDir', 'out')

txt1 = ['V_{avg} = ' (num2str(av,'%10.3e\n')) ' m/s'];

text(0.5e-5,av+dym,txt1,'color','b')

txt2 = ['Re = ' (num2str(Re))];

text(0.5e-5,av-dym,txt2,'color','b')

hold on

stem(x,v,'filled','MarkerSize',3);

hold off

print(figure(1),'-dpng','-r600','profile')

% %% Crappy Plotting, but I was proud of it
% y = linspace(0, B, n+1);
% 
% figure(1)
% 
% plot(y, v);
% 
% hold on 
% stem(y, v, 'Marker', '.', 'Color', [0.9290 0.6940 0.1250])
% hold off
% 
% hold on
% yline(v_av, 'LineStyle', ':', 'Color', 'blue', 'LineWidth', 1);
% text(dx, v_av + dx/2, ['V_{avg} = ', num2str(v_av, '%.3e')]);
% text(dx, v_av - dx/2, ['Re = ', num2str(Re, '%.5f')]);
% hold off
% 
% title('Velocity Profile', 'fontsize', 12);
% xlabel('y (m)');
% ylabel('V_x(y) (m/s)');
% yLim = get(gca,'YLim');
% 
% if min(v) > 0
%     set(gca,'YLim', [0 yLim(2)]);
% else
%     set(gca,'YLim', [min(v) yLim(2)]);
% end
% 
% print(figure(1),'-dpng','-r600','profile1')
