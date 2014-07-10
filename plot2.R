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

#initialize font size of entire graphic
par(cex=0.8)

##Create the plot making changes to the x-axis and main title and color
##histogram to red
plot(PowerData$DateTime,PowerData$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

##Create a png graphics device and output the plot
dev.copy(png,file="plot2.png")

##Close the png graphics device
dev.off()