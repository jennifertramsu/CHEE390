function y = invgjp(j, f)

a = [j f];

%y = inverse(j) * f;

y = gelim(a);

end