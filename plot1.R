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

# Reformat Date column as type Date
data_dt[, Date := as.Date(Date, format = '%d/%m/%Y')]
# head(data_dt)

# Filter Date for specific date range
filtered_dt <- data_dt[Date >= as.Date('2007-02-01') & Date < as.Date('2007-02-02')]
# head(filtered_data)

# Prevent scientific notation
filtered_dt[, Global_active_power := as.numeric(Global_active_power)]

png(file='plot1.png', width=480, height=480)

hist(filtered_dt[['Global_active_power']], 
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency',
     col = 'red')

dev.off()





