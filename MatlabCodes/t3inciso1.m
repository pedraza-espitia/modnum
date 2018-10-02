% author Pedraza-Espitia S.
% corte meridional
close all
clear all
%Ruta = ['/media/salva/exfat/'];
Ruta = ['/media/sal/exfat/'];
Arch = [Ruta,'wrfout_d02_2012-08-08_00_UVW.nc'];
% atributos, variables y dimensiones
Tiempo = ncread(Arch,'Times')';
Times_l = length(Tiempo);

XLAT = ncread(Arch,'XLAT', [1 1 1], [Inf Inf 1], [1 1 1]);
XLAT = double(XLAT);
XLONG =  ncread(Arch,'XLONG', [1 1 1], [Inf Inf 1], [1 1 1]);
XLONG = double(XLONG);
Niveles = 1:27;
Xlatitud = XLAT(1,:);
[Niveles,Xlatitud] = meshgrid(Niveles,Xlatitud);
figst = [24 29 34 39];
num = 1;
Un94 = ncread(Arch,'U',[200 1 1 1],[1 inf inf Inf], [1 1 1 1]);
Un94 = double(squeeze(Un94));
figure
for tt=1:46
    clf;
    year = Tiempo(1,1:4);
    mes = Tiempo(1,6:7);
    dia = Tiempo(tt,9:10);
    hora = Tiempo(tt,12:13);
    mins = Tiempo(tt,15:16);
    pcolor(Xlatitud,Niveles,Un94(:,:,tt)), shading interp
    ylabel('Altura (Niveles)')
    xlabel('Latitud')
    title(['Corte meridional componente zonal U ',...
        dia,'-',mes,'-',year,' a las ',hora,':',mins,' GMT'])
    caxis([-20 20])
    colorbar
    %title(tt) % codigo para obtener 4 imagenes jpeg:
    if figst(num) == tt
        %fig.PaperUnits='inches';
        nombreimg = ['t3fig',num2str(tt),'.jpeg'];
        print(nombreimg,'-djpeg','-r0')
        if num < 4
            num = num+1;
        else
            continue
        end
    end
    pause(0.2)
end