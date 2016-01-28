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

install.packages("maps")

library(maps)
map("world", fill = TRUE, col = rainbow(200),
    ylim = c(-60, 90), mar = c(0, 0, 0, 0))
title("世界地图")

library(maps)
map("state", fill = TRUE, col = rainbow(209),
    mar = c(0, 0, 2, 0))
title("美国地图")

library(maps)
map('state', region = c('new york', 'new jersey', 'penn'),
    fill = TRUE, col = rainbow(3), mar = c(2, 3, 4, 3))
title("美国三州地图")
install.packages("mapdata")

library(maps)
library(mapdata)
map("china", col = "red4", ylim = c(18, 54), panel.first = grid())
title(" 中国地图")

install.packages("ggmap")
