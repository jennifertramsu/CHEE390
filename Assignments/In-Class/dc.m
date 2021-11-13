function y=dc(C, Ca0, k, t1, t2)

y = [
    (Ca0 - C(1))/t1 - k*C(1);
    -C(2)/t1 + k*C(1);
    (C(1) - C(3))/t2 - k*C(3);
    (C(2) - C(4))/t2 + k*C(3);
    1
    ];

end