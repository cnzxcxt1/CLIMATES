### common database

temp1=read.table("D://Dropbox//These//temperature//TMAX//TMAX_34013.csv",sep=",",header=T)
temp2=read.table("D://Dropbox//These//temperature//TMIN//TMIN_33914.csv",sep=",",header=T)

temp1=temp1[,-1]
TMAXstation=temp1[as.vector(temp1[,7]>99)&as.vector(temp1$LASTYEAR>1999),]
temp2=temp2[,-1]
TMINstation=temp2[as.vector(temp2[,7]>99)&as.vector(temp2$LASTYEAR>1999),]
ID_max=TMAXstation$ID;
ID_min=TMINstation$ID;
ID_common=intersect(ID_max,ID_min)
INDEX_max=length(ID_common)
CommonStation=as.data.frame(matrix(0,nrow = INDEX_max,ncol=7))
for (i in 1:INDEX_max){
  indexmax= which(ID_max==ID_common[i])
  TMAXstation[indexmax,]
  indexmin= which(ID_min==ID_common[i]) 
  TMINstation[indexmin,]
  CommonStation[i,1]=ID_common[i]
  CommonStation[i,2:3]=TMAXstation[indexmax,2:3]
  CommonStation[i,4]="Common_T"
  CommonStation[i,5]=max(TMAXstation[indexmax,5],TMINstation[indexmin,5])
  CommonStation[i,6]=min(TMAXstation[indexmax,6],TMINstation[indexmin,6])
  CommonStation[i,7]=CommonStation[i,6]-CommonStation[i,5]
}
colnames(CommonStation)=c("ID","LATITUDE","LONGITUDE","ELEVATION","FIRSTYEAR","LASTYEAR","DURATION")
write.table(CommonStation,file="CommonStation.csv",sep=",",quote=T,row.names=F,col.names = T)
