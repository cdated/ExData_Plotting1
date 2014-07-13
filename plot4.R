zip_file = "./household_power_consumption.zip"
data_file = "./household_power_consumption.txt"
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

if (!file.exists(data_file))
{
  if (!file.exists(zip_file))
  {
    print(paste("Downloading ", url))
    download.file(url,zip_file)
  }
  
  print(paste("Unzipping ", zip_file))
  unzip(zip_file)
}

print("Reading power comsumption data into R")
grep_cmd = paste('grep "^[12]/2/2007"', data_file)
dat <- read.table(pipe(grep_cmd),header=F, sep=';')
column_names <- names(read.table(data_file, header=TRUE,sep=";",nrows=1))
colnames(dat) <- column_names

days <- strptime(paste(dat[,1],dat[,2]), "%d/%m/%Y %H:%M")

print("Plotting graph")
png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

# Plot 1
plot(
  days,
  dat$Global_active_power, type="l", 
  xlab="", ylab="Global Active Power"
)

# Plot 2
plot(
  days,
  dat$Voltage, type="l", 
  xlab="datetime", ylab="Voltage"
)

# Plot 3
plot(
  days,
  dat$Sub_metering_1, 
  type="l",  
  xlab="", ylab="Energy sub metering"
)
lines(days, dat$Sub_metering_2, col="red")
lines(days, dat$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")

# Plot 4
plot(
  days,
  dat$Global_reactive_power, type="l", 
  xlab="datetime", ylab="Global_reactive_power"
)

dev.off()