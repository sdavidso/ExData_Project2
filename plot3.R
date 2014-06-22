url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("PM.zip"))
    download.file(url,"PM.zip")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")) #don't reload twice!
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

#3

NEIb <- NEI[NEI$fips == "24510",]

library(ggplot2)
library(reshape2)

NEIbmelt <- NEIb[,c("year","type","Emissions")]
NEIbmelt <- melt(NEIbmelt,id=c("year","type"))
NEIbmelt <- dcast(NEIbmelt, year + type ~ variable,sum)
#png(file="plot3.png",width=960)
plot3 <- qplot(year,Emissions,data=NEIbmelt,facets=.~type,geom=c("smooth","point"),method="lm")
print(plot3)
dev.copy(png,file="plot3.png",width=960)
dev.off()