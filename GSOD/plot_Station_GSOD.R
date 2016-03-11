Sta_Info=read.table("D://download/GSOD/isd-history.csv",header = T,sep=",")
Sta_Info[,1]=formatC(Sta_Info[,1],width = 6,flag = 0)
Station_name=paste(Sta_Info[,1],Sta_Info[,2],sep="-")
temp1=cbind(Station_name,Sta_Info[,7:8])
Station_exit=read.table("D://download/GSOD/commonlist.csv",header = T)
#Station_exit=as.character(Station_exit)
nbr_station=nrow(Station_exit)
Index=rep(0,nbr_station)
for (i in 1:nbr_station) {
  temp2=which(temp1[,1]==as.character(Station_exit[i,1]))
  if (length(temp2)>0) {
    Index[i]=temp2
  }
  else
  Index[i]=NA
}
Index=Index[complete.cases(Index)]
temp3=temp1[Index,]
Infor_complete=temp3[complete.cases(temp3),]


### plot station

library(ggmap)
library(maptools)
library(maps)
setwd("D://download/GSOD/")
mapinfo.x=Infor_complete$LON;
mapinfo.y=Infor_complete$LAT;
png("Stationlist.png")
map("world", fill=TRUE, col="white", bg="lightblue",ylim=c(-60, 90), mar=c(0,0,0,0))
points(mapinfo.x,mapinfo.y, col="red", pch=16);
title("Stationlist");
dev.off()




mp <- NULL
mapWorld <- borders("world", colour="gray50", fill="gray50") 
# create a layer of borders
mp <- ggplot() +   mapWorld


#Now Layer the cities on top
mp <- mp+ geom_point(aes(x=mapinfo.x, y=mapinfo.y) ,color="blue", size=3) 
png("Station_list.png")
mp
dev.off()

