
# function to plot a histogram to depict global active power usage in KW
plot1 <- function(src = "household_power_consumption.txt")
{
    # check if the source exists in the current working directory
    if (!file.exists(src))
        stop(paste(src, " file doesnt exist"))
    
    # read data into data frame
    DT <- read.table("household_power_consumption.txt", sep=";", 
                     stringsAsFactors=FALSE, na.strings="?", header = TRUE)    
    
    # filter based on required dates
    DT <- DT[as.Date(DT$Date, "%d/%m/%Y") == as.Date("2007-02-01", "%Y-%m-%d") |
             as.Date(DT$Date, "%d/%m/%Y") == as.Date("2007-02-02", "%Y-%m-%d"),]
    
    # open PNG device with req width and height
    png("plot1.png", width = 480, height=480)
    
    hist(DT$Global_active_power, col="red", main = "Global Active Power",
         xlab = "Global Active Power(kilowatts)")
    
    dev.off()
}