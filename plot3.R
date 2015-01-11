# Download and unzip data
destfile <- "./exdata_data_household_power_consumption.zip"
if (!file.exists(destfile)){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile=destfile, method="curl")
}

# Read and subset input data
unzip(destfile, exdir="./data/")
alldata <- read.csv("./data/household_power_consumption.txt",sep=";",na.strings="?")
alldata$Date <- strptime(alldata$Date, format="%d/%m/%Y")
data <- subset(alldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates
datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

# Open png device
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

# Create the plot
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       xlab="", ylab="Energy sub metering",
       ylim=c(0,40))
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Close the device
dev.off()
