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

print("Plotting graph")
png("./plot1.png",  width = 480, height = 480, units = "px")
hist(dat$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()