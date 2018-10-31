clear 
close all
u(1:1:100) = 0;
c= 1;
Del_T = 1; % con 2.1; se vuelve inestable
Del_X = 1;

%condicion inicial
for jj = -40:40
    u(1,jj+50) = 1 + cos(pi*jj/40);
end
plot(u)

% se incluye la cond inicial
u2(:,1) = u;

n=1;
for jj = 2:80
    u2(jj,n+1) = u2(jj,n) - c*(Del_T/2*Del_X)*(u2(jj+1,n) - u2(jj-1,n));
end

hold on
plot(u2);

%a partir del tiempo 2

for n=2:180
    for jj=2:99
            u2(jj,n+1) = u2(jj,n-1) - c*(Del_T/2*Del_X)*(u2(jj+1,n) - u2(jj-1,n));
    end
    u3=u2;
    u2(1,n+1) = u3(99,n+1);
    u2(100,n+1) = u3(2,n+1);
    plot(u2(:,n))
    pause(.1)
end
figure
pcolor(u2'), caxis([-2 2]), shading flat, colorbar