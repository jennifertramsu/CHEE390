Bim = [1000];

for b = 1:length(Bim)
    clf
    
    Fr = [1e-6, 2];
    
    dr = 100;
    df = 100;
    
    Fo = Fr(1):(Fr(2)-Fr(1))/df:Fr(2);
    rs = eps:(1-eps)/dr:1;
    
    % Brent on hygroscopicity
    
    h = @(x)hygro(Bim(b), x);
    [z, ns] = brent(h, 0, 10000, 1e-4, 1e-12);
    
    g = Gn(z);
    
    theta = zeros(length(rs), length(Fo));
    
    for i = 1:length(rs)
        for j = 1:length(Fo)
            theta(i, j) = concentration(g, Fo(j), rs(i), z);
        end
    end
    
    name = strcat('Bim = ', num2str(Bim(b)));
    plotconc(rs, Fo, dr, theta, name)
end

% Time it takes for centerline concentration to reach a certain value