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


# Open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

# Create the plot
hist(data$Global_active_power, main="Global Active Power",
    xlab="Global Active Power (kilowatts)", ylab="Frequency",
    xlim=c(0,6),ylim=c(0,1200), col="Red")

# Close the device
dev.off()

