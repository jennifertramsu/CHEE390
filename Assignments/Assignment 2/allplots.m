% Ngan Jennifer Tram Su [260923530]

% Plots for all Biot Numbers
% Separate from main program - this code will produce the plots for all
% Biot numbers and save to the working directory

% Instructions: Click Run

Bim = [0.01, 0.1, 1, 10, 1000];

Fr = [1e-6, 2];
df = 100;
Fo = Fr(1):(Fr(2)-Fr(1))/df:Fr(2);

for i = 1:length(Bim)
    name = strcat(num2str(Bim(i)));
    theta = spatial(Bim(i), Fo, name);
end