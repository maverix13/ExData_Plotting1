plot1 <- function() {
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
    relevantData[relevantData$Global_active_power == "?"] = NA
    relevantData <- relevantData[, Global_active_power:=as.numeric(Global_active_power)]
    
    hist(relevantData$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
    
    dev.copy(png, file = "plot1.png")
    dev.off()
}