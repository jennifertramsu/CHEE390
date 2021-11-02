function r = rcon(a, inv)

norm = max(sum(abs(a)));
norminv = max(sum(abs(inv)));

r = 1 / (norm * norminv);

end