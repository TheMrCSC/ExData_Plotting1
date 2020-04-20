library(dplyr)


#reading data
allData <- read.table(".\\Data\\household_power_consumption.txt", sep = ";"
                      ,header = TRUE)


#cleaning and preparing data
#filtering data for 2 days
reqData <- allData %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        #converting Date field to Date
        mutate(Date = as.Date(strptime(as.character(Date),'%d/%m/%Y'))) %>%
        #Merging and creating Date Time field
        mutate(DateTime = as.POSIXct(as.character(paste(Date, Time)))) %>%
        #converting Global_active_power to numeric
        mutate(Global_active_power = as.numeric(as.character(
                Global_active_power)))


#removing extra large dataset
rm(allData)


#opening PNG file
png("plot2.png",width = 480, height = 480, units = "px")


#creating required plot
with(reqData, plot(DateTime, Global_active_power, type = "l", 
                   ylab = "Global Active Power (kilowatts)", xlab = ""))


#saving and closing PNG file
dev.off()