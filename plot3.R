plot3 <- function() {
    library(lubridate)
    library(data.table)
    if(!file.exists("data"))
        dir.create("data")
    
    if(!file.exists("data/hpc.zip")) {
        setwd("data/")
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, "hpc.zip", method = "curl")
        system(paste("unzip", "hpc.zip"))
        setwd("../")
    }
    
    data <- fread("data/household_power_consumption.txt", sep = ";", header = TRUE)
    data[, DateTime:= dmy_hms(paste(Date, Time))]
    set2keyv(data, "DateTime")
    
    relevantData <- data[DateTime>=ymd_hms("2007-02-01 00:00:00") & DateTime<=ymd_hms("2007-02-02 23:59:00")]
    
    png("plot3.png")
    plot(relevantData$DateTime, relevantData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(relevantData$DateTime, relevantData$Sub_metering_2, col = "red")
    lines(relevantData$DateTime, relevantData$Sub_metering_3, col = "blue")
    legend("topright", legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), col= c("black", "red", "blue"),  lty = c(1,1,1), lwd = 1)

    dev.off()
}