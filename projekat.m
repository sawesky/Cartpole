clear all
close all
clc

t = linspace (0,60,10000);
m = 0.1;
M = 1;
l = 1;
g = 9.81;
F0 = 0.1;
fext = 0.0005;
ksi = 10^8;
c = 0.005;
b = 0.001;
init1 = [0,0,l,0,0,0,m*g]; %x0=0, x0'=0, ro0=l, ro0'=0, fi0=0, fi0'=0, lambda0 = m*g
options = odeset;
[t,y] = ode45(@constraint_s_m,t,init1,options,F0,fext,g,m,M,l,ksi);
% y -> x,x',ro,ro',fi,fi',lambda


yM = zeros(1,10000);
% trajektorija bloka mase M 
figure(1)
plot(y(:,1),yM);
title('Trajektorija bloka');
grid on

% trajektorija kuglice mase m
figure(2)
plot(y(:,1) + y(:,3).*cos(y(:,5)), y(:,3).*sin(y(:,5)));
title('Trajektorija kuglice');
grid on

% zavisnost ugla otklona fi od vremena
figure(3)
plot(t,y(:,5));
title('Zavisnost ugla otklona od vremena');
grid on

%zavisnost ugaone brzine kuglice od vremena 
figure(4)
plot(t,y(:,6));
title('Zavisnost ugaone brzine kuglice od vremena')
grid on

%zavisnost ubrzanja bloka od vremena
%diferenciranjem vektora x' dobijeno je ubrzanje aM -> aM = d(x')/h
%h <=> korak diferenciranja = ukupno vreme/broj tacaka (15/30000)

h = 10/10000;
aM = diff(y(:,2))/h;
t1 = linspace(0,10,9999);

figure(5)
plot(t1,aM);
title('Zavisnost ubrzanja bloka od vremena');
grid on;

%zavisnost sile ogranicenja od vremena
figure(6)
plot(t,y(:,7));
title('Zavisnost sile ogranicenja od vremena');
grid on

%zavisnost jednacine ogranicenja od vremena
figure(7)
f = y(:,3) - l;
plot(t,f);
title('Zavisnost jednacine ogranicenja od vremena');
grid on

frequencies = [10^(-6) 10^(-3) 1];
init2 = [0,0,0,0]; %x0 = 0, x0' = 0, fi0 = 0, fi0' = 0

t2 = linspace(0,100,1000);
for i=1:3
    options = odeset;
    [t,z] = ode45(@cartpole,t2,init2,options,F0,frequencies(i),m,M,b,c,l,g);
    figure(4*i+4)
    plot(t2,z(:,1));
    title(['x(t) pri frekvenciji ',num2str(frequencies(i)),'Hz']);
    grid on
    figure(4*i+5);
    plot(t2,z(:,2));
    title(['Vx(t) pri frekvenciji ',num2str(frequencies(i)),'Hz']);
    grid on
    figure(4*i+6);
    plot(t2,z(:,3));
    title(['fi(t) pri frekvenciji ',num2str(frequencies(i)),'Hz']);
    grid on
    figure(4*i+7);
    plot(t2,z(:,4));
    title(['Vfi(t) pri frekvenciji ',num2str(frequencies(i)),'Hz']);
    grid on
end

