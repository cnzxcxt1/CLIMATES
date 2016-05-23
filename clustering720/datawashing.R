#### use the clustering technique with 720 scenarios
filename=read.table("C://EXP_data//obs_reel_720/countyYearNameList_720.txt")
fullname=paste(filename[,1],".txt",sep="")
nbr_variable=5
variables=c("TMIN","TMAX","RG","P","ET")
save_name=c("TMIN.csv","TMAX.csv","RG.csv","P.csv","ET.csv")


for (j in 1:nbr_variable) {
  setwd('C://Xiangtuo//CORNFLO//Environment//env_list')
  data=matrix(0,ncol = 365,nrow = 720)
  for (i in 1:720) {
    temp=read.table(fullname[i],sep="\n")
    temp1=strsplit(as.character(temp[j+1,1]),"=")
    temp2=strsplit(temp1[[1]][2],"\t")
    temp3=as.numeric(temp2[[1]])
    data[i,]=temp3;
  }
  data=as.data.frame(data)
  setwd("C://R_3_0")
  write.csv(data,file=save_name[j],quote=T,row.names=F)
}


temp1=read.table("C://R_3_0/TMAX.csv",header=T,sep=",")
temp2=read.table("C://R_3_0/TMIN.csv",header=T,sep=",")
temp3=read.table("C://R_3_0/ET.csv",header=T,sep=",")
temp4=read.table("C://R_3_0/RG.csv",header=T,sep=",")
temp5=read.table("C://R_3_0/P.csv",header=T,sep=",")
data1=cbind(temp1,temp2)
data2=cbind(data1,temp3)
data3=cbind(data2,temp4)
data4=cbind(data3,temp5)
datascaled=scale(data4,center=TRUE,scale=TRUE)
write.csv(datascaled,720scaleddata,row.names = F);
write.csv(datascaled,720scaleddata.csv,row.names = F);
write.csv(datascaled,"720scaleddata.csv",row.names = F);