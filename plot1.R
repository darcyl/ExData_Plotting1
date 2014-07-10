setwd("C:/Users/Darcy/Documents/Coursera/Explore")

##Capture the table headings from the file
##for some reason header=TRUE when using skip and nrows not picking up header
Headers<-read.table("household_power_consumption.txt",sep=";",nrows=1,header=TRUE)

##Now grab just the data for Feb 1 and 2 2007
PowerData<-read.table("household_power_consumption.txt",sep=";",skip=66637,nrows=2880,na.strings = "?")

##Apply the colnames from the Headers data.frame to the set of data we care about
colnames(PowerData)<-colnames(Headers)

#initialize font size of entire graphic
par(cex=0.8)

##Create the plot making changes to the x-axis and main title and color
##histogram to red
hist(PowerData$Global_active_power,col="red1",xlab="Global Active Power (kilowatts)",main="Global Active Power")

##Create a png graphics device and output the plot
dev.copy(png,file="plot1.png")

##Close the png graphics device
dev.off()