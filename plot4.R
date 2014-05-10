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

par(mfrow=c(2,2))                # Plot in 2x2 panels
Sys.setlocale("LC_TIME", "en")   # Display the time in English

# Plot the time series in the topleft panel - Global Active Power
plot(x=power$Time, y=power$Global_active_power,xlab=NA,ylab="Global Active Power",type="l")

# Plot the time series in the topright panel - Voltage
plot(x=power$Time, y=power$Voltage,xlab="datetime",ylab="Voltage",type="l")

# Plot the time series in the bottomleft panel
plot (x=power$Time, y=power$Sub_metering_1,xlab=NA,ylab="Energy sub metering",type="l") # Plot energy sub-metering No.1
lines(x=power$Time, y=power$Sub_metering_2,col="red")                                   # Plot energy sub-metering No.2
lines(x=power$Time, y=power$Sub_metering_3,col="blue")                                  # Plot energy sub-metering No.3
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"),bty="n")                                        # plot the legend on the topright

# Plot the time series in the bottomleft panel - Global Reactive Power
plot(x=power$Time, y=power$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")

# Construct the plot and save it to a PNG file 
dev.copy(png, file="plot4.png", width=480, height=480) # Copy the plot to a PNG file
dev.off()                                              # Close the PNG device

par(mfrow=c(1,1)) 