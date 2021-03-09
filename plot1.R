# Checking if the data set in zip file already exists

file <- "exdata_data_household_power_consumption.zip"
if(!file.exists(file)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, file)
}

# checking if folder exists

if(!file.exists("household_power_consumption.txt")){
  unzip(file)
}

# Reading, naming and filtering housing power consumption data

house_power_consumption <- read.table("./household_power_consumption.txt", skip = 1, sep = ";")
names(house_power_consumption) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
      "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

Filtered_house_power_consumption <- subset(house_power_consumption, 
      house_power_consumption$Date == "1/2/2007" | house_power_consumption$Date == "2/2/2007")

# Plot

hist(as.numeric(as.character(Filtered_house_power_consumption$Global_active_power)), col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")

# Save/copy the plot to a PNG file

dev.copy(png, file = "plot1.png", width = 480, height = 480)

# Close the PNG Device
dev.off()
