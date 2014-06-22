url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("PM.zip"))
    download.file(url,"PM.zip")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")) #don't reload twice!
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

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