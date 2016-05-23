countyYearList=read.table("D://EXP_data//Cornflo//obs_reel//obs_reel_720//countyYearNameList_720.txt",sep="_")
frequency=as.data.frame(table(countyYearList[,1]))
colnames(frequency)=c("region","value")
frequency[,1]=as.numeric(levels(frequency[,1]))[frequency[,1]]

frequency[,2]= as.numeric(frequency[,2])

#install.packages("choroplethrMaps")
#install.packages("choroplethr")
library("choroplethr")
library("choroplethrMaps")
county_choropleth(frequency)
data(df_pop_county)
head(df_pop_county) 
county_choropleth(df_pop_county)
