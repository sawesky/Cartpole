function sol = constraint_s_m(t,init,F0,fext,g,m,M,l,ksi)
% init = (x0,x0', ro0, ro0', fi0, fi0', lambda0)
sol = zeros(7,1);
sol(1) = init(2); %x'
sol(3) = init(4); %ro'
sol(5) = init(6); %fi'

M = [M+m,   -m*sin(init(5)),    m*init(3)*cos(init(5)),    0;
    m*sin(init(5)),     m,      0,      -1;
    m*init(3)*cos(init(5)),     0,      m*init(3)*init(3),      0;
    0,      1,      0,      0];
B = [F0*cos(2*pi*fext*t) + m*init(3)*sin(init(5))*init(6)*init(6) - 2*m*init(4)*cos(init(5))*init(6);
    m*init(3)*init(6)*init(6) - m*g*cos(init(5));
    m*g*init(3)*sin(init(5)) - 2*m*init(3)*init(4)*init(6);
    -2*ksi*init(4) - ksi*ksi*(init(3)-l)];

X = transpose (inv(M)*B);

sol(2) = X(1); %x''
sol(4) = X(2); %ro''
sol(6) = X(3); %fi''
sol(7) = X(4); %lambda
end