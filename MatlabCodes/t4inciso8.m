clear 
close all

%% condicion inicial
u(1:1:200) = 0;
for jj = -20:20
    u(1,jj+50) = 1 + cos(pi*jj/20);
end
%plot(u)


c = .5;
Del_T = 1;
Del_X = 1;

u5(1:200,1:80)=0;
u5(:,1)=u;

%% primer paso t=1
n=1;
for jj = 2:99
    u5(jj,n+1) = u5(jj,n) - c*(Del_T/2*Del_X)*(u5(jj+1,n) - u5(jj-1,n));
end

%% pasos t = 2:80
for n=2:80
    for jj=3:198
        u5(jj,n+1) = u5(jj,n-1) - ...
            c*2*(Del_T/Del_X)*( ((4/6)*(u5(jj+1,n) -u5(jj-1,n)) ) - ...
            (1/12)*( u5(jj+2,n) - u5(jj-2,n)) );
    end
    for jj = 199:199
        if c>0
           u5(jj,n+1) = u5(jj,n) - c*(Del_T/Del_X)*(u5(jj,n) - u5(jj-1,n));
        else
           u5(jj,n+1) = u5(jj,n) -  c*(Del_T/Del_X)*(u5(jj+1,n) - u5(jj,n));
        end
    end
    
    for jj = 2:2
        if c>0
           u5(jj,n+1) = u5(jj,n) - c*(Del_T/Del_X)*(u5(jj,n) - u5(jj-1,n));
        else
           u5(jj,n+1) = u5(jj,n) - c*(Del_T/Del_X)*(u5(jj+1,n) - u5(jj,n));
        end
    end
u5(1,n+1) = u5(199,n+1);
u5(200,n+1) = u5(2,n+1);
end
    
figure
pcolor(u5'), caxis([-2,2]), shading flat,colorbar
