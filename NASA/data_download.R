library(utils)
lat=-90:90
lon=-180:180
years=2000:2016
lat_length=length(lat)
lon_length=length(lon)
years_length=length(years)
for(i in 1:years_length){
  i=1
  path=paste("D://R_3_0//NASA//",years[i],sep="")
  dir.create(path)
  setwd(path)
  for (j in 1:180) {
    for (k in 1:360) {
      http_address=paste("http://power.larc.nasa.gov/cgi-bin/agro.cgi?email=&step=1&lat=",lat[j],"&lon=",lon[k],"&ms=1&ds=1&ys=",years[i],"&me=12&de=31&ye=",years[i],"&submit=Yes&p=T2MX",sep="")
      filename=paste(years[i],"_",lat[j],"_",lon[k],".txt",sep="")
      download.file(http_address, filename, method="libcurl")
    }
  }
}





