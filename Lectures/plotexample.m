% Lecture 3 - Sept. 9, 2021
% Plotting example

x = linspace(0, 1);

for i=1:length(x)
    y = sin(5*x);
end

figure(1)
plot(x, y, 'k', 'LineWidth', 2)
xlabel('x', 'FontSize', 18) % labels as strings!
ylabel('sin(5x)', 'FontSize', 18) % specifying font size
title("Plot of f(x)=sin(5*x)", 'FontSize', 18)