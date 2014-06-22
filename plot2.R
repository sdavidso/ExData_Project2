url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("PM.zip"))
    download.file(url,"PM.zip")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")) #don't reload twice!
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

#2
NEIb <- NEI[NEI$fips == "24510",]
q1vb <- rowsum(NEIb$Emissions,NEIb$year)
plot(row.names(q1vb),q1vb,type="b",col="red",ylab=expression('Total PM'[2.5]*'Emissions (tons)'),xlab="Year",
     main="Total emissions in Baltimore City")
dev.copy(png,file = "plot2.png")
dev.off()