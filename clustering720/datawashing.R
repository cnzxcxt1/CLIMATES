#### use the clustering technique with 720 scenarios
filename=read.table("C://EXP_data//obs_reel_720/countyYearNameList_720.txt")
fullname=paste(filename[,1],".txt",sep="")
nbr_variable=5
variables=c("TMIN","TMAX","RG","P","ET")
save_name=c("TMIN.csv","TMAX.csv","RG.csv","P.csv","ET.csv")


for (j in 1:nbr_variable) {
  setwd('C://Xiangtuo//CORNFLO??????//Environment//env_list')
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

