A = [a11 a12; a21 a22];
B = [b1; b2];
%G = [g1 g2];
G = [g11 g12; g21 g22];
%Q = [q11 q12; q21 q22]
Q = G'*G;

R = r;
% R = [r1; r2];

[K,S,e] = lqr(A,B,Q,R,0);