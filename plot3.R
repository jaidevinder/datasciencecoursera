##Download raw data
download <- 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "temp")
unzip("temp")
unlink("temp")

## Read Data
hpc <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
hpc_subset <- hpc[hpc$Date == "2/2/2007" | hpc$Date == "1/2/2007",]
hpc_subset$Date_Time <- strptime(paste(hpc_subset$Date, hpc_subset$Time, sep = " "), 
                                 "%d/%m/%Y %H:%M:%S")

## Plotting Functions
plot3 <- function() {
  plot(hpc_subset$Date_Time, hpc_subset$Sub_metering_1, type = "l", 
                              xlab = "", ylab = "Energy sub metering")
  points(hpc_subset$Date_Time, hpc_subset$Sub_metering_2, type = "l", col = "red")
  
  points(hpc_subset$Date_Time, hpc_subset$Sub_metering_3, type = "l", col = "blue")
  
  legend("topright", lty = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),ncol = 1,cex=0.50)
  dev.copy(png,file="plot3.png",width=680,height=680)
  dev.off()
}
plot3()