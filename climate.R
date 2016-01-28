### R Beginners – Plotting Locations on to a World Map
### the packages needed are: maps, ggplot2, ggmap, and maptools
### http://stackoverflow.com/questions/11201997/world-map-with-ggmap/13222504#13222504

library(maps)
library(plyr)
library(ggplot2)
library(sp)
library(ggmap)

# Get some points to plot - CRAN Mirrors
# 获取一些网点的地址信息
Mirrors = getCRANmirrors(all = FALSE, local.only = FALSE)
Mirrors$Place = paste(Mirrors$City, ", ", Mirrors$Country, sep = "")
# Be patient，下面是获取各个城市的经纬度
tmp = geocode(Mirrors$Place)
Mirrors = cbind(Mirrors, tmp)

###################################################################################################
# Recentre worldmap (and Mirrors coordinates) on longitude 160
### Code by Claudia Engel  March 19, 2012, www.stanford.edu/~cengel/blog

### Recenter ####
center <- 160 # positive values only

# shift coordinates to recenter CRAN Mirrors
Mirrors$long.recenter <- ifelse(Mirrors$lon < center - 180 , Mirrors$lon + 360, Mirrors$lon)

# shift coordinates to recenter worldmap
worldmap <- map_data ("world")
worldmap$long.recenter <- ifelse(worldmap$long < center - 180 , worldmap$long + 360, worldmap$long)

### Function to regroup split lines and polygons
# Takes dataframe, column with long and unique group variable, returns df with added column named group.regroup
RegroupElements <- function(df, longcol, idcol){
  g <- rep(1, length(df[,longcol]))
  if (diff(range(df[,longcol])) > 300) { # check if longitude within group differs more than 300 deg, ie if element was split
    d <- df[,longcol] > mean(range(df[,longcol])) # we use the mean to help us separate the extreme values
    g[!d] <- 1 # some marker for parts that stay in place (we cheat here a little, as we do not take into account concave polygons)
    g[d] <- 2 # parts that are moved
  }
  g <- paste(df[, idcol], g, sep=".") # attach to id to create unique group variable for the dataset
  df$group.regroup <- g
  df
}

### Function to close regrouped polygons
# Takes dataframe, checks if 1st and last longitude value are the same, if not, inserts first as last and reassigns order variable
ClosePolygons <- function(df, longcol, ordercol){
  if (df[1,longcol] != df[nrow(df),longcol]) {
    tmp <- df[1,]
    df <- rbind(df,tmp)
  }
  o <- c(1: nrow(df)) # rassign the order variable
  df[,ordercol] <- o
  df
}

# now regroup
worldmap.rg <- ddply(worldmap, .(group), RegroupElements, "long.recenter", "group")

# close polys
worldmap.cp <- ddply(worldmap.rg, .(group.regroup), ClosePolygons, "long.recenter", "order") # use the new grouping var
#############################################################################

# Plot worldmap using data from worldmap.cp
windows(9.2, 4)
worldmap = ggplot(aes(x = long.recenter, y = lat), data = worldmap.cp) + 
  geom_polygon(aes(group = group.regroup), fill="#f9f9f9", colour = "grey65") + 
  scale_y_continuous(limits = c(-60, 85)) + 
  coord_equal() +  theme_bw() + 
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        #axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(), 
        panel.border = element_rect(colour = "black"))

# Plot the CRAN Mirrors
worldmap = worldmap + geom_point(data = Mirrors, aes(long.recenter, lat),
                                 colour = "red", pch = 19, size = 3, alpha = .4)

### 其实还需要画到这里就行了
# Colour New Zealand
# Take care of variable names in worldmap.cp
head(worldmap.cp)
worldmap + geom_polygon(data = subset(worldmap.cp, region == "New Zealand", select = c(long.recenter, lat, group.regroup)), 
                        aes(x = long.recenter, y = lat, group = group.regroup), fill = "blue")

### 这个案例算一个成功的世界地图的画法

library(ggmap)
library(maptools)
library(maps)


visited <- c("SFO", "Chennai", "London", "Melbourne", "Johannesbury, SA")
ll.visited <- geocode(visited)
visit.x <- ll.visited$lon
visit.y <- ll.visited$lat

map("world", fill=TRUE, col="white", bg="lightblue", ylim=c(-60, 90), mar=c(0,0,0,0))
points(visit.x,visit.y, col="red", pch=16)


map2016.x=map2016$lon
map2016.y=map2016$lat

map("world", fill=TRUE, col="white", bg="lightblue",ylim=c(-60, 90), mar=c(0,0,0,0))
points(map2016.x,map2016.y, col="red", pch=16)




mp <- NULL
mapWorld <- borders("world", colour="gray50", fill="gray50") 
# create a layer of borders
mp <- ggplot() +   mapWorld

#Now Layer the cities on top
mp <- mp+ geom_point(aes(x=visit.x, y=visit.y) ,color="blue", size=3) 
mp

mp <- NULL
mapWorld <- borders("world", colour="gray50", fill="gray50") 
# create a layer of borders
mp <- ggplot() +   mapWorld

#Now Layer the cities on top
mp <- mp+ geom_point(aes(x=map2016.x, y=map2016.y) ,color="blue", size=3) 
mp






# install.packages("maps")

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
#install.packages("mapdata")

library(maps)
library(mapdata)
map("china", col = "red4", ylim = c(18, 54), panel.first = grid())
title(" 中国地图")

#install.packages("ggmap")

library(ggmap)
library(mapproj)
## Google啊Google给我China的地图数据吧
map <- get_map(location = 'China', zoom = 4)
ggmap(map)

map <- get_map(location = 'Beijing', zoom = 10, maptype = 'roadmap')
ggmap(map)

map <- get_map(location = 'chatenay malabry', zoom = 14, maptype = 'roadmap')
ggmap(map)



