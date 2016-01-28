### plot station

library(ggmap)
library(maptools)
library(maps)
setwd("D://R_3_0/digiplante/climates/")
years=2000:2016
for (i in years){
  filename=paste("D://Dropbox//These//temperature//TMAX_",i,".csv",sep="")
  mapinfo=read.table(filename,sep = ",",header = T)
  mapinfo.x=mapinfo$LONGITUDE;
  mapinfo.y=mapinfo$LATITUDE;
  png(paste("TMAX_station_",i,".png",sep=""))
  map("world", fill=TRUE, col="white", bg="lightblue",ylim=c(-60, 90), mar=c(0,0,0,0))
  points(mapinfo.x,mapinfo.y, col="red", pch=16);
  title(paste("TMAX_station_",i,sep=""));
  dev.off()
}




library(ggmap)
library(maptools)
library(maps)
setwd("D://R_3_0/digiplante/climates/plots")
years=2004:2016
for (i in years){
  i=2015
  filename=paste("D://Dropbox//These//temperature//TMAX_",i,".csv",sep="")
  mapinfo=read.table(filename,sep = ",",header = T)
  mapinfo.x=mapinfo$LONGITUDE;
  mapinfo.y=mapinfo$LATITUDE;
  mp <- NULL
  mapWorld <- borders("world", colour="gray50", fill="gray50") 
  # create a layer of borders
  mp <- ggplot() +   mapWorld
  
  
  #Now Layer the cities on top
  mp <- mp+ geom_point(aes(x=mapinfo.x, y=mapinfo.y) ,color="blue", size=3) 
  png(paste("TMAX_station_",i,".png",sep=""))
  mp
  dev.off()
}

### plot station

library(ggmap)
library(maptools)
library(maps)
#dir.create("D://R_3_0/digiplante/climates/TMIN")
setwd("D://R_3_0/digiplante/climates/TMIN/")
years=2000:2016
for (i in years){
  filename=paste("D://Dropbox//These//temperature//TMIN//TMIN_",i,".csv",sep="")
  mapinfo=read.table(filename,sep = ",",header = T)
  mapinfo.x=mapinfo$LONGITUDE;
  mapinfo.y=mapinfo$LATITUDE;
  png(paste("TMIN_station_",i,".png",sep=""))
  map("world", fill=TRUE, col="white", bg="lightblue",ylim=c(-60, 90), mar=c(0,0,0,0))
  points(mapinfo.x,mapinfo.y, col="red", pch=16);
  title(paste("TMIN_station_",i,sep=""));
  dev.off()
}

library(ggmap)
library(maptools)
library(maps)
setwd("D://R_3_0/digiplante/climates/TMIN/")
years=2000:2016
for (i in years){
  i=2016
  filename=paste("D://Dropbox//These//temperature//TMIN/TMIN_",i,".csv",sep="")
  mapinfo=read.table(filename,sep = ",",header = T)
  mapinfo.x=mapinfo$LONGITUDE;
  mapinfo.y=mapinfo$LATITUDE;
  mp <- NULL
  mapWorld <- borders("world", colour="gray50", fill="gray50") 
  # create a layer of borders
  mp <- ggplot() +   mapWorld
  
  
  #Now Layer the cities on top
  mp <- mp+ geom_point(aes(x=mapinfo.x, y=mapinfo.y) ,color="blue", size=3) 
  png(paste("TMIN_station_",i,".png",sep=""))
  mp
  dev.off()
}

