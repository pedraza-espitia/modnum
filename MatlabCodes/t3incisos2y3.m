% author Pedraza-Espitia S.
% divergencia y rotacional
close all
clear all

%Ruta = ['/media/salva/exfat/'];
%Ruta = ['/media/sf_salida_WRF/'];
Ruta = ['/media/sal/exfat/'];
Arch = [Ruta,'wrfout_d02_2012-08-08_00_UVW.nc'];
%ncdisp(Arch)

Tiempo = ncread(Arch,'Times')';
Times_l = length(Tiempo);
        % [DesdeX , Y, T] [HastaX, Y, T] [cUAL]
XLAT = ncread(Arch,'XLAT', [1 1 1], [Inf Inf 1], [1 1 1]);
XLAT = double(XLAT);
XLONG = ncread(Arch,'XLONG', [1 1 1], [Inf Inf 1], [1 1 1]);
XLONG = double(XLONG);

U10 = ncread(Arch,'U10');
V10 = ncread(Arch,'V10');


for ii=1:Times_l(1)
    Uii = double(U10(:,:,ii));
    Vii = double(V10(:,:,ii));
    Speed = sqrt(Uii.^2+Vii.^2);
    pcolor(XLONG,XLAT,Speed), shading flat, caxis([0 30]),colorbar
    pause(.1)
end

%% convertir diferenciales Dx Dy
[xx,yy,tt] = size(U10);
R = 6370e3;
[Nx,Ny] = size(XLAT);

Del2X = zeros(Nx,Ny);
Del2Y = zeros(Nx,Ny);
for ii = 2:Nx-1;
    for jj = 2:Ny-1
        Del2X(ii,jj) = R*cos((pi/180)*XLAT(ii,jj))*(XLONG(ii+1,jj)-XLONG(ii-1,jj))*pi/180;
        Del2Y(ii,jj) = R*(XLAT(ii,jj+1)-XLAT(ii,jj-1))*pi/180;
    end
end

Div = zeros(Nx,Ny,tt);
Rot = zeros(Nx,Ny,tt);
%% calculo divergencia
for kk=1:tt
    U=double(U10(:,:,kk));
    V=double(V10(:,:,kk));
    for ii = 2:Nx-1;
        for jj = 2:Ny-1;
            Div(ii,jj,kk) = (U(ii+1,jj)-U(ii-1,jj))/Del2X(ii,jj) + (V(ii,jj+1)-V(ii,jj-1))/Del2Y(ii,jj);
        end
    end
end

figst = [24 29 34 39];
num = 1;
for kk=1:Times_l(1)
   pcolor(XLONG,XLAT,Div(:,:,kk)),shading flat, caxis([-1e-3 1e-3]), colorbar
   title(int2str(kk))
   if figst(num) == kk
        nombreimg = ['t3div',num2str(num),'.jpeg'];
        print(nombreimg,'-djpeg','-r0')
        if num < 4
            num = num+1;
        else
            continue
        end
   end
   pause(.2)
end

%% calculo Rotacional
Uu = ncread(Arch,'U');
Vv = ncread(Arch,'V');
for kk=1:tt
    U=double(Uu(:,:,8,kk));
    V=double(Vv(:,:,8,kk));
    for ii = 2:Nx-1;
        for jj = 2:Ny-1;
            Rot(ii,jj,kk) = (V(ii,jj+1)-V(ii,jj-1))/Del2X(ii,jj) - (U(ii+1,jj)-U(ii-1,jj))/Del2Y(ii,jj);
        end
    end
end

figst = [24 29 34 39];
num = 1;
for kk=1:Times_l(1)
   pcolor(XLONG,XLAT,Rot(:,:,kk)),shading flat, caxis([-1e-3 1e-3]), colorbar
   title(int2str(kk))
   pause(.2)
   if figst(num) == kk
        nombreimg = ['t3rot',num2str(num),'.jpeg'];
        print(nombreimg,'-djpeg','-r0')
        if num < 4
            num = num+1;
        else
            continue
        end
   end
end

