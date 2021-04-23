## 0. Install Packages & Load libraries

install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

## 1. Set Working Directory

setwd("/Users/ussadethlo/Desktop/DSTR/datasciencecoursera-repo/ExData_Plotting1") 

## 2. Download File and Unzip

zip_file <- download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'household_power_consumption.zip')
unzip(zipfile = "household_power_consumption.zip", exdir = "/Users/ussadethlo/Desktop/DSTR/datasciencecoursera-repo/ExData_Plotting1/household_power_consumption")

## 3. Read in file

hpc <- read.table("./household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE)

## 4. Prepare dataset for plot creation

hpc$Date  <- as.Date(hpc$Date, format = "%d/%m/%Y") ## Change to Date class

hpc_sub <- hpc %>%
  subset(Date >= "2007-02-01" & Date <= "2007-02-02") %>% ## Subset to specified date range
  Date_Time <- paste(Date, Time) ## Concatenate Date_Time columns, remove original columns

hpc_sub$DateTime <- as.POSIXct(Date_Time) ## Change Date_Time Class

for (i in 2:8)
  hpc_sub[, i] <- as.numeric(hpc_sub[, i]) ## Change Remaining Columns to Numeric Class

## 5. Create Plot 3

plot(hpc_sub$Sub_metering_1 ~ hpc_sub$Date_Time, ylab = "Energy sub metering", xlab = "", type = "l")
lines(hpc_sub$Sub_metering_2 ~ hpc_sub$Date_Time, col = 'Red')
lines(hpc_sub$Sub_metering_3 ~ hpc_sub$Date_Time, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

## 6. Write Plot as .png image file with 480 x 480 pixels in working directory

png(filename="plot3.png", width = 480, height = 480, units = "px")
plot(hpc_sub$Sub_metering_1 ~ hpc_sub$Date_Time, ylab = "Energy sub metering", xlab = "", type = "l")
lines(hpc_sub$Sub_metering_2 ~ hpc_sub$Date_Time, col = 'Red')
lines(hpc_sub$Sub_metering_3 ~ hpc_sub$Date_Time, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
dev.off()