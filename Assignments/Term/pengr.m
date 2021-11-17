function P = pengr()

R = 8.314; % m3 Pa K−1 mol−1

P = R*T / (v - b) - a(T) / ((v * (v + b)) + b*(v - b));

end
