clear T Y
h = 0.25;
t=0;
y =1;

RK_f = @(t,y) 2*sin(t) + cos(t) + 1;
fprintf('Paso 0: t = %6.3f, y = %18.15f\n',t,y);

for ii = 1:100
    k1 = h* RK_f(t,y);
    k2 = h* RK_f(t+h/2,y+k1/2);
    k3 = h* RK_f(t+h/2,y+k2/2);
    k4 = h* RK_f(t+h,y+k3);
    y = y + (k1+2*k2+2*k3+k4)/6;
    t = t+h;
    
    T(ii) = t;
    Y(ii) = y;
    
    fprintf('Paso %d: t = %6.3f, y = %18.15f\n',ii,t,y);   
end

figure
plot(T,Y, 'r');
xlabel('t');
ylabel('y');