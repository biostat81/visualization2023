### Program 7-1
setwd("C:\\Users\\KNOU_stat\\Dropbox\\KNOU_강의개편\\데이터시각화\\R_geospatial")
library(stars)
library(ggplot2)
HARV_elev<-read_stars("HARV_dsmCrop.tif")
class(HARV_elev)
HARV_elev

### Program 7-2
st_crs(HARV_elev)

### Program 7-3
ggplot() + geom_stars(data=HARV_elev)
ggplot() + geom_stars(data=HARV_elev, aes(x=x, y=y, fill=HARV_dsmCrop.tif))
ggplot() + geom_stars(data=HARV_elev) + scale_fill_viridis_c() + coord_equal()

### Program 7-4
library(dplyr)
HARV_elev2<-HARV_elev %>% 
  mutate(elev.group=cut(HARV_dsmCrop.tif, breaks=c(300, 350, 400, 450)))
ggplot() + geom_stars(data=HARV_elev2, aes(x=x, y=y, fill=elev.group)) +
  labs(fill="Elevation group") + coord_quickmap()


### Program 7-5
HARV_hill<-read_stars("HARV_DSMhill.tif")
HARV_hill
st_crs(HARV_hill)
ggplot() + geom_stars(data=HARV_hill) + coord_quickmap()

### Program 7-6
st_crs(HARV_elev)==st_crs(HARV_hill)
ggplot() + geom_stars(data=HARV_elev) + 
  geom_stars(data=HARV_hill, aes(x=x, y=y, alpha=HARV_DSMhill.tif)) +
  scale_fill_viridis_c() +  
  scale_alpha(range = c(0.15, 0.5), guide = "none") +
  coord_quickmap()

### Program 7-7
HARV_DTM_elev<-read_stars("HARV_dtmCrop.tif")
HARV_DTM_hill<-read_stars("HARV_DTMhill_WGS84.tif")
st_crs(HARV_DTM_elev)==st_crs(HARV_DTM_hill)

### Program 7-8
HARV_DTM_hill.2<-st_warp(HARV_DTM_hill, HARV_DTM_elev)
st_crs(HARV_DTM_elev)==st_crs(HARV_DTM_hill.2)
ggplot() + geom_stars(data=HARV_DTM_elev) + 
  geom_stars(data=HARV_DTM_hill.2, aes(x=x, y=y, alpha=HARV_DTMhill_WGS84.tif)) +
  scale_fill_viridis_c() +  
  scale_alpha(range = c(0.15, 0.6), guide = "none") +
  coord_quickmap()


### Program 7-9
NE<-read_stars("NE1_50M_SR_W.tif")
NE

### Program 7-10
ggplot() + geom_stars(data=NE, downsample = 10) + 
  coord_quickmap() 

### Program 7-11
ggplot() + geom_stars(data=NE, downsample = 10) + 
  coord_quickmap(xlim=c(100, 150), ylim=c(25, 50))

### Program 7-12
NE.cropped<-st_crop(NE, st_bbox(c(xmin=100, xmax=150, ymin=25, ymax=50), crs=st_crs(NE)))
ggplot() + geom_stars(data=NE.cropped) +
  coord_quickmap()


### Program 7-13
library(terra)
t.NE<-rast("NE1_50M_SR_W.tif")
t.NE

### Program 7-14
plotRGB(t.NE)
plotRGB(t.NE, axes=T, mar=4)

### Program 7-15
t.NE.cropped<-crop(t.NE, ext(100, 150, 25, 50))
plotRGB(t.NE.cropped)

### Program 7-16
library(sf)
NE.countries<-read_sf("ne_110m_admin_0_countries.shp")
NE.countries
st_crs(NE.countries)

### Program 7-17
ggplot() + geom_sf(data=NE.countries)

### Program 7-18
ggplot() + geom_sf(data=NE.countries) + coord_sf(expand = FALSE)
ggplot() + geom_sf(data=NE.countries) + coord_sf(xlim=c(100, 150), ylim=c(30, 55))  
ggplot() + geom_sf(data=NE.countries) + coord_sf(crs=st_crs(2163))

### Program 7-19
table(NE.countries$INCOME_GRP)
ggplot() + geom_sf(data=NE.countries, aes(fill=INCOME_GRP))
ggplot() + geom_sf(data=NE.countries, aes(color=INCOME_GRP))

### Program 7-20
NE.countries2<-NE.countries %>% mutate(POP_GRP=as.factor(ifelse(POP_EST>=10^7, 1, 0)))
ggplot() + geom_sf(data=NE.countries2, aes(fill=POP_GRP))


### Program 7-21
library(geodata)
gadm.kor<-gadm(country='KOR', level=1, path=getwd())
gadm.kor.sf<-st_as_sf(gadm.kor)
ggplot() + geom_sf(data=gadm.kor.sf)

### Program 7-22
table(gadm.kor.sf$NAME_1)
gadm.kor.sf2<-gadm.kor.sf %>% 
  filter(NAME_1=="Seoul" | NAME_1=="Gyeonggi-do" | NAME_1=="Incheon")
ggplot() + geom_sf(data=gadm.kor.sf2, aes(fill=NAME_1)) 
ggplot(data=gadm.kor.sf2) + geom_sf() + geom_sf_label(aes(label=NAME_1))


### Program 7-23
osm.kor<-osm(country='KOR', var="railway", path=getwd())
osm.kor.sf<-st_as_sf(osm.kor)
ggplot() + geom_sf(data=osm.kor.sf, color="red")

### Program 7-24
ggplot() + geom_sf(data=gadm.kor.sf)+ geom_sf(data=osm.kor.sf, color="red")


### Program 7-25
seoul.env<-read_stars("eco_25k_376084_세계측지계.tif")
ggplot() + 
  geom_stars(data=seoul.env) +
  guides(fill=guide_legend(title="grade")) +
  scale_fill_viridis_d() +
  coord_equal()


### Program 7-26
kor.level3<-gadm(country='KOR', level=3, path=getwd())
kor.level3.sf<-st_as_sf(kor.level3)
st_crs(kor.level3.sf)==st_crs(seoul.env)

### Program 7-27
kor.level3.sf2<-st_transform(kor.level3.sf, crs=st_crs(seoul.env))
kor.level3.sf3<-st_crop(kor.level3.sf2, seoul.env)
ggplot() + 
  geom_stars(data=seoul.env) +
  guides(fill=guide_legend(title="grade")) +
  scale_fill_viridis_d() +
  geom_sf(data=kor.level3.sf3, fill=NA) + 
  coord_sf() 


