function y = hygro(Bim, z)

y = Bim - 1 + z * cot(z);

end