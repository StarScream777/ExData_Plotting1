# Download the dataset
filename <- "exdata_data_household_power_consumption.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("exdata_data_household_power_consumption")) { 
    unzip(filename) 
}

# Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

# Conversion operations on data and time
data$Date = as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
dateTime <- paste0(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")
delete <- c("Date","Time")
data <- data[ ,!(names(data) %in% delete)]
data <- cbind(dateTime, data)
data$dateTime <- as.POSIXct(dateTime)