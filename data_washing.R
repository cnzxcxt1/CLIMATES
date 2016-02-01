dir.create("D://R_3_0//digiplante//climates")
setwd("D://R_3_0//digiplante//climates")
table=read.table("D://EXP_data///Temperature/ghcnd-inventory.txt")
colnames(table)=c("ID","LATITUDE","LONGITUDE","ELEMENT","FIRSTYEAR","LASTYEAR")
elements=as.character(unique(table[4])[,1])
nbr_element=length(elements)
for (i in 1:nbr_element){
  temp=table[table[4]==elements[i],]
  write.csv(temp,paste(elements[i],"_",nrow(temp),".csv",sep="")); 
}
getwd()




firsts=c(1,12,18,22,30,38,46,54,62,70,78,86,94,102,110,118,126,134,142,150,158,166,174,182,190,198,206,214,222,230,238,246,254,262)
lasts=c(11,17,21,28,36,44,52,60,68,76,84,92,100,108,116,124,132,140,148,156,164,172,180,188,196,204,212,220,228,236,244,252,260,268)
Stations=c("USW00023170","USW00014804","USW00013782")
filename=paste("D://R_3_0//digiplante//climates//datas//",Stations[2],".dly",sep="")
file<-file(filename,"r")
line=readLines(file,n=1)
table= as.data.frame(matrix(0,nrow=1,ncol = 34))
for (i in 1:34) {
  table[1,i]=substr(line, firsts[i], lasts[i])
}
while( length(line) != 0 ) {
  line= readLines(file,n=1)
  temp= as.data.frame(matrix(0,nrow=1,ncol = 34))
  for (i in 1:34) {
    temp[1,i]=substr(line, firsts[i], lasts[i])
  }
  table=rbind(table,temp)
}
close(file)

