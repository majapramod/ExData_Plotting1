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
#nrow(subsetData)
#ncol(subsetData)

#head(subsetData)
#tail(subsetData,5)
#?strptime

subsetData$datetime <- as.POSIXct( strptime(paste(subsetData$Date, subsetData$Time), "%d/%m/%Y %H:%M:%S"))  


# Plot1
png("plot1.png",bg="white")
par(mfrow=c(1,1))
hist(subsetData$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()
rm(subsetData)