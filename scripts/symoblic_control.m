clear
clc

syms a1 a2 a3 a4 Ka Da Jm eta Kt Ke Lm Rm Dm s

A = [0, 1, 0, 0, 0;
    a1*a3^2-Ka/(a2*a3^2), -Da/(a2*a3^2), a4*Ka/(a2*a3), a4*Da/(a2*a3), 0;
    0, 0, 0, 1, 0;
    a4*Ka/(eta*Jm*a3), a4*Da/(eta*Jm*a3), -a4^2*Ka/(eta*Jm)-a4^2*Da/(eta*Jm*a3), -Dm/Jm, Kt/Jm;
    0, 0, 0, -Ke/Lm, -Rm/Lm];

Tf = det(inv(s*eye(5)-A));

syms s;
Gp = simplify(C / (s*eye(size(A)) - A) * B + D);