% author Pedraza-Espitia S.
% divergencia E1
close all
clear all

%Ruta = ['/media/salva/exfat/'];
Ruta = ['/media/sf_salida_WRF/'];
%Ruta = ['/media/sal/exfat/'];
Arch = [Ruta,'wrfout_d02_2012-08-08_00_UVW.nc'];
%ncdisp(Arch)

Tiempo = ncread(Arch,'Times')';
Times_l = length(Tiempo);

XLAT = ncread(Arch,'XLAT', [1 1 1], [Inf Inf 1], [1 1 1]);
XLAT = double(XLAT);
XLONG = ncread(Arch,'XLONG', [1 1 1], [Inf Inf 1], [1 1 1]);
XLONG = double(XLONG);
PSFC = ncread(Arch,'PSFC', [1 1 1], [Inf Inf 1], [1 1 1]);
PSFC = double(PSFC);

%% grafica presion en superficie
pcolor(XLONG,XLAT,PSFC), shading flat,colorbar

% U y V en el nivel 3
U3 = ncread(Arch,'U', [1 1 3 1], [Inf Inf 1 inf], [1 1 1 1]);
U3 = double(squeeze(U3));
V3 = ncread(Arch,'V', [1 1 3 1], [Inf Inf 1 inf], [1 1 1 1]);
V3 = double(squeeze(V3));


%% convertir diferenciales Dx Dy
[xx,yy,tt] = size(U3);
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
%% calculo divergencia
for kk=1:tt
    U=double(U3(:,:,kk));
    V=double(V3(:,:,kk));
    for ii = 2:Nx-1;
        for jj = 2:Ny-1;
            Div(ii,jj,kk) = (U(ii+1,jj)-U(ii-1,jj))/Del2X(ii,jj) + (V(ii,jj+1)-V(ii,jj-1))/Del2Y(ii,jj);
        end
    end
end

maximos = zeros(121,2);
for kk=1:Times_l(1)
   ss = Div(:,:,kk);
   [M,I] = max(ss(:));
   maximos(kk,1) = M;
   maximos(kk,2) = I;
   pcolor(XLONG,XLAT,Div(:,:,kk)),shading flat, caxis([-1e-3 1e-3]), colorbar
   title(int2str(kk))
   pause(.2)
end

[MM,kk] = max(maximos(:,1));
plot(maximos(:,1))
% valor maximo de divergencia en kk=57 es MM=0.003
ss = Div(:,:,kk);
[M,I] = max(ss(:));
[irow,icol]=ind2sub(size(ss),I);
disp(MM)
%ss(irow,icol)  0.0030;
pcolor(XLONG,XLAT,ss),shading flat, colorbar
XLONG(irow,1)
XLAT(1,icol)
% se localiza en long -97.0947, lat 19.4680
year = Tiempo(1,1:4);
mes = Tiempo(1,6:7);
dia = Tiempo(kk,9:10);
hora = Tiempo(kk,12:13);
mins = Tiempo(kk,15:16);
% 10/08/2012 a las 8:00 GMT