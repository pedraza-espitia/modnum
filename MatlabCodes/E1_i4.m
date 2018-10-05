% Pedraza-Espitia S.

x=0:10;
y = [6.7461 7.5353 16.6759 34.5762 55.3070 ...
    77.2926 115.1883 ...
    155.2697 199.3399 262.4105 307.6214];

H = [ ones(11,1) x' x.^2' ];

Coef = inv(H'*H)*H'*y';
disp(Coef) % [5.9434 -0.4856 3.1150]

yestim = Coef(1) + Coef(2)*x + Coef(3)*x.^2;

figure
plot( x , yestim )
hold on
plot( x , y, '.' )
legend('Estimacion', 'Datos Orig');
xlabel('x');
ylabel('y');