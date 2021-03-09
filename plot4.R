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

# Transforming the Date and Time Variables from characters into objects of type Date and POSIXlt
# respectively.

Filtered_house_power_consumption$Date <- as.Date(Filtered_house_power_consumption$Date, 
                                                 format = "%d%m%Y")
Filtered_house_power_consumption$Time <- strptime(Filtered_house_power_consumption$Time, 
                                                  format = "%H:%M:%S")
Filtered_house_power_consumption[1:1440, "Time"] <- format(Filtered_house_power_consumption[1:1440,
                                                    "Time"], "2007-02-01 %H:%M:%S")

Filtered_house_power_consumption[1441:2880, "Time"] <- format(Filtered_house_power_consumption[1441:2880,
                                                       "Time"], "2007-02-02 %H:%M:%S")

# TO Create a composite plot of 2*2

par(mfcol = c(2,2))

# Change the screen device to PNG file and Save in a PNG file

dev.copy(png, file = "plot4.png", width = 480, height = 480)

# Plots

## 1st Plot
plot(Filtered_house_power_consumption$Time, as.numeric(as.character
    (Filtered_house_power_consumption$Global_active_power)), type = "l", xlab = "", ylab = 
     "Global Active Power")

## 2nd Plot
plot(Filtered_house_power_consumption$Time, as.numeric(as.character(Filtered_house_power_consumption$Sub_metering_1)), 
     type = "l", xlab = "", ylab = "Energy sub metering")
with(Filtered_house_power_consumption, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
with(Filtered_house_power_consumption, lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",
                   "Sub_metering_3"), lty = 1, lwd = 1.5, cex = 0.9, bty = "n")
## 3rd Plot
plot(Filtered_house_power_consumption$Time, as.numeric(as.character(Filtered_house_power_consumption$Voltage)),
     type = "l", xlab = "datetime", ylab = "Voltage")

## 4th Plot
plot(Filtered_house_power_consumption$Time, as.numeric(as.character
    (Filtered_house_power_consumption$Global_reactive_power)),type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")


# Close the PNG Device
dev.off()
