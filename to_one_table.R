#for (k in 2004:2014) {
  year=2010
  VAR=c("TMAX","PRCP","TMIN")
  Station_file=paste("D://R_3_0//digiplante//climates//datas//Station_exist_",year,".csv",sep="")
  Stations_exist=read.table(Station_file,sep=",",header=T)
  Station_number=nrow(Stations_exist)
  for (j in 1:3) {
    Index=VAR[j]
    Index_file1=paste("D://R_3_0//digiplante//climates//datas//COMMON-",year,"//tables//",Index,"//",Index,"_",Stations_exist[1,1],".csv",sep="")
    temp1=read.table(Index_file1,sep=",",header=T)
    colnames(temp1)[2]= as.character(Stations_exist[1,1])
    temp1$Time=as.Date(temp1$Time)
    temp1[(temp1[,2]>5000 | temp1[,2]< -5000)&!is.na(temp1[,2]),2]=NA
    for (i  in 2:Station_number) {
      Index_file2=paste("D://R_3_0//digiplante//climates//datas//COMMON-",year,"//tables//",Index,"//",Index,"_",Stations_exist[i,1],".csv",sep="")
      temp2=read.table(Index_file2,sep=",",header=T)
      colnames(temp2)[2]= as.character(Stations_exist[i,1])
      temp2$Time=as.Date(temp2$Time)
      temp2[(temp2[,2]>5000 | temp2[,2]< -5000)&!is.na(temp2[,2]),2]=NA
      temp1=merge(x=temp1,y=temp2,by = "Time",all=TRUE)
      #temp1[complete.cases(temp1),]
    }
    write.csv(temp1,paste(Index,"_",year,".csv",sep=""),row.names = F); 
    
  }
#}


