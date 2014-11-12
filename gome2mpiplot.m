%% Reads GOME-2 data globally, plot, and compare with MPI LE and H
%  Xi Yang: geoxiyang@gmail.com
%  Oct. 30, 2014 (Happy Halloween!)

%% Reads GOME-2 data




%% Read MPI LE data
LE_file = '/Volumes/XiYangResearch/Data/3.MPI-Jena/1.LatentHeat/2014102921164842_EnsembleLEcor_May12.nc';
LE_id   = netcdf.open(LE_file,'NOWRITE');

varLE   = netcdf.inqVarID(LE_id,'EnsembleLEcor_May12');
vartime = netcdf.inqVarID(LE_id,'time');
varlon  = netcdf.inqVarID(LE_id,'longitude');
varlat  = netcdf.inqVarID(LE_id,'latitude');
varstd  = netcdf.inqVarID(LE_id,'std');

LE      = netcdf.getVar(LE_id,varLE);
time    = netcdf.getVar(LE_id,vartime);
lon     = netcdf.getVar(LE_id,varlon);
lat     = netcdf.getVar(LE_id,varlat);
std     = netcdf.getVar(LE_id,varstd);

% Test plot
% LE1 = LE(:,:,1)';
% LE1(LE1 < 0) = NaN;
% axesm('eqdcylin')
% pcolorm(lat,lon,LE1)
% colorbar

%% Read MPI H data

H_file  = '/Volumes/XiYangResearch/Data/3.MPI-Jena/2.SensibleHeat/20141029211832EnsembleHcor_May12.1982.2011.nc';
H_id    = netcdf.open(H_file,'NOWRITE');


varH    = netcdf.inqVarID(H_id,'EnsembleHcor_May12');
varHtime= netcdf.inqVarID(H_id,'time');
varHlon = netcdf.inqVarID(H_id,'longitude');
varHlat = netcdf.inqVarID(H_id,'latitude');
varHstd = netcdf.inqVarID(H_id,'std');

H       = netcdf.getVar(H_id,varH);
Htime   = netcdf.getVar(H_id,varHtime);
Hlon    = netcdf.getVar(H_id,varHlon);
Hlat    = netcdf.getVar(H_id,varHlat);
Hstd    = netcdf.getVar(H_id,varHstd);

% Test plot 2
% H1 = H(:,:,1)';
% H1(H1 < 0) = NaN;
% axesm('eqdcylin')
% pcolorm(Hlat,Hlon,H1)
% colorbar

BOWEN1 = H(:,:,1)'./LE(:,:,1)';
BOWEN1(BOWEN1 < 0 | BOWEN1>20) = NaN;
axesm('eqdcylin')
pcolorm(lat,lon,BOWEN1)
colorbar


