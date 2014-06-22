url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("PM.zip"))
    download.file(url,"PM.zip")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")) #don't reload twice!
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

#4

coalSCC <- grepl("Coal",SCC$Short.Name, ignore.case=TRUE)
coalSCC <- SCC[coalSCC,"SCC"]
NEIcoal <- NEI[NEI$SCC %in% coalSCC,]
q1vc <- rowsum(NEIcoal$Emissions,NEIcoal$year)
plot(row.names(q1vc),q1vc,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Total emissions from coal combustion-related sources")

dev.copy(png,file = "plot4.png",width=960)
dev.off()
