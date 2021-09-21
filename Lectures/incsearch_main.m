% Lecture 6 - Sept. 21, 2021

clear;
clc;
clf;
format longg
xi = 0;
xf = 20*pi;

func = @(x) fun(x);
[r, nrf] = incsearch(func, xi, xf, 1e-2, 1e-12);

%%%%%%%%%

y = feval(func, r);
z = [r y];
whitebg('white')
fh = figure(1);
set(fh, 'color', 'white');
title('Incremental Search Performance','fontsize', 16, 'fontangle', 'italic')
subplot(2, 1, 1)
stem(r, y)
title('Incremental Search Performance', 'fontsize', 16, 'fontangle', 'italic', 'color', 'red')
set(gca, 'fontsize', 12, 'box', 'off', 'TickDir', 'out')
xlabel('root', 'Fontsize', 12)
ylabel('error', 'Fontsize', 12)
subplot(2, 1, 2)
fplot(func, [xi xf])
set(gca, 'fontsize', 12, 'box', 'off', 'TickDir', 'out')
xlabel('x', 'Fontsize', 12)
ylabel('y', 'Fontsize', 12)
print(fh, '-dpng', '-r600', 'picture1')