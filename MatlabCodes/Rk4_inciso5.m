clear T Y
h = 0.01;
t=0;
y =.5;

RK_f = @(t,y) y - 2*t^3 + 2;
fprintf('Paso 0: t = %6.3f, y = %18.15f\n',t,y);
for ii = 1:400
    k1 = h* RK_f(t,y);
    k2 = h* RK_f(t+h/2,y+k1/2);
    k3 = h* RK_f(t+h/2,y+k1/2);
    k4 = h* RK_f(t+h,y+k3);
    y = y + (k1+2*k2+2*k3+k4)/6;
    t = t+h;
    T(ii) = t;
    Y(ii) = y;
    fprintf('Paso %d: t = %6.3f, y = %18.15f\n',ii,t,y);
end

plot(T,Y, 'c');