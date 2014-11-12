load('/Volumes/XiYangResearch/Projects/3.SIF_LEH/gome_monthly.mat');

SIF_mean    = nan(12,720,360);
SIF_anomaly = nan(12,720,360);

% Calculate average
yeartoexclude = [2012,2014];

for ii = 1:12
    sub = ~ismember(timeym(:,1),yeartoexclude) & (timeym(:,2) == ii);
    SIF_mean(ii,:,:) = nanmean(SIF740(sub,:,:),1);
end

% Calculate anomaly
ayear        = 2014;
sub_2        = timeym(:,1) == ayear;
SIF740_ayear = SIF740(sub_2,:,:);
nmonth       = sum(sub_2);

for jj = 1:nmonth
    
    SIF_anomaly(jj,:,:) = SIF740_ayear(jj,:,:) - SIF_mean(jj,:,:);
    
end
lat = double(lat);
lon = double(lon);


SIF_anomaly(5,SIF_anomaly(5,:,:) <= -1 | SIF_anomaly(5,:,:) >= 1 | SIF_mean(5,:,:) == 0) = nan;

axesm('miller','MapLatLimit',[15 55],'MapLonLimit',[-130 -60]);
states = shaperead('usastatelo', 'UseGeoCoords', true);
%worldmap([24 51],[-126 -66]);
geoshow(states,'FaceColor',[1,1,1],'facealpha',.3);
pcolorm(lat,lon,reshape(SIF_anomaly(5,:,:),720,360)');
colorbar
set(gcf,'renderer','opengl')