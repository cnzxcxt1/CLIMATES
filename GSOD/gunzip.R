
year=2005:2009
nbr_years=length(year)
Stations=list()

## read the station list for each year
for (i in 1:nbr_years) {
  path=paste("D://download//GSOD//gsod_",year[i],sep="")
  setwd(path)
  filelist=dir()
  station_list=substr(filelist,1,12)
  Stations[[i]]=station_list
}

## find out the common stations
for (j in 2:nbr_years) {
  list1=Stations[[j-1]];
  list2=Stations[[j]];
  commonlist=intersect(list1,list2);
  Stations[[j]]=commonlist
}
finallist=Stations[[nbr_years]]
nbrstations=length(finallist)
write.csv(finallist,file="D://download//GSOD//commonlist.csv",quote=T,row.names=F)
### so I have 9435 Stations for 2010-2016 years

#install.packages("R.utils")
library(R.utils)

## gunzip the record of common station 
for (k in 1:nbr_years) {
  path=paste("D://download//GSOD//gsod_",year[k],sep="")
  setwd(path)
  for (l in 1:nbrstations) {
  gunzip(paste(finallist[l],"-",year[k],".op.gz",sep=""))  
  }
}

#ptm <- proc.time()
### this program takes more time
nbr_para=7
firsts=c(15,19,21,25,103,111,119)
lasts=c(18,20,22,30,108,116,123)
name_para=c("Date","TEMP","TMAX","TMIN","PRCP")
for (i in 1:nbr_years) {
  path=paste("D://download//GSOD//gsod_",year[i],sep="")
  setwd(path)
  for (j in 1:nbrstations) {
    filename=paste(finallist[j],"-",year[i],".op",sep="")
    data=read.table(filename,sep="\n",header=T)
    nbr_record=nrow(data)
    table=matrix(0,nrow=nbr_record,ncol = nbr_para)
    for (k in 1:nbr_para) {
      for (l in 1:nbr_record) {
        table[l,k]=substr(data[l,],firsts[k],lasts[k])
      }
    }
    table=as.data.frame(table)
    table[,1]=paste(table[,1],table[,2],table[,3],sep="-")
    table=table[,-c(2,3)]
    table[,1]=as.Date(table[,1])
    colnames(table)=name_para
    #plot(table[,1],table[,2])  
    write.csv(table,file=paste(finallist[j],"-",year[i],".csv",sep=""),quote=T,row.names=F)
  }
}



#proc.time() - ptm


