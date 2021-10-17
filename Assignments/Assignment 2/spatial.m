% Ngan Jennifer Tram Su [260923530]

function theta = spatial(Bim, Fo, name)
% This program outputs a matrix of spatial concentration where the row
% corresponds to the radius and the column corresponds to the time
% Bim = Biot number
% Fo = array of Fourier numbers
% name = string name for produced plots specific to Biot number
%% Initialization
dr = 100;
rs = eps:(1-eps)/dr:1;

theta = zeros(length(rs), length(Fo));

%% Spatial Concentration
% Brent on hygroscopicity
h = @(x)hygro(Bim, x);
[z, ~] = brent(h, 0, 10000, 1e-2, 1e-12);

g = Gn(z);

% Creating matrix
for i = 1:length(rs)
    for j = 1:length(Fo)
        theta(i, j) = concentration(g, Fo(j), rs(i), z);
    end
end

% Producing plots
plotconc(rs, Fo, dr, theta, name)

end