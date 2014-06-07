library(reshape)

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
reqData = subset(x=subsetData, select=c(datetime,Sub_metering_1,Sub_metering_2,Sub_metering_3))
#head(reqData)

meltData <- melt(reqData, id= c("datetime"))
#head(meltData)
#str(meltData)
#?lines

# Plot3
png("plot3.png",bg="white")
plot(meltData$datetime, meltData$value, type ="n", xlab="", ylab="Energy sub metering")
lines(meltData$datetime[meltData$variable=="Sub_metering_1"], meltData$value[meltData$variable=="Sub_metering_1"], col="black" )
lines(meltData$datetime[meltData$variable=="Sub_metering_2"], meltData$value[meltData$variable=="Sub_metering_2"], col="red" )
lines(meltData$datetime[meltData$variable=="Sub_metering_3"], meltData$value[meltData$variable=="Sub_metering_3"], col="blue" )
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()
rm(subsetData)
rm(reqData)
rm(meltData)