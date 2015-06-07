##This part is common to all plots
#Set language to English (for the dates)
Sys.setlocale(locale="US")
#Remember par settings
par.defaults <- par(no.readonly=TRUE)
#Load the dataframe
household<-read.csv("household_power_consumption.txt", sep=';', header=TRUE)
#Convert it
household[,1:9]<-lapply(household[,1:9], as.character)
household[,3:9]<-lapply(household[,3:9], as.numeric)
#Filter out the unnecesary dates
household<-household[(household$Date=="1/2/2007")|(household$Date=="2/2/2007"),]
#Filter out missing values
household<-household[!is.na(household$Global_active_power),]
#Create a semi - continuous time variable
household$Moment<-as.POSIXct(strptime(paste(household[,1],household[,2]), format="%d/%m/%Y %H:%M:%S"))

##The actual plotting begins

png(filename="plot3.png")

plot(household$Moment, household$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
points(household$Moment, household$Sub_metering_1, type = "l", col = "black")
points(household$Moment, household$Sub_metering_2, type = "l", col = "red")
points(household$Moment, household$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=names(household)[7:9], lty=1, col=c("black", "red", "blue"))
dev.off()
#Restore par settings
par(par.defaults)
rm(par.defaults)