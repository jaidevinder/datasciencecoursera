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
plot2 <- function() {
  plot(hpc_subset$Date_Time, hpc_subset$Global_active_power, type = "l",
             ylab = "Global Active Power (kilowatts)", xlab = "")
  dev.copy(png,file="plot2.png",width=480,height=480)
  dev.off()
}
plot2()