function r = rcon(a)

norm = max(sum(abs(a)));
norminv = max(sum(abs(inverse(a))));

r = 1 / (norm * norminv);

end