# Coursera: Data Science Foundations - Exploratory Data Analysis - Project 1

# Author: William Landers

# Description: 
# Measurements of electric power consumption in one household with
# a one-minute sampling rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.

# Examine how household energy usage varies over a 2-day period in February,2007. 

# Descriptions of the 9 variables in the dataset
# Date: Date in format dd/mm/yyyy

# Time: time in format hh:mm:ss

# Global_active_power: household global minute-averaged active power (in kilowatt)

# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)

# Voltage: minute-averaged voltage (in volt)

# Global_intensity: household global minute-averaged current intensity (in ampere)

# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
# It corresponds to the kitchen, containing mainly a dishwasher, an oven and 
# a microwave (hot plates are not electric but gas powered).

# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
# It corresponds to the laundry room, containing a washing-machine, \
# a tumble-drier, a refrigerator and a light.

# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
# It corresponds to an electric water-heater and an air-conditioner.

# Load packages 
library('data.table')
library('datasets')
setwd('~/Documents/Software/R/Data Science Foundations Using R/Exploratory Data Analysis/Project1')

# Retrieve data
path <- getwd()
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file_path <- file.path(path, 'data.zip')

# Download and unzip only if necessary
if(!file.exists(file.path(path, 'household_power_consumption.txt'))) {
  download.file(url, file_path)
  unzip(zipfile = file_path, exdir = path)
}

data_dt <- data.table::fread(input = 'household_power_consumption.txt', 
                             na.strings='?')

# Prevent scientific notation
data_dt[, Global_active_power := as.numeric(Global_active_power)]

# Create POSIXct date_time column for filtering and graphing by time of day
# paste(Date, Time): Combines the Date and Time columns into a single string 
# for conversion to POSIXct
data_dt[, date_time := as.POSIXct(paste(Date, Time), format = '%d/%m/%Y %H:%M:%S')]

# Filter date_time for specific date range
filtered_dt <- data_dt[date_time >= as.POSIXct('2007-02-01') & date_time < as.POSIXct('2007-02-02')]
print(nrow(filtered_dt))

# Check for NA values in date_time and Global_active_power
sum(is.na(filtered_dt$date_time))
sum(is.na(filtered_dt$Global_active_power))

# Filter out rows with NA
filtered_dt <- filtered_dt[!is.na(date_time) & !is.na(Global_active_power)]

png(file='plot2.png', width=480, height=480)

with(filtered_dt, plot(date_time, 
                       Global_active_power, 
                       type = 'l',
                       xlab = '',
                       ylab = 'Global Active Power (kilowatts)'))

dev.off()
