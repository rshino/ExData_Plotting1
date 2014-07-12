# plot1.R
# Plots a histogram of Global Active power for 2/1/2007-2/2/2007
#
# setwd("/nfs-thecus/home/shino/Dropbox/R-programs/04. Exploratory Data Analysis/Project 01")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data 
# from just those dates rather than reading in the entire dataset and subsetting to those dates.


plot1<-function(){

# READ THE DATA
    
dataDir<-"./UCIMLRdata"
if(!file.exists(dataDir)){
    dataDir<-"."
}
dataFile<-"household_power_consumption.txt"
options( StringsAsFactors=F ) 
consumption<-read.csv(paste(dataDir,dataFile,sep="/"),sep=";",stringsAsFactors=FALSE)

# CREATE DATE/TIME INDEX

consumption["DateTime"]<-as.POSIXct(strptime(paste(consumption[,"Date"], consumption[,"Time"]),"%d/%m/%Y %H:%M:%S"))

# filter to only include 2007-02-01 and 2007-02-02.
consumption_sample<-consumption[consumption$DateTime>=as.POSIXct("2007-02-01 00:00:00") & consumption$DateTime<as.POSIXct("2007-02-03 00:00:00"),]

# convert strings into doubles

consumption_sample$Global_active_power<-as.numeric(as.character(consumption_sample$Global_active_power))
consumption_sample$Sub_metering_1<-as.numeric(as.character(consumption_sample$Sub_metering_1))
consumption_sample$Sub_metering_2<-as.numeric(as.character(consumption_sample$Sub_metering_2))
consumption_sample$Sub_metering_3<-as.numeric(as.character(consumption_sample$Sub_metering_3))
consumption_sample$Voltage<-as.numeric(as.character(consumption_sample$Voltage))
consumption_sample$Global_reactive_power<-as.numeric(as.character(consumption_sample$Global_reactive_power))

# PLOT

hist(consumption_sample$Global_active_power, 
     col="Red",main="Global Active Power", xlab = "Global Active Power (kilowatts)")

# copy plot to PNG

dev.print(device=png,file = "plot1.png",width=480,height=480)
dev.off()
}
#
