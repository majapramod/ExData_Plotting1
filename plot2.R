
inputFile <- "household_power_consumption.txt"
if (!file.exists(inputFile)) {
  if (!file.exists("exdata-data-household_power_consumption.zip")) {
    stop("was expecting house hold power consumption data in the working directory or its zip file")
  } else {
    unzip("exdata-data-household_power_consumption.zip")
  }
}
#list.files()
#
dataset <- read.table(file=inputFile,header=TRUE,sep=";",na.strings="?")

#head(dataset)


#str(dataset)
subsetData <- dataset[dataset$Date %in% c('1/2/2007', '2/2/2007'),]
rm(dataset)

subsetData$datetime <- as.POSIXct( strptime(paste(subsetData$Date, subsetData$Time), "%d/%m/%Y %H:%M:%S"))  


# Plot2
png("plot2.png",bg="white")
plot( subsetData$datetime, as.numeric( subsetData$Global_active_power ), type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
rm(subsetData)