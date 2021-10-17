% Ngan Jennifer Tram Su [260923530]

function y = concentration(Gn, Fom, r, z)
% Gn and z are vectors
% Fom and r are scalar

Gn(2:end) = [];

sum = 0;

for i = 1:length(Gn)
   sum = sum + Gn(i) * exp(-Fom * z(i)^2) * (1/(z(i) * r)) * sin(z(i) * r);  
end

y = 1 - sum;

end