
# function to plot a histogram to depict global active power usage in KW
plot3 <- function(src = "household_power_consumption.txt")
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
    png("plot3.png", width = 480, height=480)
    
    #plot 3
    
    dtime <- strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S")
        
    plot(dtime, DT$Global_active_power, xlab="", ylab="Energy sub metering", 
         type = "n", ylim=c(0,40))
    
    points(dtime, DT$Sub_metering_1, type="l", col="black")
    points(dtime, DT$Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red")
    points(dtime, DT$Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue")
    
    legend("topright", pch = "-", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    dev.off()
}