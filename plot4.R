# plot4.R
# graphs 4 plots on the same diagram from 2/1 and 2/2/2007 data, including 2 graphs previously plotted.
#
# setwd("/nfs-thecus/home/shino/Dropbox/R-programs/04. Exploratory Data Analysis/Project 01")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data 
# from just those dates rather than reading in the entire dataset and subsetting to those dates.


plot4<-function(){
    
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

par(mfrow = c(2,2),cex=0.65)
# plot 1
plot(Global_active_power ~ DateTime, consumption_sample, type="l",xlab="",ylab="Global Active Power")
#plot 2
plot(Voltage ~ DateTime, consumption_sample, type="l",xlab="datetime",ylab="Voltage")

#plot 3
plot(Sub_metering_1 ~ DateTime, consumption_sample, type="l",xlab="",ylab="Energy sub metering",col="black")
lines(consumption_sample$DateTime, consumption_sample$Sub_metering_2,col="red")
lines(consumption_sample$DateTime, consumption_sample$Sub_metering_3,col="blue")
legend('topright', bty="n",cex=0.75,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
lty=c(1,1,1), # gives the legend appropriate symbols (lines)
lwd=c(2.5,2.5,2.5),col=c("black","red","blue")) # gives the legend lines the correct color and width

#plot 4
plot(Global_reactive_power ~ DateTime, consumption_sample, type="l",xlab="datetime")

# copy plot to PNG

dev.print(device=png,file = "plot4.png",width=480,height=480)
dev.off()
}
#
