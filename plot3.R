Sys.setlocale("LC_TIME", "English")
con<-file("household_power_consumption.txt")
open(con)

#Getting only good rows
#2007-02-01  # first lign 66638
#and 2007-02-02 #last lign 69517
# 69517-66638 = 2879
myColNames <-  c("date","time","globalactivepower","globalreactivepower", "voltage",
              "globalintensity","submetering1","submetering2","submetering3")
myColClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
power <- read.table(con,skip=66637,nrow=2880, sep = ";", col.names = myColNames, na.strings="?",
                    colClasses=myColClasses) 
#155874 ?


#changing 1st column to date
power[,1] <- as.Date(power[,1], format="%d/%m/%Y")

#creating a special Time column (like a timestamp)
power$Time <- paste(power[,1], power[,2], sep="_")
power$Time <- strptime(power$Time, format="%Y-%m-%d_%H:%M:%S")


# PLOT 1 
# hist(power$globalactivepower,
     # xlab="Global Active Power (kilowatts)",
     # ylab="Frequency",
     # col="red",
     # main="Global Active Power"
# )
# dev.copy(png, file = "plot1.png", width=480, height=480) 
# dev.off()

# creating a special weekday column (monday, tuesday...)
# power$Day <- format(power$Time, format="%A")

# PLOT 2
# plot(x=power$Time, y=power$globalactivepower, type="l",
     # xlab="", ylab="Global Active Power (killowatts)")
# dev.copy(png, file = "plot2.png", width=480, height=480) 
# dev.off()

#PLOT 3
png(file = "plot3.png", width=480, height=480) 
plot(x=power$Time, y=power$submetering1, type="l",
     xlab="", ylab="Energy sub metering" 
)
lines(x=power$Time, y=power$submetering2, type="l", col="red")
lines(x=power$Time, y=power$submetering3, type="l", col="blue")

legend("topright",
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","blue","red"), # gives the legend lines the correct color and width
       legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
)

# dev.copy(png, file = "plot3.png", width=480, height=480) 
dev.off()