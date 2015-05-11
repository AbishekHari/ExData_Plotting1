
# function to plot a histogram to depict global active power usage in KW
plot4 <- function(src = "household_power_consumption.txt")
{
    # check if the source exists in the current working directory
    if (!file.exists(src))
        stop(src + " file doesnt exist")
    
    # read data into data frame
    DT <- read.table("household_power_consumption.txt", sep=";", 
                     stringsAsFactors=FALSE, na.strings="?", header = TRUE)    
    
    # filter based on required dates
    DT <- DT[as.Date(DT$Date, "%d/%m/%Y") == as.Date("2007-02-01", "%Y-%m-%d") |
                 as.Date(DT$Date, "%d/%m/%Y") == as.Date("2007-02-02", "%Y-%m-%d"),]
    
    # open PNG device with req width and height
    png("plot4.png", width = 480, height=480)
    
    # plot the graph
    par(mfrow = c(2,2))
    
    #1
    datetime <- strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S")
    plot(datetime, DT$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    
    #2
    plot(datetime, DT$Voltage, type="l",ylab="Voltage")
    
    #3
    plot(dtime, DT$Global_active_power, xlab="", ylab="Energy sub metering", 
         type = "n", ylim=c(0,40))
    
    points(dtime, DT$Sub_metering_1, type="l", col="black")
    points(dtime, DT$Sub_metering_2, type="l", col="red")
    points(dtime, DT$Sub_metering_3, type="l", col="blue")
    
    legend("topright", pch = "-", col = c("black", "red", "blue"), bty="n",  
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    
    #plot4
    plot(datetime, DT$Global_reactive_power, type="l")
    dev.off()
}