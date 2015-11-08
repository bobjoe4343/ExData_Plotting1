plot1 <- function() {
  
  ## Load the SQLDF library for easier filtering of the text file
  
      library("sqldf")
  
  ## Set the name of source file that was downloaded from:
  ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  
      file_name <- "household_power_consumption.txt"
  
  ## Read in the data with the appropriate filter
  
      data <- read.csv.sql(file_name, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")
      
  ## Format the dates
  
      data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %T") 
      data <- transform(data, Date = as.Date(Date, "%d/%m/%Y"))
  
  ## Open the correct graphics device and save the plot
  
      png(file = "plot1.png", width = 480, height = 480, units = "px")
      
      with(data, hist(data[,3], col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)"))
      
      dev.off()
  
}