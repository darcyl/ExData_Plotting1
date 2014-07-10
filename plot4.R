setwd("C:/Users/Darcy/Documents/Coursera/Explore")

##Capture the table headings from the file
##for some reason header=TRUE when using skip and nrows not picking up header
Headers<-read.table("household_power_consumption.txt",sep=";",nrows=1,header=TRUE)

##Now grab just the data for Feb 1 and 2 2007
PowerData<-read.table("household_power_consumption.txt",sep=";",skip=66637,nrows=2880,na.strings = "?",stringsAsFactors=FALSE)

##Apply the colnames from the Headers data.frame to the set of data we care about
colnames(PowerData)<-colnames(Headers)

##Create a new column containing the date and time as a datetime type
PowerData$DateTime<-paste(PowerData$Date,PowerData$Time,sep=" ")
PowerData$DateTime<-as.POSIXct(PowerData$DateTime, format="%d/%m/%Y %H:%M:%S")
PowerData$WeekDay <- weekdays(PowerData$DateTime)

##Setup for 4 plots (columnwise fill) on single view
par(mfcol=c(2,2))
par(cex=0.6)

##top left plot
plot(PowerData$DateTime,PowerData$Global_active_power,type="l",ylab="Global Active Power",xlab="")

##bottom left plot
plot(x=PowerData$DateTime,y=PowerData$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(PowerData$DateTime,PowerData$Sub_metering_2,col="red")
lines(PowerData$DateTime,PowerData$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),bty="n")

##top right plot
plot(x=PowerData$DateTime,y=PowerData$Voltage,type="l",ylab="Voltage",xlab="datetime")

##bottom right plot
plot(x=PowerData$DateTime,y=PowerData$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

##Create a png graphics device and output the plot
dev.copy(png,file="plot4.png")

##Close the png graphics device
dev.off()