url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("PM.zip"))
    download.file(url,"PM.zip")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")) #don't reload twice!
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

#1
q1v <- rowsum(NEI$Emissions,NEI$year)
plot(row.names(q1v),q1v,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Total emissions in the United States")
dev.copy(png,file = "plot1.png")
dev.off()

#2
NEIb <- NEI[NEI$fips == "24510",]
q1vb <- rowsum(NEIb$Emissions,NEIb$year)
plot(row.names(q1vb),q1vb,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Total emissions in Baltimore City")
dev.copy(png,file = "plot2.png")
dev.off()

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

#4

coalSCC <- grepl("Coal",SCC$Short.Name, ignore.case=TRUE)
coalSCC <- SCC[coalSCC,"SCC"]
NEIcoal <- NEI[NEI$SCC %in% coalSCC,]
q1vc <- rowsum(NEIcoal$Emissions,NEIcoal$year)
plot(row.names(q1vc),q1vc,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Total emissions from coal combustion-related sources")

dev.copy(png,file = "plot4.png",width=960)
dev.off()

#5

motorSCC <- grepl("Mobile",SCC$EI.Sector,ignore.case=TRUE)
motorSCC <- SCC[motorSCC,"SCC"]
NEIbm <- NEIb[NEIb$SCC %in% motorSCC,]
q1vbm <- rowsum(NEIbm$Emissions,NEIbm$year)
plot(row.names(q1vbm),q1vbm,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Emissions from motor vehicle sources in Baltimore City")
dev.copy(png,file = "plot5.png",width=960)
dev.off()

#6


motorSCC <- grepl("Mobile",SCC$EI.Sector,ignore.case=TRUE)
motorSCC <- SCC[motorSCC,"SCC"]
NEIbm <- NEIb[NEIb$SCC %in% motorSCC,]
q1vbm <- rowsum(NEIbm$Emissions,NEIbm$year)
plot(row.names(q1vbm),q1vbm,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Emissions from motor vehicle sources in Baltimore City")


NEILA <- NEI[NEI$fips=="06037",]
NEILAm <- NEILA[NEILA$SCC %in% motorSCC,]
q1vLAm <- rowsum(NEILAm$Emissions, NEILAm$year)


png(file="plot6.png",width=960)
par(mfrow=c(1,2))
plot(row.names(q1vbm),q1vbm,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Emissions from motor vehicle sources in Baltimore City")

plot(row.names(q1vLAm),q1vLAm,type="b",col="blue",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Emissions from motor vehicle sources in Los Angeles")

dev.off()