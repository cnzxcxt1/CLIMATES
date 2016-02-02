###data reshape
#ptm <- proc.time()
### 35 breakpoints
setwd("D://R_3_0/digiplante/climates/datas/")
Information=read.table("D://Dropbox//These//temperature//TCOMMON//each_year//CSV//TCOMMON_2015.csv",sep = ",",header = T)
Station_potentiel=Information$ID
Filenames=paste(Station_potentiel,".dly",sep="")
file.exists(Filenames)
nbr_stations=sum(file.exists(Filenames))
Stations=Station_potentiel[file.exists(Filenames)]
write.csv(Stations,file=paste("Station_exist_2015.csv",sep=""),quote=T,row.names=F)
firsts=c(1,12,16,18,22,30,38,46,54,62,70,78,86,94,102,110,118,126,134,142,150,158,166,174,182,190,198,206,214,222,230,238,246,254,262)
lasts=c(11,15,17,21,26,34,42,50,58,66,74,82,90,98,106,114,122,130,138,146,154,162,170,178,186,194,202,210,218,226,234,242,250,258,266)
#Stations=c("USW00023170","USW00014804","USW00013782")
for (i in 53:nbr_stations) {
  filename=paste("D://R_3_0//digiplante//climates//datas//",Stations[i],".dly",sep="")
  data=read.table(filename,sep = "\n")
  nbr_obser=nrow(data)
  table= as.data.frame(matrix(0,nrow=nbr_obser,ncol = 35))
  for (j in 1:nbr_obser) {
    for (k in 1:35) {
      table[j,k]=substr(data[j,], firsts[k], lasts[k])
    }
  } 
  ### the 4 item to be taken into consideration
  ### TMAX,TMIN,TOBS,PRCP
  ITEMS=c("TMAX","TMIN","PRCP")
  for (m in 1:3) {
    element=ITEMS[m]
    subtable=table[table[,4]==element,][,-c(1,4)];
    colnames(subtable)=c("year","month","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31")
    nbr_sub_obser=nrow(subtable);
    temp1=t(subtable[,3:33])
    values=as.numeric(matrix(temp1,ncol = 1))
    dates=c()
    for (l in 1:nbr_sub_obser) {
      temp2=paste(subtable$year[l],"-",subtable$month[l],"-",colnames(subtable)[3:33],sep="")
      dates=c(dates,temp2)
    }
    Dates=as.Date(dates)
    index=!is.na(Dates)  
    time=as.data.frame(Dates[index])
    values=as.data.frame(values[index])
    TS=cbind(time,values)
    colnames(TS)=c("Time",element)
    write.csv(TS,file=paste(element,"_",Stations[i],".csv",sep=""),quote=T,row.names=F)
    png(paste(element,"_",Stations[i],".png",sep=""))
    plot(TS[,1],TS[,2],xlab = "time",ylab = element)
    dev.off()
  }
}