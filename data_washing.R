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
