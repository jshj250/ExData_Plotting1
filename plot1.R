# Read the dataset from the text file
power <- read.table("household_power_consumption.txt", header=T, sep=";",
                    na.strings="?", skip=66636, nrows=2880)

# Rename the column name of dataset 'power'
colnames(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                     "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Get the first glance of the dataset
summary(power)
str(power)
# Note: There are no missing values in this dataset

# Convert the element 'Data' and 'Time' into Date/Time classes in R 
Data_Time <- paste(power$Date, power$Time)
power$Date <- as.Date(power$Date, format="%d/%m/%Y")             # Date
power$Time <- strptime(Data_Time, format="%d/%m/%Y %H:%M:%S")    # Time

# Plot the histogram of household global active power
hist(power$Global_active_power,col="red",xlab="Global Active Power (kilowatt)",main="Global Active Power")

# # Construct the plot and save it to a PNG file 
dev.copy(png, file="plot1.png", width=480, height=480) # Copy the plot to a PNG file
dev.off()                                              # Close the PNG device