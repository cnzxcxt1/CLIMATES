
Stationlist=read.table("D://download//GSOD/commonlist.csv",header=T)
nbr_Station=nrow(Stationlist)
year=2010:2016
nbr_years=length(year)
var=c("TEMP","TMAX","TMIN","PRCP")
for (i  in 1:nbr_years) {
  path=paste("D://download/GSOD/gsod_",year[i],sep="");
  setwd(path);
  for (j in 1:4) {
    Index_file1=paste(Stationlist[1,1],"-",year[i],".csv",sep="")
    temp1=read.table(Index_file1,sep=",",header=T)
    temp1=temp1[,c(1,j+1)]
    colnames(temp1)[2]= as.character(Stationlist[1,1])
    temp1$Date=as.Date(temp1$Date)
    for (k  in 2:nbr_Station) {
      Index_file2=paste(Stationlist[k,1],"-",year[i],".csv",sep="")
      temp2=read.table(Index_file2,sep=",",header=T)
      temp2=temp2[,c(1,j+1)]
      colnames(temp2)[2]= as.character(Stationlist[k,1])
      temp2$Date=as.Date(temp2$Date)
      #temp2[(temp2[,2]>5000 | temp2[,2]< -5000)&!is.na(temp2[,2]),2]=NA
      temp1=merge(x=temp1,y=temp2,by = "Date",all=TRUE)
      #temp1[complete.cases(temp1),]
    }
    write.csv(temp1,paste(var[j],"-",year[i],".csv",sep=""),row.names = F); 
  }
}