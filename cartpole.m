function s = cartpole(t,init,F0,fext,m,M,b,c,l,g)
% init = (x0,x0',fi0,fi0')
s = zeros(4,1);
s(1) = init(2); %x'
s(2) = init(4); %fi'

M = [M+m,   m*l*cos(init(3));
    m*cos(init(3)),     m*l];
B = [F0*cos(2*pi*fext*t) - b*init(2) + m*l*sin(init(3))*init(4)*init(4);
    m*g*sin(init(3)) - c*init(4)];

X = transpose(inv(M)*B);

s(3) = X(1); %x''
s(4) = X(2); %fi''