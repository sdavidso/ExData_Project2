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
