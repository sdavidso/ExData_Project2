url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("PM.zip"))
    download.file(url,"PM.zip")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")) #don't reload twice!
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

#5

motorSCC <- grepl("Mobile",SCC$EI.Sector,ignore.case=TRUE)
motorSCC <- SCC[motorSCC,"SCC"]
NEIbm <- NEIb[NEIb$SCC %in% motorSCC,]
q1vbm <- rowsum(NEIbm$Emissions,NEIbm$year)
plot(row.names(q1vbm),q1vbm,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Emissions from motor vehicle sources in Baltimore City")
dev.copy(png,file = "plot5.png",width=960)
dev.off()