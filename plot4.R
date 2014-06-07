library(reshape)
inputFile <- "household_power_consumption.txt"
if (!file.exists(inputFile)) {
  if (!file.exists("exdata-data-household_power_consumption.zip")) {
    stop("was expecting house hold power consumption data in the working directory or its zip file")
  } else {
    unzip("exdata-data-household_power_consumption.zip")
  }
}

dataset <- read.table(file=inputFile,header=TRUE,sep=";",na.strings="?")

subsetData <- dataset[dataset$Date %in% c('1/2/2007', '2/2/2007'),]
rm(dataset)
subsetData$datetime <- as.POSIXct( strptime(paste(subsetData$Date, subsetData$Time), "%d/%m/%Y %H:%M:%S"))  
reqData = subset(x=subsetData, select=c(datetime,Sub_metering_1,Sub_metering_2,Sub_metering_3))
meltData <- melt(reqData, id= c("datetime"))

# Plot4
png("plot4.png",bg="white")
par(mfrow=c(2,2))
plot( subsetData$datetime, as.numeric( subsetData$Global_active_power ), type="l", ylab="Global Active Power", xlab ="")
plot( subsetData$datetime, as.numeric( subsetData$Voltage ), type="l", ylab="Voltage", xlab ="datetime")
plot(meltData$datetime, meltData$value, type ="n", xlab="", ylab="Energy sub metering")
lines(meltData$datetime[meltData$variable=="Sub_metering_1"], meltData$value[meltData$variable=="Sub_metering_1"], col="black" )
lines(meltData$datetime[meltData$variable=="Sub_metering_2"], meltData$value[meltData$variable=="Sub_metering_2"], col="red" )
lines(meltData$datetime[meltData$variable=="Sub_metering_3"], meltData$value[meltData$variable=="Sub_metering_3"], col="blue" )
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")
plot( subsetData$datetime, as.numeric( subsetData$Global_reactive_power ), type="l", ylab="Global_reactive_power", xlab ="datetime")
dev.off()
getwd()
rm(subsetData)
rm(reqData)
rm(meltData)