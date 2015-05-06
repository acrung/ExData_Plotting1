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

#changing 1st column to date
power[,1] <- as.Date(power[,1], format="%d/%m/%Y")

#creating a special Time column (like a timestamp)
power$Time <- paste(power[,1], power[,2], sep="_")
power$Time <- strptime(power$Time, format="%Y-%m-%d_%H:%M:%S")

#creating a special weekday column (monday, tuesday...)
power$Day <- format(power$Time, format="%A")


png(file = "plot4.png", width=480, height=480) 
par(mfrow=c(2,2))

#PLOT top left
plot(x=power$Time, y=power$globalactivepower, type="l",
     xlab="", ylab="Global Active Power")

#PLOT top right
plot(x=power$Time, y=power$voltage, type="l",
     ylab="Voltage",
     xlab="datetime",
     col="black",
)

#bottom left
plot(x=power$Time, y=power$submetering1, type="l",
     xlab="", ylab="Energy sub metering")
lines(x=power$Time, y=power$submetering2, type="l", col="red")
lines(x=power$Time, y=power$submetering3, type="l", col="blue")

legend("topright",
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","blue","red"), # gives the legend lines the correct color and width
       legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty = "n"
)

#bottom right
plot(x=power$Time, y=power$globalreactivepower, type="l",
     xlab="datetime", ylab="Global_reactive_Power")

 #dev.copy(png, file = "plot4.png", width=480, height=480) 
dev.off()

# Making Plots
# Our overall goal here is simply to examine how household energy usage varies over a 2-day period 
# in February, 2007. Your task is to reconstruct the following plots below, 
# all of which were constructed using the base plotting system.
# 
# First you will need to fork and clone the following GitHub repository: 
#   https://github.com/rdpeng/ExData_Plotting1
# 
# For each plot you should
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file.
# Add the PNG file and R code file to your git repository
# 
# When you are finished with the assignment, push your git repository to GitHub 
# so that the GitHub version of your repository is up to date. 
# There should be four PNG files and four R code files

Sys.setlocale("LC_TIME", "French")