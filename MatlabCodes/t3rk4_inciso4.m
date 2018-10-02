clear all
h = 0.1;
t=0;
y = 1;

fprintf('Paso 0: t = %6.3f, y = %18.15f\n',t,y);
for ii = 1:126
    k1 = h*(cos(t) + sin(t));
    k2 = h*(cos(t+ h/2) + sin(t+ h/2));
    k3 = h*(cos(t+ h/2) + sin(t+ h/2));
    k4 = h*(cos(t+ h) + sin(t+ h));
    y = y + (k1+2*k2+2*k3+k4)/6;
    t = t+h;
    T(ii) = t;
    Y(ii) = y;
    fprintf('Paso %d: t = %6.3f, y = %18.15f\n',ii,t,y);
end

plot(T,Y);