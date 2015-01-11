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
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

# Create the plot
plot(data$Global_active_power~data$Datetime, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

# Close the device
dev.off()

