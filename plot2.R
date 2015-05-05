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


#PLOT 1 
#hist(power$globalactivepower,
#     xlab="Global Active Power (kilowatts)",
#     ylab="Frequency",
#     col="red",
#     main="Global Active Power"
#)
#dev.copy(png, file = "plot1.png", width=480, height=480) 
#dev.off()

#creating a special weekday column (monday, tuesday...)
power$Day <- format(power$Time, format="%A")

#PLOT 2
plot(x=power$Time, y=power$globalactivepower, type="l",
     xlab="", ylab="Global Active Power (killowatts)")
dev.copy(png, file = "plot2.png", width=480, height=480) 
dev.off()