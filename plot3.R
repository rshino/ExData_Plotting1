# plot3.R
# plots 3 series from 3 sets of metering from 2/1/2007-2/2/2007 observations
#
# setwd("/nfs-thecus/home/shino/Dropbox/R-programs/04. Exploratory Data Analysis/Project 01")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data 
# from just those dates rather than reading in the entire dataset and subsetting to those dates.

# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the 
# strptime() and as.Date() functions.

plot3<-function(){
    

dataDir<-"./UCIMLRdata"
if(!file.exists(dataDir)){
    dataDir<-"."
}
dataFile<-"household_power_consumption.txt"
options( StringsAsFactors=F ) 
consumption<-read.csv(paste(dataDir,dataFile,sep="/"),sep=";",stringsAsFactors=FALSE)

consumption["DateTime"]<-as.POSIXct(strptime(paste(consumption[,"Date"], consumption[,"Time"]),"%d/%m/%Y %H:%M:%S"))

consumption_sample<-consumption[consumption$DateTime>=as.POSIXct("2007-02-01 00:00:00") & consumption$DateTime<as.POSIXct("2007-02-03 00:00:00"),]


# convert strings into doubles

consumption_sample$Global_active_power<-as.numeric(as.character(consumption_sample$Global_active_power))
consumption_sample$Sub_metering_1<-as.numeric(as.character(consumption_sample$Sub_metering_1))
consumption_sample$Sub_metering_2<-as.numeric(as.character(consumption_sample$Sub_metering_2))
consumption_sample$Sub_metering_3<-as.numeric(as.character(consumption_sample$Sub_metering_3))
consumption_sample$Voltage<-as.numeric(as.character(consumption_sample$Voltage))
consumption_sample$Global_reactive_power<-as.numeric(as.character(consumption_sample$Global_reactive_power))

# PLOT

plot(Sub_metering_1 ~ DateTime, consumption_sample, type="l",xlab="",ylab="Energy sub metering",col="black")
lines(consumption_sample$DateTime, consumption_sample$Sub_metering_2,col="red")
lines(consumption_sample$DateTime, consumption_sample$Sub_metering_3,col="blue")
legend('topright',cex=0.75,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue")) # gives the legend lines the correct color and width

# copy plot to PNG

dev.print(device=png,file = "plot3.png",width=480,height=480)
dev.off()
}

#
