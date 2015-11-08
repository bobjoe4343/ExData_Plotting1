plot4 <- function() {
  
  ## Load the SQLDF library for easier filtering of the text file
  
      library("sqldf")
  
  ## Set the name of source file that was downloaded from:
  ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  
      file_name <- "household_power_consumption.txt"
  
  ## Read in the data with the appropriate filter
  
      data <- read.csv.sql(file_name, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")
  
  ## Format the dates
  
      # create datetime column
      data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %T") 
      
      # format character date as date
      data <- transform(data, Date = as.Date(Date, "%d/%m/%Y"))
  
  ## Open the correct graphics device and save the plot
  
      # Open graphics devicve
      png(file = "plot4.png", width = 480, height = 480, units = "px")
      
      # Set output to 2x2 grid
      par(mfrow = c(2,2))
      
      # graph 1
      with(data, plot(data[,2], data[,3], type="l", ylab = "Global Active Power (killowatts)", xlab = ""))
      
      # grpah 2
      with(data, plot(data[,2], data[,5], type="l", ylab = "Voltage", xlab = "datetime"))
      
      # graph 3
      with(data, plot(data[,2],data[,7], type = "l", xlab = "", ylab = "Energy sub metering"))
      lines(data[,2],data[,8], type = "l", col ="red")
      lines(data[,2],data[,9], type = "l", col ="blue")
      legend('topright', names(data[,6:9])[-1], lty =1, col=c('black','red','blue'), cex=.75)
      
      # graph 4
      with(data, plot(data[,2], data[,4], type="l", ylab = "Global_reactive_power)", xlab = "datetime"))
      
      # turn off graphics device
      dev.off()
  
}